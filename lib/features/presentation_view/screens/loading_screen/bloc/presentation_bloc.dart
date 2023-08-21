import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/check_presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/get_presentation_paths.dart';

part 'presentation_bloc.freezed.dart';

class PresentationBloc extends Bloc<PresentationEvent, PresentationState> {
  final CheckPresentationStatus checkPresentationStatus;
  final GetPresentationPath getPresentationPaths;

  PresentationBloc({
    required this.checkPresentationStatus,
    required this.getPresentationPaths,
  }) : super(const _Initial()) {
    on<_CheckStatus>(_checkStatus);
  }

  String _basePath = '';
  String _filePath = '';
  String _dirPath = '';

  Future<void> _checkStatus(
    _CheckStatus event,
    Emitter<PresentationState> emit,
  ) async {
    emit(const _Loading());
    try {
      await _initPaths(event.presentation.fileName);
      final status =
          await checkPresentationStatus.checkStatus(_filePath, _dirPath);
      final newPresentation = event.presentation.copyWith(
        status: status,
      );
      emit(_Updated(newPresentation));
    } catch (error) {
      emit(_Failure('$error'));
    }
  }

  Future<void> _initPaths(String fileName) async {
    if (_basePath.isEmpty) {
      final paths = await getPresentationPaths.getAllPaths(fileName);
      _basePath = paths.$1;
      _filePath = paths.$2;
      _dirPath = paths.$3;
    }
  }
}

@freezed
class PresentationEvent with _$PresentationEvent {
  const factory PresentationEvent.checkStatus(PresentationEntity presentation) =
      _CheckStatus;
}

@freezed
class PresentationState with _$PresentationState {
  const factory PresentationState.initial() = _Initial;

  const factory PresentationState.loading() = _Loading;

  const factory PresentationState.updated(PresentationEntity presentation) =
      _Updated;

  const factory PresentationState.failure(String message) = _Failure;
}
