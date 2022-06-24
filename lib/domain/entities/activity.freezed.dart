// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @SessionStatusConverter()
  ActivityStatus? get status => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get createdOn => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get requestedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      @SessionStatusConverter() ActivityStatus? status,
      @MyDateTimeConverter() DateTime? createdOn,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res> implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  final Activity _value;
  // ignore: unused_field
  final $Res Function(Activity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? requestedOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActivityStatus?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestedOn: requestedOn == freezed
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_ActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory _$$_ActivityCopyWith(
          _$_Activity value, $Res Function(_$_Activity) then) =
      __$$_ActivityCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      @SessionStatusConverter() ActivityStatus? status,
      @MyDateTimeConverter() DateTime? createdOn,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class __$$_ActivityCopyWithImpl<$Res> extends _$ActivityCopyWithImpl<$Res>
    implements _$$_ActivityCopyWith<$Res> {
  __$$_ActivityCopyWithImpl(
      _$_Activity _value, $Res Function(_$_Activity) _then)
      : super(_value, (v) => _then(v as _$_Activity));

  @override
  _$_Activity get _value => super._value as _$_Activity;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? requestedOn = freezed,
  }) {
    return _then(_$_Activity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActivityStatus?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestedOn: requestedOn == freezed
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Activity implements _Activity {
  const _$_Activity(
      {required this.id,
      required this.name,
      @SessionStatusConverter() this.status,
      @MyDateTimeConverter() this.createdOn,
      @MyDateTimeConverter() required this.requestedOn});

  factory _$_Activity.fromJson(Map<String, dynamic> json) =>
      _$$_ActivityFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @SessionStatusConverter()
  final ActivityStatus? status;
  @override
  @MyDateTimeConverter()
  final DateTime? createdOn;
  @override
  @MyDateTimeConverter()
  final DateTime requestedOn;

  @override
  String toString() {
    return 'Activity(id: $id, name: $name, status: $status, createdOn: $createdOn, requestedOn: $requestedOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Activity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn) &&
            const DeepCollectionEquality()
                .equals(other.requestedOn, requestedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(createdOn),
      const DeepCollectionEquality().hash(requestedOn));

  @JsonKey(ignore: true)
  @override
  _$$_ActivityCopyWith<_$_Activity> get copyWith =>
      __$$_ActivityCopyWithImpl<_$_Activity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivityToJson(this);
  }
}

abstract class _Activity implements Activity {
  const factory _Activity(
          {required final String id,
          required final String name,
          @SessionStatusConverter() final ActivityStatus? status,
          @MyDateTimeConverter() final DateTime? createdOn,
          @MyDateTimeConverter() required final DateTime requestedOn}) =
      _$_Activity;

  factory _Activity.fromJson(Map<String, dynamic> json) = _$_Activity.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @SessionStatusConverter()
  ActivityStatus? get status => throw _privateConstructorUsedError;
  @override
  @MyDateTimeConverter()
  DateTime? get createdOn => throw _privateConstructorUsedError;
  @override
  @MyDateTimeConverter()
  DateTime get requestedOn => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityCopyWith<_$_Activity> get copyWith =>
      throw _privateConstructorUsedError;
}
