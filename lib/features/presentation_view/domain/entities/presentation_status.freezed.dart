// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presentation_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PresentationStatus _$PresentationStatusFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'notLoaded':
      return _NotLoaded.fromJson(json);
    case 'loaded':
      return _Loaded.fromJson(json);
    case 'unpacked':
      return _Unpacked.fromJson(json);
    case 'ready':
      return _Ready.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PresentationStatus',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PresentationStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notLoaded,
    required TResult Function() loaded,
    required TResult Function() unpacked,
    required TResult Function(String entryPoint) ready,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notLoaded,
    TResult? Function()? loaded,
    TResult? Function()? unpacked,
    TResult? Function(String entryPoint)? ready,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notLoaded,
    TResult Function()? loaded,
    TResult Function()? unpacked,
    TResult Function(String entryPoint)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotLoaded value) notLoaded,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Unpacked value) unpacked,
    required TResult Function(_Ready value) ready,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotLoaded value)? notLoaded,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Unpacked value)? unpacked,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotLoaded value)? notLoaded,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Unpacked value)? unpacked,
    TResult Function(_Ready value)? ready,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentationStatusCopyWith<$Res> {
  factory $PresentationStatusCopyWith(
          PresentationStatus value, $Res Function(PresentationStatus) then) =
      _$PresentationStatusCopyWithImpl<$Res, PresentationStatus>;
}

/// @nodoc
class _$PresentationStatusCopyWithImpl<$Res, $Val extends PresentationStatus>
    implements $PresentationStatusCopyWith<$Res> {
  _$PresentationStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_NotLoadedCopyWith<$Res> {
  factory _$$_NotLoadedCopyWith(
          _$_NotLoaded value, $Res Function(_$_NotLoaded) then) =
      __$$_NotLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NotLoadedCopyWithImpl<$Res>
    extends _$PresentationStatusCopyWithImpl<$Res, _$_NotLoaded>
    implements _$$_NotLoadedCopyWith<$Res> {
  __$$_NotLoadedCopyWithImpl(
      _$_NotLoaded _value, $Res Function(_$_NotLoaded) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_NotLoaded implements _NotLoaded {
  const _$_NotLoaded({final String? $type}) : $type = $type ?? 'notLoaded';

  factory _$_NotLoaded.fromJson(Map<String, dynamic> json) =>
      _$$_NotLoadedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PresentationStatus.notLoaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NotLoaded);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notLoaded,
    required TResult Function() loaded,
    required TResult Function() unpacked,
    required TResult Function(String entryPoint) ready,
    required TResult Function(String message) error,
  }) {
    return notLoaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notLoaded,
    TResult? Function()? loaded,
    TResult? Function()? unpacked,
    TResult? Function(String entryPoint)? ready,
    TResult? Function(String message)? error,
  }) {
    return notLoaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notLoaded,
    TResult Function()? loaded,
    TResult Function()? unpacked,
    TResult Function(String entryPoint)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (notLoaded != null) {
      return notLoaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotLoaded value) notLoaded,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Unpacked value) unpacked,
    required TResult Function(_Ready value) ready,
    required TResult Function(_Error value) error,
  }) {
    return notLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotLoaded value)? notLoaded,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Unpacked value)? unpacked,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_Error value)? error,
  }) {
    return notLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotLoaded value)? notLoaded,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Unpacked value)? unpacked,
    TResult Function(_Ready value)? ready,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (notLoaded != null) {
      return notLoaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotLoadedToJson(
      this,
    );
  }
}

abstract class _NotLoaded implements PresentationStatus {
  const factory _NotLoaded() = _$_NotLoaded;

  factory _NotLoaded.fromJson(Map<String, dynamic> json) =
      _$_NotLoaded.fromJson;
}

/// @nodoc
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res>
    extends _$PresentationStatusCopyWithImpl<$Res, _$_Loaded>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_Loaded implements _Loaded {
  const _$_Loaded({final String? $type}) : $type = $type ?? 'loaded';

  factory _$_Loaded.fromJson(Map<String, dynamic> json) =>
      _$$_LoadedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PresentationStatus.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loaded);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notLoaded,
    required TResult Function() loaded,
    required TResult Function() unpacked,
    required TResult Function(String entryPoint) ready,
    required TResult Function(String message) error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notLoaded,
    TResult? Function()? loaded,
    TResult? Function()? unpacked,
    TResult? Function(String entryPoint)? ready,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notLoaded,
    TResult Function()? loaded,
    TResult Function()? unpacked,
    TResult Function(String entryPoint)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotLoaded value) notLoaded,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Unpacked value) unpacked,
    required TResult Function(_Ready value) ready,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotLoaded value)? notLoaded,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Unpacked value)? unpacked,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotLoaded value)? notLoaded,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Unpacked value)? unpacked,
    TResult Function(_Ready value)? ready,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoadedToJson(
      this,
    );
  }
}

abstract class _Loaded implements PresentationStatus {
  const factory _Loaded() = _$_Loaded;

  factory _Loaded.fromJson(Map<String, dynamic> json) = _$_Loaded.fromJson;
}

