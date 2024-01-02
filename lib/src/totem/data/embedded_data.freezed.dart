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
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get updatedOn => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get startAt => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get endAt => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint get position => throw _privateConstructorUsedError;

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
      {String name,
      String id,
      String requestId,
      int count,
      @MyDateTimeConverter() DateTime updatedOn,
      @MyDateTimeConverter() DateTime startAt,
      @MyDateTimeConverter() DateTime endAt,
      @GeoPointConverter() GeoPoint position});
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
    Object? name = null,
    Object? id = null,
    Object? requestId = null,
    Object? count = null,
    Object? updatedOn = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
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
      {String name,
      String id,
      String requestId,
      int count,
      @MyDateTimeConverter() DateTime updatedOn,
      @MyDateTimeConverter() DateTime startAt,
      @MyDateTimeConverter() DateTime endAt,
      @GeoPointConverter() GeoPoint position});
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
    Object? name = null,
    Object? id = null,
    Object? requestId = null,
    Object? count = null,
    Object? updatedOn = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? position = null,
  }) {
    return _then(_$EmbeddedDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmbeddedDataImpl implements _EmbeddedData {
  const _$EmbeddedDataImpl(
      {required this.name,
      required this.id,
      required this.requestId,
      this.count = 0,
      @MyDateTimeConverter() required this.updatedOn,
      @MyDateTimeConverter() required this.startAt,
      @MyDateTimeConverter() required this.endAt,
      @GeoPointConverter() required this.position});

  factory _$EmbeddedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedDataImplFromJson(json);

  @override
  final String name;
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
  @MyDateTimeConverter()
  final DateTime startAt;
  @override
  @MyDateTimeConverter()
  final DateTime endAt;
  @override
  @GeoPointConverter()
  final GeoPoint position;

  @override
  String toString() {
    return 'EmbeddedData(name: $name, id: $id, requestId: $requestId, count: $count, updatedOn: $updatedOn, startAt: $startAt, endAt: $endAt, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, requestId, count,
      updatedOn, startAt, endAt, position);

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
          {required final String name,
          required final String id,
          required final String requestId,
          final int count,
          @MyDateTimeConverter() required final DateTime updatedOn,
          @MyDateTimeConverter() required final DateTime startAt,
          @MyDateTimeConverter() required final DateTime endAt,
          @GeoPointConverter() required final GeoPoint position}) =
      _$EmbeddedDataImpl;

  factory _EmbeddedData.fromJson(Map<String, dynamic> json) =
      _$EmbeddedDataImpl.fromJson;

  @override
  String get name;
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
  @MyDateTimeConverter()
  DateTime get startAt;
  @override
  @MyDateTimeConverter()
  DateTime get endAt;
  @override
  @GeoPointConverter()
  GeoPoint get position;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedDataImplCopyWith<_$EmbeddedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
