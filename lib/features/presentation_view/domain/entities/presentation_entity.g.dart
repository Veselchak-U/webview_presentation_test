// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PresentationEntityCWProxy {
  PresentationEntity id(String id);

  PresentationEntity url(String url);

  PresentationEntity fileName(String fileName);

  PresentationEntity name(String name);

  PresentationEntity fileLength(String? fileLength);

  PresentationEntity previewUrl(String? previewUrl);

  PresentationEntity description(String? description);

  PresentationEntity preparations(String? preparations);

  PresentationEntity status(PresentationStatus? status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PresentationEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PresentationEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  PresentationEntity call({
    String? id,
    String? url,
    String? fileName,
    String? name,
    String? fileLength,
    String? previewUrl,
    String? description,
    String? preparations,
    PresentationStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPresentationEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPresentationEntity.copyWith.fieldName(...)`
class _$PresentationEntityCWProxyImpl implements _$PresentationEntityCWProxy {
  const _$PresentationEntityCWProxyImpl(this._value);

  final PresentationEntity _value;

  @override
  PresentationEntity id(String id) => this(id: id);

  @override
  PresentationEntity url(String url) => this(url: url);

  @override
  PresentationEntity fileName(String fileName) => this(fileName: fileName);

  @override
  PresentationEntity name(String name) => this(name: name);

  @override
  PresentationEntity fileLength(String? fileLength) =>
      this(fileLength: fileLength);

  @override
  PresentationEntity previewUrl(String? previewUrl) =>
      this(previewUrl: previewUrl);

  @override
  PresentationEntity description(String? description) =>
      this(description: description);

  @override
  PresentationEntity preparations(String? preparations) =>
      this(preparations: preparations);

  @override
  PresentationEntity status(PresentationStatus? status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PresentationEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PresentationEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  PresentationEntity call({
    Object? id = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? fileName = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? fileLength = const $CopyWithPlaceholder(),
    Object? previewUrl = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? preparations = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PresentationEntity(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      fileName: fileName == const $CopyWithPlaceholder() || fileName == null
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      fileLength: fileLength == const $CopyWithPlaceholder()
          ? _value.fileLength
          // ignore: cast_nullable_to_non_nullable
          : fileLength as String?,
      previewUrl: previewUrl == const $CopyWithPlaceholder()
          ? _value.previewUrl
          // ignore: cast_nullable_to_non_nullable
          : previewUrl as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      preparations: preparations == const $CopyWithPlaceholder()
          ? _value.preparations
          // ignore: cast_nullable_to_non_nullable
          : preparations as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PresentationStatus?,
    );
  }
}

extension $PresentationEntityCopyWith on PresentationEntity {
  /// Returns a callable class that can be used as follows: `instanceOfPresentationEntity.copyWith(...)` or like so:`instanceOfPresentationEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PresentationEntityCWProxy get copyWith =>
      _$PresentationEntityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresentationEntity _$PresentationEntityFromJson(Map<String, dynamic> json) =>
    PresentationEntity(
      id: json['id'] as String,
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      name: json['name'] as String,
      fileLength: json['fileLength'] as String?,
      previewUrl: json['previewUrl'] as String?,
      description: json['description'] as String?,
      preparations: json['preparations'] as String?,
      status: json['status'] == null
          ? null
          : PresentationStatus.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PresentationEntityToJson(PresentationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'fileName': instance.fileName,
      'name': instance.name,
      'fileLength': instance.fileLength,
      'previewUrl': instance.previewUrl,
      'description': instance.description,
      'preparations': instance.preparations,
      'status': instance.status?.toJson(),
    };
