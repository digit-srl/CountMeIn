// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'event_ids.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EventIds {
  String get activityId => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventIdsCopyWith<EventIds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventIdsCopyWith<$Res> {
  factory $EventIdsCopyWith(EventIds value, $Res Function(EventIds) then) =
      _$EventIdsCopyWithImpl<$Res>;
  $Res call({String activityId, String eventId});
}

/// @nodoc
class _$EventIdsCopyWithImpl<$Res> implements $EventIdsCopyWith<$Res> {
  _$EventIdsCopyWithImpl(this._value, this._then);

  final EventIds _value;
  // ignore: unused_field
  final $Res Function(EventIds) _then;

  @override
  $Res call({
    Object? activityId = freezed,
    Object? eventId = freezed,
  }) {
    return _then(_value.copyWith(
      activityId: activityId == freezed
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: eventId == freezed
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_EventIdsCopyWith<$Res> implements $EventIdsCopyWith<$Res> {
  factory _$$_EventIdsCopyWith(
          _$_EventIds value, $Res Function(_$_EventIds) then) =
      __$$_EventIdsCopyWithImpl<$Res>;
  @override
  $Res call({String activityId, String eventId});
}

/// @nodoc
class __$$_EventIdsCopyWithImpl<$Res> extends _$EventIdsCopyWithImpl<$Res>
    implements _$$_EventIdsCopyWith<$Res> {
  __$$_EventIdsCopyWithImpl(
      _$_EventIds _value, $Res Function(_$_EventIds) _then)
      : super(_value, (v) => _then(v as _$_EventIds));

  @override
  _$_EventIds get _value => super._value as _$_EventIds;

  @override
  $Res call({
    Object? activityId = freezed,
    Object? eventId = freezed,
  }) {
    return _then(_$_EventIds(
      activityId: activityId == freezed
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: eventId == freezed
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_EventIds implements _EventIds {
  const _$_EventIds({required this.activityId, required this.eventId});

  @override
  final String activityId;
  @override
  final String eventId;

  @override
  String toString() {
    return 'EventIds(activityId: $activityId, eventId: $eventId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventIds &&
            const DeepCollectionEquality()
                .equals(other.activityId, activityId) &&
            const DeepCollectionEquality().equals(other.eventId, eventId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activityId),
      const DeepCollectionEquality().hash(eventId));

  @JsonKey(ignore: true)
  @override
  _$$_EventIdsCopyWith<_$_EventIds> get copyWith =>
      __$$_EventIdsCopyWithImpl<_$_EventIds>(this, _$identity);
}

abstract class _EventIds implements EventIds {
  const factory _EventIds(
      {required final String activityId,
      required final String eventId}) = _$_EventIds;

  @override
  String get activityId;
  @override
  String get eventId;
  @override
  @JsonKey(ignore: true)
  _$$_EventIdsCopyWith<_$_EventIds> get copyWith =>
      throw _privateConstructorUsedError;
}
