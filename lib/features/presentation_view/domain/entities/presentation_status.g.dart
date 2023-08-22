// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotLoaded _$$_NotLoadedFromJson(Map<String, dynamic> json) => _$_NotLoaded(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_NotLoadedToJson(_$_NotLoaded instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Loaded _$$_LoadedFromJson(Map<String, dynamic> json) => _$_Loaded(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LoadedToJson(_$_Loaded instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Unpacked _$$_UnpackedFromJson(Map<String, dynamic> json) => _$_Unpacked(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UnpackedToJson(_$_Unpacked instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Ready _$$_ReadyFromJson(Map<String, dynamic> json) => _$_Ready(
      json['EntryPoint'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ReadyToJson(_$_Ready instance) => <String, dynamic>{
      'EntryPoint': instance.entryPoint,
      'runtimeType': instance.$type,
    };

_$_Error _$$_ErrorFromJson(Map<String, dynamic> json) => _$_Error(
      json['Message'] as String,
      lastStatus: PresentationStatus.fromJson(
          json['LastStatus'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ErrorToJson(_$_Error instance) => <String, dynamic>{
      'Message': instance.message,
      'LastStatus': instance.lastStatus.toJson(),
      'runtimeType': instance.$type,
    };
