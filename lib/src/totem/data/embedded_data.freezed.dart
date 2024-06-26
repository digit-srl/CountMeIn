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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmbeddedData _$EmbeddedDataFromJson(Map<String, dynamic> json) {
  return _EmbeddedData.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedData {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  String? get eventName => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get sessionName => throw _privateConstructorUsedError;
  int get radius => throw _privateConstructorUsedError;
  bool get isStatic => throw _privateConstructorUsedError;
  bool get dedicated => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get updatedOn => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get position => throw _privateConstructorUsedError;

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
      String? requestId,
      String? eventName,
      String? eventId,
      String? sessionId,
      String? sessionName,
      int radius,
      bool isStatic,
      bool dedicated,
      int count,
      int totalCount,
      @MyDateTimeConverter() DateTime updatedOn,
      @MyDateTimeConverter() DateTime? createdAt,
      @GeoPointConverter() GeoPoint? position});
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
    Object? requestId = freezed,
    Object? eventName = freezed,
    Object? eventId = freezed,
    Object? sessionId = freezed,
    Object? sessionName = freezed,
    Object? radius = null,
    Object? isStatic = null,
    Object? dedicated = null,
    Object? count = null,
    Object? totalCount = null,
    Object? updatedOn = null,
    Object? createdAt = freezed,
    Object? position = freezed,
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
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionName: freezed == sessionName
          ? _value.sessionName
          : sessionName // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      isStatic: null == isStatic
          ? _value.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      dedicated: null == dedicated
          ? _value.dedicated
          : dedicated // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedOn: null == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
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
      String? requestId,
      String? eventName,
      String? eventId,
      String? sessionId,
      String? sessionName,
      int radius,
      bool isStatic,
      bool dedicated,
      int count,
      int totalCount,
      @MyDateTimeConverter() DateTime updatedOn,
      @MyDateTimeConverter() DateTime? createdAt,
      @GeoPointConverter() GeoPoint? position});
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
    Object? requestId = freezed,
    Object? eventName = freezed,
    Object? eventId = freezed,
    Object? sessionId = freezed,
    Object? sessionName = freezed,
    Object? radius = null,
    Object? isStatic = null,
    Object? dedicated = null,
    Object? count = null,
    Object? totalCount = null,
    Object? updatedOn = null,
    Object? createdAt = freezed,
    Object? position = freezed,
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
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionName: freezed == sessionName
          ? _value.sessionName
          : sessionName // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      isStatic: null == isStatic
          ? _value.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      dedicated: null == dedicated
          ? _value.dedicated
          : dedicated // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedOn: null == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmbeddedDataImpl implements _EmbeddedData {
  const _$EmbeddedDataImpl(
      {required this.name,
      required this.id,
      this.requestId,
      this.eventName,
      this.eventId,
      this.sessionId,
      this.sessionName,
      required this.radius,
      this.isStatic = false,
      this.dedicated = false,
      this.count = 0,
      this.totalCount = 0,
      @MyDateTimeConverter() required this.updatedOn,
      @MyDateTimeConverter() this.createdAt,
      @GeoPointConverter() this.position});

  factory _$EmbeddedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedDataImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final String? requestId;
  @override
  final String? eventName;
  @override
  final String? eventId;
  @override
  final String? sessionId;
  @override
  final String? sessionName;
  @override
  final int radius;
  @override
  @JsonKey()
  final bool isStatic;
  @override
  @JsonKey()
  final bool dedicated;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @MyDateTimeConverter()
  final DateTime updatedOn;
  @override
  @MyDateTimeConverter()
  final DateTime? createdAt;
  @override
  @GeoPointConverter()
  final GeoPoint? position;

  @override
  String toString() {
    return 'EmbeddedData(name: $name, id: $id, requestId: $requestId, eventName: $eventName, eventId: $eventId, sessionId: $sessionId, sessionName: $sessionName, radius: $radius, isStatic: $isStatic, dedicated: $dedicated, count: $count, totalCount: $totalCount, updatedOn: $updatedOn, createdAt: $createdAt, position: $position)';
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
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.sessionName, sessionName) ||
                other.sessionName == sessionName) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            (identical(other.dedicated, dedicated) ||
                other.dedicated == dedicated) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      requestId,
      eventName,
      eventId,
      sessionId,
      sessionName,
      radius,
      isStatic,
      dedicated,
      count,
      totalCount,
      updatedOn,
      createdAt,
      position);

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
      final String? requestId,
      final String? eventName,
      final String? eventId,
      final String? sessionId,
      final String? sessionName,
      required final int radius,
      final bool isStatic,
      final bool dedicated,
      final int count,
      final int totalCount,
      @MyDateTimeConverter() required final DateTime updatedOn,
      @MyDateTimeConverter() final DateTime? createdAt,
      @GeoPointConverter() final GeoPoint? position}) = _$EmbeddedDataImpl;

  factory _EmbeddedData.fromJson(Map<String, dynamic> json) =
      _$EmbeddedDataImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  String? get requestId;
  @override
  String? get eventName;
  @override
  String? get eventId;
  @override
  String? get sessionId;
  @override
  String? get sessionName;
  @override
  int get radius;
  @override
  bool get isStatic;
  @override
  bool get dedicated;
  @override
  int get count;
  @override
  int get totalCount;
  @override
  @MyDateTimeConverter()
  DateTime get updatedOn;
  @override
  @MyDateTimeConverter()
  DateTime? get createdAt;
  @override
  @GeoPointConverter()
  GeoPoint? get position;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedDataImplCopyWith<_$EmbeddedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
