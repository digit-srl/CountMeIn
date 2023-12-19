// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmbeddedData _$EmbeddedDataFromJson(Map<String, dynamic> json) {
  return _EmbeddedData.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedData {
  String get id => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get updatedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedDataCopyWith<EmbeddedData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedDataCopyWith<$Res> {
  factory $EmbeddedDataCopyWith(
          EmbeddedData value, $Res Function(EmbeddedData) then) =
      _$EmbeddedDataCopyWithImpl<$Res, EmbeddedData>;
  @useResult
  $Res call(
      {String id,
      String requestId,
      int count,
      @MyDateTimeConverter() DateTime updatedOn});
}

/// @nodoc
class _$EmbeddedDataCopyWithImpl<$Res, $Val extends EmbeddedData>
    implements $EmbeddedDataCopyWith<$Res> {
  _$EmbeddedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? count = null,
    Object? updatedOn = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      updatedOn: null == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedDataImplCopyWith<$Res>
    implements $EmbeddedDataCopyWith<$Res> {
  factory _$$EmbeddedDataImplCopyWith(
          _$EmbeddedDataImpl value, $Res Function(_$EmbeddedDataImpl) then) =
      __$$EmbeddedDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String requestId,
      int count,
      @MyDateTimeConverter() DateTime updatedOn});
}

/// @nodoc
class __$$EmbeddedDataImplCopyWithImpl<$Res>
    extends _$EmbeddedDataCopyWithImpl<$Res, _$EmbeddedDataImpl>
    implements _$$EmbeddedDataImplCopyWith<$Res> {
  __$$EmbeddedDataImplCopyWithImpl(
      _$EmbeddedDataImpl _value, $Res Function(_$EmbeddedDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? count = null,
    Object? updatedOn = null,
  }) {
    return _then(_$EmbeddedDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      updatedOn: null == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmbeddedDataImpl implements _EmbeddedData {
  const _$EmbeddedDataImpl(
      {required this.id,
      required this.requestId,
      this.count = 0,
      @MyDateTimeConverter() required this.updatedOn});

  factory _$EmbeddedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedDataImplFromJson(json);

  @override
  final String id;
  @override
  final String requestId;
  @override
  @JsonKey()
  final int count;
  @override
  @MyDateTimeConverter()
  final DateTime updatedOn;

  @override
  String toString() {
    return 'EmbeddedData(id: $id, requestId: $requestId, count: $count, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, requestId, count, updatedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedDataImplCopyWith<_$EmbeddedDataImpl> get copyWith =>
      __$$EmbeddedDataImplCopyWithImpl<_$EmbeddedDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedDataImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedData implements EmbeddedData {
  const factory _EmbeddedData(
          {required final String id,
          required final String requestId,
          final int count,
          @MyDateTimeConverter() required final DateTime updatedOn}) =
      _$EmbeddedDataImpl;

  factory _EmbeddedData.fromJson(Map<String, dynamic> json) =
      _$EmbeddedDataImpl.fromJson;

  @override
  String get id;
  @override
  String get requestId;
  @override
  int get count;
  @override
  @MyDateTimeConverter()
  DateTime get updatedOn;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedDataImplCopyWith<_$EmbeddedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
