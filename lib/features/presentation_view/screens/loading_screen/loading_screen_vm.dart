import 'package:flutter/material.dart';
import 'package:presentation_test/features/presentation_view/data/mocks.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/delete_presentation.dart';

class LoadingScreenVm extends ChangeNotifier {
  final DeletePresentation _deletePresentation;

  LoadingScreenVm({
    required DeletePresentation deletePresentation,
  }) : _deletePresentation = deletePresentation;

  Future<void> init(BuildContext context) async {
    _context = context;
    presentations = Mocks().presentationsMock;
  }

  /// Regular properties
  ///

  late final BuildContext _context;
  late final List<PresentationEntity> presentations;

  /// Reactive properties
  ///

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  /// Data methods
  ///

  Future<void> deleteAll() async {
    loading = true;
    try {
      await _deletePresentation.deleteAll();
      _showToast('Удаление завершено');
    } catch (error) {
      _showToast('Ошибка удаления: $error');
    }
    loading = false;
  }

  /// Navigation methods
  ///

  void _showToast(String message) {
    debugPrint('!!! showToast() message: $message');
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
