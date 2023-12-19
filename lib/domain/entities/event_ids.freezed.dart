// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_ids.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EventIds {
  String get providerId => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventIdsCopyWith<EventIds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventIdsCopyWith<$Res> {
  factory $EventIdsCopyWith(EventIds value, $Res Function(EventIds) then) =
      _$EventIdsCopyWithImpl<$Res, EventIds>;
  @useResult
  $Res call({String providerId, String eventId, String? sessionId});
}

/// @nodoc
class _$EventIdsCopyWithImpl<$Res, $Val extends EventIds>
    implements $EventIdsCopyWith<$Res> {
  _$EventIdsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? eventId = null,
    Object? sessionId = freezed,
  }) {
    return _then(_value.copyWith(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventIdsImplCopyWith<$Res>
    implements $EventIdsCopyWith<$Res> {
  factory _$$EventIdsImplCopyWith(
          _$EventIdsImpl value, $Res Function(_$EventIdsImpl) then) =
      __$$EventIdsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String providerId, String eventId, String? sessionId});
}

/// @nodoc
class __$$EventIdsImplCopyWithImpl<$Res>
    extends _$EventIdsCopyWithImpl<$Res, _$EventIdsImpl>
    implements _$$EventIdsImplCopyWith<$Res> {
  __$$EventIdsImplCopyWithImpl(
      _$EventIdsImpl _value, $Res Function(_$EventIdsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? eventId = null,
    Object? sessionId = freezed,
  }) {
    return _then(_$EventIdsImpl(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EventIdsImpl implements _EventIds {
  const _$EventIdsImpl(
      {required this.providerId, required this.eventId, this.sessionId});

  @override
  final String providerId;
  @override
  final String eventId;
  @override
  final String? sessionId;

  @override
  String toString() {
    return 'EventIds(providerId: $providerId, eventId: $eventId, sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventIdsImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId, eventId, sessionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventIdsImplCopyWith<_$EventIdsImpl> get copyWith =>
      __$$EventIdsImplCopyWithImpl<_$EventIdsImpl>(this, _$identity);
}

abstract class _EventIds implements EventIds {
  const factory _EventIds(
      {required final String providerId,
      required final String eventId,
      final String? sessionId}) = _$EventIdsImpl;

  @override
  String get providerId;
  @override
  String get eventId;
  @override
  String? get sessionId;
  @override
  @JsonKey(ignore: true)
  _$$EventIdsImplCopyWith<_$EventIdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
