// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cmi_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CMIEvent _$CMIEventFromJson(Map<String, dynamic> json) {
  return _CMIEvent.fromJson(json);
}

/// @nodoc
mixin _$CMIEvent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get acceptPassepartout => throw _privateConstructorUsedError;
  bool get anonymous => throw _privateConstructorUsedError;
  bool get recurring => throw _privateConstructorUsedError;
  bool get isOpen => throw _privateConstructorUsedError;
  @FrequencyTypeConverter()
  FrequencyType? get frequency => throw _privateConstructorUsedError;
  int? get recurrence => throw _privateConstructorUsedError;
  int? get remaining => throw _privateConstructorUsedError;
  String? get currentSubEvent => throw _privateConstructorUsedError;
  @EventAccessTypeConverter()
  EventAccessType? get accessType => throw _privateConstructorUsedError;
  int? get maxWomCount => throw _privateConstructorUsedError;
  @EventStatusConverter()
  EventStatus? get status => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get createdOn => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get subEventDeadline => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get startAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CMIEventCopyWith<CMIEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CMIEventCopyWith<$Res> {
  factory $CMIEventCopyWith(CMIEvent value, $Res Function(CMIEvent) then) =
      _$CMIEventCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      bool acceptPassepartout,
      bool anonymous,
      bool recurring,
      bool isOpen,
      @FrequencyTypeConverter() FrequencyType? frequency,
      int? recurrence,
      int? remaining,
      String? currentSubEvent,
      @EventAccessTypeConverter() EventAccessType? accessType,
      int? maxWomCount,
      @EventStatusConverter() EventStatus? status,
      @MyDateTimeConverter() DateTime createdOn,
      @MyDateTimeConverter() DateTime? subEventDeadline,
      @MyDateTimeConverter() DateTime startAt});
}

/// @nodoc
class _$CMIEventCopyWithImpl<$Res> implements $CMIEventCopyWith<$Res> {
  _$CMIEventCopyWithImpl(this._value, this._then);

  final CMIEvent _value;
  // ignore: unused_field
  final $Res Function(CMIEvent) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? acceptPassepartout = freezed,
    Object? anonymous = freezed,
    Object? recurring = freezed,
    Object? isOpen = freezed,
    Object? frequency = freezed,
    Object? recurrence = freezed,
    Object? remaining = freezed,
    Object? currentSubEvent = freezed,
    Object? accessType = freezed,
    Object? maxWomCount = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? subEventDeadline = freezed,
    Object? startAt = freezed,
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
      acceptPassepartout: acceptPassepartout == freezed
          ? _value.acceptPassepartout
          : acceptPassepartout // ignore: cast_nullable_to_non_nullable
              as bool,
      anonymous: anonymous == freezed
          ? _value.anonymous
          : anonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      recurring: recurring == freezed
          ? _value.recurring
          : recurring // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpen: isOpen == freezed
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as FrequencyType?,
      recurrence: recurrence == freezed
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as int?,
      remaining: remaining == freezed
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int?,
      currentSubEvent: currentSubEvent == freezed
          ? _value.currentSubEvent
          : currentSubEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      accessType: accessType == freezed
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as EventAccessType?,
      maxWomCount: maxWomCount == freezed
          ? _value.maxWomCount
          : maxWomCount // ignore: cast_nullable_to_non_nullable
              as int?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subEventDeadline: subEventDeadline == freezed
          ? _value.subEventDeadline
          : subEventDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startAt: startAt == freezed
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_CMIEventCopyWith<$Res> implements $CMIEventCopyWith<$Res> {
  factory _$$_CMIEventCopyWith(
          _$_CMIEvent value, $Res Function(_$_CMIEvent) then) =
      __$$_CMIEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      bool acceptPassepartout,
      bool anonymous,
      bool recurring,
      bool isOpen,
      @FrequencyTypeConverter() FrequencyType? frequency,
      int? recurrence,
      int? remaining,
      String? currentSubEvent,
      @EventAccessTypeConverter() EventAccessType? accessType,
      int? maxWomCount,
      @EventStatusConverter() EventStatus? status,
      @MyDateTimeConverter() DateTime createdOn,
      @MyDateTimeConverter() DateTime? subEventDeadline,
      @MyDateTimeConverter() DateTime startAt});
}