/// @nodoc
abstract class _$$_UnpackedCopyWith<$Res> {
  factory _$$_UnpackedCopyWith(
          _$_Unpacked value, $Res Function(_$_Unpacked) then) =
      __$$_UnpackedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnpackedCopyWithImpl<$Res>
    extends _$PresentationStatusCopyWithImpl<$Res, _$_Unpacked>
    implements _$$_UnpackedCopyWith<$Res> {
  __$$_UnpackedCopyWithImpl(
      _$_Unpacked _value, $Res Function(_$_Unpacked) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_Unpacked implements _Unpacked {
  const _$_Unpacked({final String? $type}) : $type = $type ?? 'unpacked';

  factory _$_Unpacked.fromJson(Map<String, dynamic> json) =>
      _$$_UnpackedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PresentationStatus.unpacked()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Unpacked);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notLoaded,
    required TResult Function() loaded,
    required TResult Function() unpacked,
    required TResult Function(String entryPoint) ready,
    required TResult Function(String message) error,
  }) {
    return unpacked();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notLoaded,
    TResult? Function()? loaded,
    TResult? Function()? unpacked,
    TResult? Function(String entryPoint)? ready,
    TResult? Function(String message)? error,
  }) {
    return unpacked?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notLoaded,
    TResult Function()? loaded,
    TResult Function()? unpacked,
    TResult Function(String entryPoint)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (unpacked != null) {
      return unpacked();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotLoaded value) notLoaded,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Unpacked value) unpacked,
    required TResult Function(_Ready value) ready,
    required TResult Function(_Error value) error,
  }) {
    return unpacked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotLoaded value)? notLoaded,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Unpacked value)? unpacked,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_Error value)? error,
  }) {
    return unpacked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotLoaded value)? notLoaded,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Unpacked value)? unpacked,
    TResult Function(_Ready value)? ready,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (unpacked != null) {
      return unpacked(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnpackedToJson(
      this,
    );
  }
}

abstract class _Unpacked implements PresentationStatus {
  const factory _Unpacked() = _$_Unpacked;

  factory _Unpacked.fromJson(Map<String, dynamic> json) = _$_Unpacked.fromJson;
}

/// @nodoc
abstract class _$$_ReadyCopyWith<$Res> {
  factory _$$_ReadyCopyWith(_$_Ready value, $Res Function(_$_Ready) then) =
      __$$_ReadyCopyWithImpl<$Res>;
  @useResult
  $Res call({String entryPoint});
}

/// @nodoc
class __$$_ReadyCopyWithImpl<$Res>
    extends _$PresentationStatusCopyWithImpl<$Res, _$_Ready>
    implements _$$_ReadyCopyWith<$Res> {
  __$$_ReadyCopyWithImpl(_$_Ready _value, $Res Function(_$_Ready) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entryPoint = null,
  }) {
    return _then(_$_Ready(
      null == entryPoint
          ? _value.entryPoint
          : entryPoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ready implements _Ready {
  const _$_Ready(this.entryPoint, {final String? $type})
      : $type = $type ?? 'ready';

  factory _$_Ready.fromJson(Map<String, dynamic> json) =>
      _$$_ReadyFromJson(json);

  @override
  final String entryPoint;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PresentationStatus.ready(entryPoint: $entryPoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ready &&
            (identical(other.entryPoint, entryPoint) ||
                other.entryPoint == entryPoint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, entryPoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReadyCopyWith<_$_Ready> get copyWith =>
      __$$_ReadyCopyWithImpl<_$_Ready>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notLoaded,
    required TResult Function() loaded,
    required TResult Function() unpacked,
    required TResult Function(String entryPoint) ready,
    required TResult Function(String message) error,
  }) {
    return ready(entryPoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notLoaded,
    TResult? Function()? loaded,
    TResult? Function()? unpacked,
    TResult? Function(String entryPoint)? ready,
    TResult? Function(String message)? error,
  }) {
    return ready?.call(entryPoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notLoaded,
    TResult Function()? loaded,
    TResult Function()? unpacked,
    TResult Function(String entryPoint)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(entryPoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotLoaded value) notLoaded,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Unpacked value) unpacked,
    required TResult Function(_Ready value) ready,
    required TResult Function(_Error value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotLoaded value)? notLoaded,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Unpacked value)? unpacked,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_Error value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotLoaded value)? notLoaded,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Unpacked value)? unpacked,
    TResult Function(_Ready value)? ready,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReadyToJson(
      this,
    );
  }
}

abstract class _Ready implements PresentationStatus {
  const factory _Ready(final String entryPoint) = _$_Ready;

  factory _Ready.fromJson(Map<String, dynamic> json) = _$_Ready.fromJson;

  String get entryPoint;
  @JsonKey(ignore: true)
  _$$_ReadyCopyWith<_$_Ready> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$PresentationStatusCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_Error(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Error implements _Error {
  const _$_Error(this.message, {final String? $type})
      : $type = $type ?? 'error';

  factory _$_Error.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorFromJson(json);

  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PresentationStatus.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notLoaded,
    required TResult Function() loaded,
    required TResult Function() unpacked,
    required TResult Function(String entryPoint) ready,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? notLoaded,
    TResult? Function()? loaded,
    TResult? Function()? unpacked,
    TResult? Function(String entryPoint)? ready,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notLoaded,
    TResult Function()? loaded,
    TResult Function()? unpacked,
    TResult Function(String entryPoint)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotLoaded value) notLoaded,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Unpacked value) unpacked,
    required TResult Function(_Ready value) ready,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotLoaded value)? notLoaded,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Unpacked value)? unpacked,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotLoaded value)? notLoaded,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Unpacked value)? unpacked,
    TResult Function(_Ready value)? ready,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorToJson(
      this,
    );
  }
}

abstract class _Error implements PresentationStatus {
  const factory _Error(final String message) = _$_Error;

  factory _Error.fromJson(Map<String, dynamic> json) = _$_Error.fromJson;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
