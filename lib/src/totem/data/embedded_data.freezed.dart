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
  int get radius => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get updatedOn => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  String? get eventName => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get sessionName => throw _privateConstructorUsedError;
  bool get isStatic => throw _privateConstructorUsedError;
  bool get dedicated => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get position => throw _privateConstructorUsedError;
  EmbeddedMetaData? get metadata => throw _privateConstructorUsedError;

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
      int radius,
      @MyDateTimeConverter() DateTime updatedOn,
      String? requestId,
      String? eventName,
      String? eventId,
      String? sessionId,
      String? sessionName,
      bool isStatic,
      bool dedicated,
      int count,
      int totalCount,
      @MyDateTimeConverter() DateTime? createdAt,
      @GeoPointConverter() GeoPoint? position,
      EmbeddedMetaData? metadata});

  $EmbeddedMetaDataCopyWith<$Res>? get metadata;
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
    Object? radius = null,
    Object? updatedOn = null,
    Object? requestId = freezed,
    Object? eventName = freezed,
    Object? eventId = freezed,
    Object? sessionId = freezed,
    Object? sessionName = freezed,
    Object? isStatic = null,
    Object? dedicated = null,
    Object? count = null,
    Object? totalCount = null,
    Object? createdAt = freezed,
    Object? position = freezed,
    Object? metadata = freezed,
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
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      updatedOn: null == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as EmbeddedMetaData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EmbeddedMetaDataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $EmbeddedMetaDataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
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
      int radius,
      @MyDateTimeConverter() DateTime updatedOn,
      String? requestId,
      String? eventName,
      String? eventId,
      String? sessionId,
      String? sessionName,
      bool isStatic,
      bool dedicated,
      int count,
      int totalCount,
      @MyDateTimeConverter() DateTime? createdAt,
      @GeoPointConverter() GeoPoint? position,
      EmbeddedMetaData? metadata});

  @override
  $EmbeddedMetaDataCopyWith<$Res>? get metadata;
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
    Object? radius = null,
    Object? updatedOn = null,
    Object? requestId = freezed,
    Object? eventName = freezed,
    Object? eventId = freezed,
    Object? sessionId = freezed,
    Object? sessionName = freezed,
    Object? isStatic = null,
    Object? dedicated = null,
    Object? count = null,
    Object? totalCount = null,
    Object? createdAt = freezed,
    Object? position = freezed,
    Object? metadata = freezed,
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
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as int,
      updatedOn: null == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as EmbeddedMetaData?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$EmbeddedDataImpl implements _EmbeddedData {
  const _$EmbeddedDataImpl(
      {required this.name,
      required this.id,
      required this.radius,
      @MyDateTimeConverter() required this.updatedOn,
      this.requestId,
      this.eventName,
      this.eventId,
      this.sessionId,
      this.sessionName,
      this.isStatic = false,
      this.dedicated = false,
      this.count = 0,
      this.totalCount = 0,
      @MyDateTimeConverter() this.createdAt,
      @GeoPointConverter() this.position,
      this.metadata});

  factory _$EmbeddedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedDataImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final int radius;
  @override
  @MyDateTimeConverter()
  final DateTime updatedOn;
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
  final DateTime? createdAt;
  @override
  @GeoPointConverter()
  final GeoPoint? position;
  @override
  final EmbeddedMetaData? metadata;

  @override
  String toString() {
    return 'EmbeddedData(name: $name, id: $id, radius: $radius, updatedOn: $updatedOn, requestId: $requestId, eventName: $eventName, eventId: $eventId, sessionId: $sessionId, sessionName: $sessionName, isStatic: $isStatic, dedicated: $dedicated, count: $count, totalCount: $totalCount, createdAt: $createdAt, position: $position, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.sessionName, sessionName) ||
                other.sessionName == sessionName) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            (identical(other.dedicated, dedicated) ||
                other.dedicated == dedicated) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      radius,
      updatedOn,
      requestId,
      eventName,
      eventId,
      sessionId,
      sessionName,
      isStatic,
      dedicated,
      count,
      totalCount,
      createdAt,
      position,
      metadata);

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
      required final int radius,
      @MyDateTimeConverter() required final DateTime updatedOn,
      final String? requestId,
      final String? eventName,
      final String? eventId,
      final String? sessionId,
      final String? sessionName,
      final bool isStatic,
      final bool dedicated,
      final int count,
      final int totalCount,
      @MyDateTimeConverter() final DateTime? createdAt,
      @GeoPointConverter() final GeoPoint? position,
      final EmbeddedMetaData? metadata}) = _$EmbeddedDataImpl;

  factory _EmbeddedData.fromJson(Map<String, dynamic> json) =
      _$EmbeddedDataImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  int get radius;
  @override
  @MyDateTimeConverter()
  DateTime get updatedOn;
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
  bool get isStatic;
  @override
  bool get dedicated;
  @override
  int get count;
  @override
  int get totalCount;
  @override
  @MyDateTimeConverter()
  DateTime? get createdAt;
  @override
  @GeoPointConverter()
  GeoPoint? get position;
  @override
  EmbeddedMetaData? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedDataImplCopyWith<_$EmbeddedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmbeddedMetaData _$EmbeddedMetaDataFromJson(Map<String, dynamic> json) {
  return _EmbeddedMetaData.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedMetaData {
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmbeddedMetaDataCopyWith<EmbeddedMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedMetaDataCopyWith<$Res> {
  factory $EmbeddedMetaDataCopyWith(
          EmbeddedMetaData value, $Res Function(EmbeddedMetaData) then) =
      _$EmbeddedMetaDataCopyWithImpl<$Res, EmbeddedMetaData>;
  @useResult
  $Res call({String? email, String? phoneNumber});
}

/// @nodoc
class _$EmbeddedMetaDataCopyWithImpl<$Res, $Val extends EmbeddedMetaData>
    implements $EmbeddedMetaDataCopyWith<$Res> {
  _$EmbeddedMetaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmbeddedMetaDataImplCopyWith<$Res>
    implements $EmbeddedMetaDataCopyWith<$Res> {
  factory _$$EmbeddedMetaDataImplCopyWith(_$EmbeddedMetaDataImpl value,
          $Res Function(_$EmbeddedMetaDataImpl) then) =
      __$$EmbeddedMetaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? phoneNumber});
}

/// @nodoc
class __$$EmbeddedMetaDataImplCopyWithImpl<$Res>
    extends _$EmbeddedMetaDataCopyWithImpl<$Res, _$EmbeddedMetaDataImpl>
    implements _$$EmbeddedMetaDataImplCopyWith<$Res> {
  __$$EmbeddedMetaDataImplCopyWithImpl(_$EmbeddedMetaDataImpl _value,
      $Res Function(_$EmbeddedMetaDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$EmbeddedMetaDataImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$EmbeddedMetaDataImpl implements _EmbeddedMetaData {
  const _$EmbeddedMetaDataImpl({this.email, this.phoneNumber});

  factory _$EmbeddedMetaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedMetaDataImplFromJson(json);

  @override
  final String? email;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'EmbeddedMetaData(email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedMetaDataImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedMetaDataImplCopyWith<_$EmbeddedMetaDataImpl> get copyWith =>
      __$$EmbeddedMetaDataImplCopyWithImpl<_$EmbeddedMetaDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedMetaDataImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedMetaData implements EmbeddedMetaData {
  const factory _EmbeddedMetaData(
      {final String? email,
      final String? phoneNumber}) = _$EmbeddedMetaDataImpl;

  factory _EmbeddedMetaData.fromJson(Map<String, dynamic> json) =
      _$EmbeddedMetaDataImpl.fromJson;

  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$EmbeddedMetaDataImplCopyWith<_$EmbeddedMetaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
