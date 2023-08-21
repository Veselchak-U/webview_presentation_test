import 'package:freezed_annotation/freezed_annotation.dart';

part 'presentation_status.freezed.dart';
part 'presentation_status.g.dart';

@freezed
class PresentationStatus with _$PresentationStatus {
  const factory PresentationStatus.notLoaded() = _NotLoaded;

  const factory PresentationStatus.loaded() = _Loaded;

  const factory PresentationStatus.unpacked() = _Unpacked;

  const factory PresentationStatus.ready(String entryPoint) = _Ready;

  const factory PresentationStatus.error(String message) = _Error;

  factory PresentationStatus.fromJson(Map<String, dynamic> json) =>
      _$PresentationStatusFromJson(json);
}
