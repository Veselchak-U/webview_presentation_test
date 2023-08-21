import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_status.dart';

part 'presentation_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
@CopyWith()
class PresentationEntity extends Equatable {
  final String id;
  final String url;
  final String fileName;
  final String name;
  final String? fileLength;
  final String? previewUrl;
  final String? description;
  final String? preparations;
  final PresentationStatus? status;

  const PresentationEntity({
    required this.id,
    required this.url,
    required this.fileName,
    required this.name,
    this.fileLength,
    this.previewUrl,
    this.description,
    this.preparations,
    this.status,
  });

  static String serialize(PresentationEntity model) =>
      json.encode(model.toJson());

  static PresentationEntity deserialize(String json) =>
      PresentationEntity.fromJson(jsonDecode(json));

  factory PresentationEntity.fromJson(Map<String, dynamic> json) =>
      _$PresentationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PresentationEntityToJson(this);

  @override
  List<Object?> get props => [id];
}