/// @nodoc
class __$$_CMIEventCopyWithImpl<$Res> extends _$CMIEventCopyWithImpl<$Res>
    implements _$$_CMIEventCopyWith<$Res> {
  __$$_CMIEventCopyWithImpl(
      _$_CMIEvent _value, $Res Function(_$_CMIEvent) _then)
      : super(_value, (v) => _then(v as _$_CMIEvent));

  @override
  _$_CMIEvent get _value => super._value as _$_CMIEvent;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? acceptPassepartout = freezed,
    Object? anonymous = freezed,
    Object? recurring = freezed,
    Object? isOpen = freezed,
    Object? frequency = freezed,
    Object? recurrence = freezed,
    Object? remaining = freezed,
    Object? currentSubEvent = freezed,
    Object? accessType = freezed,
    Object? maxWomCount = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? subEventDeadline = freezed,
    Object? startAt = freezed,
  }) {
    return _then(_$_CMIEvent(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      acceptPassepartout: acceptPassepartout == freezed
          ? _value.acceptPassepartout
          : acceptPassepartout // ignore: cast_nullable_to_non_nullable
              as bool,
      anonymous: anonymous == freezed
          ? _value.anonymous
          : anonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      recurring: recurring == freezed
          ? _value.recurring
          : recurring // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpen: isOpen == freezed
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      frequency: frequency == freezed
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as FrequencyType?,
      recurrence: recurrence == freezed
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as int?,
      remaining: remaining == freezed
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int?,
      currentSubEvent: currentSubEvent == freezed
          ? _value.currentSubEvent
          : currentSubEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      accessType: accessType == freezed
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as EventAccessType?,
      maxWomCount: maxWomCount == freezed
          ? _value.maxWomCount
          : maxWomCount // ignore: cast_nullable_to_non_nullable
              as int?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subEventDeadline: subEventDeadline == freezed
          ? _value.subEventDeadline
          : subEventDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startAt: startAt == freezed
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CMIEvent implements _CMIEvent {
  const _$_CMIEvent(
      {required this.id,
      required this.name,
      this.acceptPassepartout = true,
      this.anonymous = true,
      this.recurring = true,
      this.isOpen = true,
      @FrequencyTypeConverter() this.frequency,
      this.recurrence,
      this.remaining,
      this.currentSubEvent,
      @EventAccessTypeConverter() this.accessType,
      this.maxWomCount,
      @EventStatusConverter() this.status,
      @MyDateTimeConverter() required this.createdOn,
      @MyDateTimeConverter() this.subEventDeadline,
      @MyDateTimeConverter() required this.startAt});

  factory _$_CMIEvent.fromJson(Map<String, dynamic> json) =>
      _$$_CMIEventFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool acceptPassepartout;
  @override
  @JsonKey()
  final bool anonymous;
  @override
  @JsonKey()
  final bool recurring;
  @override
  @JsonKey()
  final bool isOpen;
  @override
  @FrequencyTypeConverter()
  final FrequencyType? frequency;
  @override
  final int? recurrence;
  @override
  final int? remaining;
  @override
  final String? currentSubEvent;
  @override
  @EventAccessTypeConverter()
  final EventAccessType? accessType;
  @override
  final int? maxWomCount;
  @override
  @EventStatusConverter()
  final EventStatus? status;
  @override
  @MyDateTimeConverter()
  final DateTime createdOn;
  @override
  @MyDateTimeConverter()
  final DateTime? subEventDeadline;
  @override
  @MyDateTimeConverter()
  final DateTime startAt;

  @override
  String toString() {
    return 'CMIEvent(id: $id, name: $name, acceptPassepartout: $acceptPassepartout, anonymous: $anonymous, recurring: $recurring, isOpen: $isOpen, frequency: $frequency, recurrence: $recurrence, remaining: $remaining, currentSubEvent: $currentSubEvent, accessType: $accessType, maxWomCount: $maxWomCount, status: $status, createdOn: $createdOn, subEventDeadline: $subEventDeadline, startAt: $startAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMIEvent &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.acceptPassepartout, acceptPassepartout) &&
            const DeepCollectionEquality().equals(other.anonymous, anonymous) &&
            const DeepCollectionEquality().equals(other.recurring, recurring) &&
            const DeepCollectionEquality().equals(other.isOpen, isOpen) &&
            const DeepCollectionEquality().equals(other.frequency, frequency) &&
            const DeepCollectionEquality()
                .equals(other.recurrence, recurrence) &&
            const DeepCollectionEquality().equals(other.remaining, remaining) &&
            const DeepCollectionEquality()
                .equals(other.currentSubEvent, currentSubEvent) &&
            const DeepCollectionEquality()
                .equals(other.accessType, accessType) &&
            const DeepCollectionEquality()
                .equals(other.maxWomCount, maxWomCount) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn) &&
            const DeepCollectionEquality()
                .equals(other.subEventDeadline, subEventDeadline) &&
            const DeepCollectionEquality().equals(other.startAt, startAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(acceptPassepartout),
      const DeepCollectionEquality().hash(anonymous),
      const DeepCollectionEquality().hash(recurring),
      const DeepCollectionEquality().hash(isOpen),
      const DeepCollectionEquality().hash(frequency),
      const DeepCollectionEquality().hash(recurrence),
      const DeepCollectionEquality().hash(remaining),
      const DeepCollectionEquality().hash(currentSubEvent),
      const DeepCollectionEquality().hash(accessType),
      const DeepCollectionEquality().hash(maxWomCount),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(createdOn),
      const DeepCollectionEquality().hash(subEventDeadline),
      const DeepCollectionEquality().hash(startAt));

  @JsonKey(ignore: true)
  @override
  _$$_CMIEventCopyWith<_$_CMIEvent> get copyWith =>
      __$$_CMIEventCopyWithImpl<_$_CMIEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CMIEventToJson(
      this,
    );
  }
}

abstract class _CMIEvent implements CMIEvent {
  const factory _CMIEvent(
      {required final String id,
      required final String name,
      final bool acceptPassepartout,
      final bool anonymous,
      final bool recurring,
      final bool isOpen,
      @FrequencyTypeConverter() final FrequencyType? frequency,
      final int? recurrence,
      final int? remaining,
      final String? currentSubEvent,
      @EventAccessTypeConverter() final EventAccessType? accessType,
      final int? maxWomCount,
      @EventStatusConverter() final EventStatus? status,
      @MyDateTimeConverter() required final DateTime createdOn,
      @MyDateTimeConverter() final DateTime? subEventDeadline,
      @MyDateTimeConverter() required final DateTime startAt}) = _$_CMIEvent;

  factory _CMIEvent.fromJson(Map<String, dynamic> json) = _$_CMIEvent.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get acceptPassepartout;
  @override
  bool get anonymous;
  @override
  bool get recurring;
  @override
  bool get isOpen;
  @override
  @FrequencyTypeConverter()
  FrequencyType? get frequency;
  @override
  int? get recurrence;
  @override
  int? get remaining;
  @override
  String? get currentSubEvent;
  @override
  @EventAccessTypeConverter()
  EventAccessType? get accessType;
  @override
  int? get maxWomCount;
  @override
  @EventStatusConverter()
  EventStatus? get status;
  @override
  @MyDateTimeConverter()
  DateTime get createdOn;
  @override
  @MyDateTimeConverter()
  DateTime? get subEventDeadline;
  @override
  @MyDateTimeConverter()
  DateTime get startAt;
  @override
  @JsonKey(ignore: true)
  _$$_CMIEventCopyWith<_$_CMIEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

CMISubEvent _$CMISubEventFromJson(Map<String, dynamic> json) {
  return _CMISubEvent.fromJson(json);
}

/// @nodoc
mixin _$CMISubEvent {
  String get id => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get startAt => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get endAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CMISubEventCopyWith<CMISubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CMISubEventCopyWith<$Res> {
  factory $CMISubEventCopyWith(
          CMISubEvent value, $Res Function(CMISubEvent) then) =
      _$CMISubEventCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @MyDateTimeConverter() DateTime startAt,
      @MyDateTimeConverter() DateTime endAt});
}

/// @nodoc
class _$CMISubEventCopyWithImpl<$Res> implements $CMISubEventCopyWith<$Res> {
  _$CMISubEventCopyWithImpl(this._value, this._then);

  final CMISubEvent _value;
  // ignore: unused_field
  final $Res Function(CMISubEvent) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? startAt = freezed,
    Object? endAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: startAt == freezed
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: endAt == freezed
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_CMISubEventCopyWith<$Res>
    implements $CMISubEventCopyWith<$Res> {
  factory _$$_CMISubEventCopyWith(
          _$_CMISubEvent value, $Res Function(_$_CMISubEvent) then) =
      __$$_CMISubEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @MyDateTimeConverter() DateTime startAt,
      @MyDateTimeConverter() DateTime endAt});
}

/// @nodoc
class __$$_CMISubEventCopyWithImpl<$Res> extends _$CMISubEventCopyWithImpl<$Res>
    implements _$$_CMISubEventCopyWith<$Res> {
  __$$_CMISubEventCopyWithImpl(
      _$_CMISubEvent _value, $Res Function(_$_CMISubEvent) _then)
      : super(_value, (v) => _then(v as _$_CMISubEvent));

  @override
  _$_CMISubEvent get _value => super._value as _$_CMISubEvent;

  @override
  $Res call({
    Object? id = freezed,
    Object? startAt = freezed,
    Object? endAt = freezed,
  }) {
    return _then(_$_CMISubEvent(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: startAt == freezed
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: endAt == freezed
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CMISubEvent implements _CMISubEvent {
  const _$_CMISubEvent(
      {required this.id,
      @MyDateTimeConverter() required this.startAt,
      @MyDateTimeConverter() required this.endAt});

  factory _$_CMISubEvent.fromJson(Map<String, dynamic> json) =>
      _$$_CMISubEventFromJson(json);

  @override
  final String id;
  @override
  @MyDateTimeConverter()
  final DateTime startAt;
  @override
  @MyDateTimeConverter()
  final DateTime endAt;

  @override
  String toString() {
    return 'CMISubEvent(id: $id, startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMISubEvent &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.startAt, startAt) &&
            const DeepCollectionEquality().equals(other.endAt, endAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(startAt),
      const DeepCollectionEquality().hash(endAt));

  @JsonKey(ignore: true)
  @override
  _$$_CMISubEventCopyWith<_$_CMISubEvent> get copyWith =>
      __$$_CMISubEventCopyWithImpl<_$_CMISubEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CMISubEventToJson(
      this,
    );
  }
}

abstract class _CMISubEvent implements CMISubEvent {
  const factory _CMISubEvent(
      {required final String id,
      @MyDateTimeConverter() required final DateTime startAt,
      @MyDateTimeConverter() required final DateTime endAt}) = _$_CMISubEvent;

  factory _CMISubEvent.fromJson(Map<String, dynamic> json) =
      _$_CMISubEvent.fromJson;

  @override
  String get id;
  @override
  @MyDateTimeConverter()
  DateTime get startAt;
  @override
  @MyDateTimeConverter()
  DateTime get endAt;
  @override
  @JsonKey(ignore: true)
  _$$_CMISubEventCopyWith<_$_CMISubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
