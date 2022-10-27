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
  bool get emailShowed => throw _privateConstructorUsedError;
  @FrequencyTypeConverter()
  FrequencyType? get frequency => throw _privateConstructorUsedError;
  int? get recurrence => throw _privateConstructorUsedError;
  int? get remaining => throw _privateConstructorUsedError;
  String? get currentSubEvent => throw _privateConstructorUsedError;
  @EventAccessTypeConverter()
  EventAccessType get accessType => throw _privateConstructorUsedError;
  int get maxWomCount => throw _privateConstructorUsedError;
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
      _$CMIEventCopyWithImpl<$Res, CMIEvent>;
  @useResult
  $Res call(
      {String id,
      String name,
      bool acceptPassepartout,
      bool anonymous,
      bool recurring,
      bool isOpen,
      bool emailShowed,
      @FrequencyTypeConverter() FrequencyType? frequency,
      int? recurrence,
      int? remaining,
      String? currentSubEvent,
      @EventAccessTypeConverter() EventAccessType accessType,
      int maxWomCount,
      @EventStatusConverter() EventStatus? status,
      @MyDateTimeConverter() DateTime createdOn,
      @MyDateTimeConverter() DateTime? subEventDeadline,
      @MyDateTimeConverter() DateTime startAt});
}

/// @nodoc
class _$CMIEventCopyWithImpl<$Res, $Val extends CMIEvent>
    implements $CMIEventCopyWith<$Res> {
  _$CMIEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? acceptPassepartout = null,
    Object? anonymous = null,
    Object? recurring = null,
    Object? isOpen = null,
    Object? emailShowed = null,
    Object? frequency = freezed,
    Object? recurrence = freezed,
    Object? remaining = freezed,
    Object? currentSubEvent = freezed,
    Object? accessType = null,
    Object? maxWomCount = null,
    Object? status = freezed,
    Object? createdOn = null,
    Object? subEventDeadline = freezed,
    Object? startAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      acceptPassepartout: null == acceptPassepartout
          ? _value.acceptPassepartout
          : acceptPassepartout // ignore: cast_nullable_to_non_nullable
              as bool,
      anonymous: null == anonymous
          ? _value.anonymous
          : anonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      recurring: null == recurring
          ? _value.recurring
          : recurring // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      emailShowed: null == emailShowed
          ? _value.emailShowed
          : emailShowed // ignore: cast_nullable_to_non_nullable
              as bool,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as FrequencyType?,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as int?,
      remaining: freezed == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int?,
      currentSubEvent: freezed == currentSubEvent
          ? _value.currentSubEvent
          : currentSubEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      accessType: null == accessType
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as EventAccessType,
      maxWomCount: null == maxWomCount
          ? _value.maxWomCount
          : maxWomCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus?,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subEventDeadline: freezed == subEventDeadline
          ? _value.subEventDeadline
          : subEventDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CMIEventCopyWith<$Res> implements $CMIEventCopyWith<$Res> {
  factory _$$_CMIEventCopyWith(
          _$_CMIEvent value, $Res Function(_$_CMIEvent) then) =
      __$$_CMIEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool acceptPassepartout,
      bool anonymous,
      bool recurring,
      bool isOpen,
      bool emailShowed,
      @FrequencyTypeConverter() FrequencyType? frequency,
      int? recurrence,
      int? remaining,
      String? currentSubEvent,
      @EventAccessTypeConverter() EventAccessType accessType,
      int maxWomCount,
      @EventStatusConverter() EventStatus? status,
      @MyDateTimeConverter() DateTime createdOn,
      @MyDateTimeConverter() DateTime? subEventDeadline,
      @MyDateTimeConverter() DateTime startAt});
}

/// @nodoc
class __$$_CMIEventCopyWithImpl<$Res>
    extends _$CMIEventCopyWithImpl<$Res, _$_CMIEvent>
    implements _$$_CMIEventCopyWith<$Res> {
  __$$_CMIEventCopyWithImpl(
      _$_CMIEvent _value, $Res Function(_$_CMIEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? acceptPassepartout = null,
    Object? anonymous = null,
    Object? recurring = null,
    Object? isOpen = null,
    Object? emailShowed = null,
    Object? frequency = freezed,
    Object? recurrence = freezed,
    Object? remaining = freezed,
    Object? currentSubEvent = freezed,
    Object? accessType = null,
    Object? maxWomCount = null,
    Object? status = freezed,
    Object? createdOn = null,
    Object? subEventDeadline = freezed,
    Object? startAt = null,
  }) {
    return _then(_$_CMIEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      acceptPassepartout: null == acceptPassepartout
          ? _value.acceptPassepartout
          : acceptPassepartout // ignore: cast_nullable_to_non_nullable
              as bool,
      anonymous: null == anonymous
          ? _value.anonymous
          : anonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      recurring: null == recurring
          ? _value.recurring
          : recurring // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      emailShowed: null == emailShowed
          ? _value.emailShowed
          : emailShowed // ignore: cast_nullable_to_non_nullable
              as bool,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as FrequencyType?,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as int?,
      remaining: freezed == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int?,
      currentSubEvent: freezed == currentSubEvent
          ? _value.currentSubEvent
          : currentSubEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      accessType: null == accessType
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as EventAccessType,
      maxWomCount: null == maxWomCount
          ? _value.maxWomCount
          : maxWomCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus?,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subEventDeadline: freezed == subEventDeadline
          ? _value.subEventDeadline
          : subEventDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startAt: null == startAt
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
      this.emailShowed = false,
      @FrequencyTypeConverter() this.frequency,
      this.recurrence,
      this.remaining,
      this.currentSubEvent,
      @EventAccessTypeConverter() required this.accessType,
      required this.maxWomCount,
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
  @JsonKey()
  final bool emailShowed;
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
  final EventAccessType accessType;
  @override
  final int maxWomCount;
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
    return 'CMIEvent(id: $id, name: $name, acceptPassepartout: $acceptPassepartout, anonymous: $anonymous, recurring: $recurring, isOpen: $isOpen, emailShowed: $emailShowed, frequency: $frequency, recurrence: $recurrence, remaining: $remaining, currentSubEvent: $currentSubEvent, accessType: $accessType, maxWomCount: $maxWomCount, status: $status, createdOn: $createdOn, subEventDeadline: $subEventDeadline, startAt: $startAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMIEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.acceptPassepartout, acceptPassepartout) ||
                other.acceptPassepartout == acceptPassepartout) &&
            (identical(other.anonymous, anonymous) ||
                other.anonymous == anonymous) &&
            (identical(other.recurring, recurring) ||
                other.recurring == recurring) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.emailShowed, emailShowed) ||
                other.emailShowed == emailShowed) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.currentSubEvent, currentSubEvent) ||
                other.currentSubEvent == currentSubEvent) &&
            (identical(other.accessType, accessType) ||
                other.accessType == accessType) &&
            (identical(other.maxWomCount, maxWomCount) ||
                other.maxWomCount == maxWomCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.subEventDeadline, subEventDeadline) ||
                other.subEventDeadline == subEventDeadline) &&
            (identical(other.startAt, startAt) || other.startAt == startAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      acceptPassepartout,
      anonymous,
      recurring,
      isOpen,
      emailShowed,
      frequency,
      recurrence,
      remaining,
      currentSubEvent,
      accessType,
      maxWomCount,
      status,
      createdOn,
      subEventDeadline,
      startAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      final bool emailShowed,
      @FrequencyTypeConverter() final FrequencyType? frequency,
      final int? recurrence,
      final int? remaining,
      final String? currentSubEvent,
      @EventAccessTypeConverter() required final EventAccessType accessType,
      required final int maxWomCount,
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
  bool get emailShowed;
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
  EventAccessType get accessType;
  @override
  int get maxWomCount;
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
  GenderCount? get genderCount => throw _privateConstructorUsedError;
  int get totalUsers => throw _privateConstructorUsedError;
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
      _$CMISubEventCopyWithImpl<$Res, CMISubEvent>;
  @useResult
  $Res call(
      {String id,
      GenderCount? genderCount,
      int totalUsers,
      @MyDateTimeConverter() DateTime startAt,
      @MyDateTimeConverter() DateTime endAt});

  $GenderCountCopyWith<$Res>? get genderCount;
}

/// @nodoc
class _$CMISubEventCopyWithImpl<$Res, $Val extends CMISubEvent>
    implements $CMISubEventCopyWith<$Res> {
  _$CMISubEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? genderCount = freezed,
    Object? totalUsers = null,
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      genderCount: freezed == genderCount
          ? _value.genderCount
          : genderCount // ignore: cast_nullable_to_non_nullable
              as GenderCount?,
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GenderCountCopyWith<$Res>? get genderCount {
    if (_value.genderCount == null) {
      return null;
    }

    return $GenderCountCopyWith<$Res>(_value.genderCount!, (value) {
      return _then(_value.copyWith(genderCount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CMISubEventCopyWith<$Res>
    implements $CMISubEventCopyWith<$Res> {
  factory _$$_CMISubEventCopyWith(
          _$_CMISubEvent value, $Res Function(_$_CMISubEvent) then) =
      __$$_CMISubEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      GenderCount? genderCount,
      int totalUsers,
      @MyDateTimeConverter() DateTime startAt,
      @MyDateTimeConverter() DateTime endAt});

  @override
  $GenderCountCopyWith<$Res>? get genderCount;
}

/// @nodoc
class __$$_CMISubEventCopyWithImpl<$Res>
    extends _$CMISubEventCopyWithImpl<$Res, _$_CMISubEvent>
    implements _$$_CMISubEventCopyWith<$Res> {
  __$$_CMISubEventCopyWithImpl(
      _$_CMISubEvent _value, $Res Function(_$_CMISubEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? genderCount = freezed,
    Object? totalUsers = null,
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(_$_CMISubEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      genderCount: freezed == genderCount
          ? _value.genderCount
          : genderCount // ignore: cast_nullable_to_non_nullable
              as GenderCount?,
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
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
      this.genderCount,
      this.totalUsers = 0,
      @MyDateTimeConverter() required this.startAt,
      @MyDateTimeConverter() required this.endAt});

  factory _$_CMISubEvent.fromJson(Map<String, dynamic> json) =>
      _$$_CMISubEventFromJson(json);

  @override
  final String id;
  @override
  final GenderCount? genderCount;
  @override
  @JsonKey()
  final int totalUsers;
  @override
  @MyDateTimeConverter()
  final DateTime startAt;
  @override
  @MyDateTimeConverter()
  final DateTime endAt;

  @override
  String toString() {
    return 'CMISubEvent(id: $id, genderCount: $genderCount, totalUsers: $totalUsers, startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMISubEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.genderCount, genderCount) ||
                other.genderCount == genderCount) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, genderCount, totalUsers, startAt, endAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      final GenderCount? genderCount,
      final int totalUsers,
      @MyDateTimeConverter() required final DateTime startAt,
      @MyDateTimeConverter() required final DateTime endAt}) = _$_CMISubEvent;

  factory _CMISubEvent.fromJson(Map<String, dynamic> json) =
      _$_CMISubEvent.fromJson;

  @override
  String get id;
  @override
  GenderCount? get genderCount;
  @override
  int get totalUsers;
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

GenderCount _$GenderCountFromJson(Map<String, dynamic> json) {
  return _GenderCount.fromJson(json);
}

/// @nodoc
mixin _$GenderCount {
  int get male => throw _privateConstructorUsedError;
  int get female => throw _privateConstructorUsedError;
  int get notBinary => throw _privateConstructorUsedError;
  int get notAvailable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenderCountCopyWith<GenderCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenderCountCopyWith<$Res> {
  factory $GenderCountCopyWith(
          GenderCount value, $Res Function(GenderCount) then) =
      _$GenderCountCopyWithImpl<$Res, GenderCount>;
  @useResult
  $Res call({int male, int female, int notBinary, int notAvailable});
}

/// @nodoc
class _$GenderCountCopyWithImpl<$Res, $Val extends GenderCount>
    implements $GenderCountCopyWith<$Res> {
  _$GenderCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? male = null,
    Object? female = null,
    Object? notBinary = null,
    Object? notAvailable = null,
  }) {
    return _then(_value.copyWith(
      male: null == male
          ? _value.male
          : male // ignore: cast_nullable_to_non_nullable
              as int,
      female: null == female
          ? _value.female
          : female // ignore: cast_nullable_to_non_nullable
              as int,
      notBinary: null == notBinary
          ? _value.notBinary
          : notBinary // ignore: cast_nullable_to_non_nullable
              as int,
      notAvailable: null == notAvailable
          ? _value.notAvailable
          : notAvailable // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GenderCountCopyWith<$Res>
    implements $GenderCountCopyWith<$Res> {
  factory _$$_GenderCountCopyWith(
          _$_GenderCount value, $Res Function(_$_GenderCount) then) =
      __$$_GenderCountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int male, int female, int notBinary, int notAvailable});
}

/// @nodoc
class __$$_GenderCountCopyWithImpl<$Res>
    extends _$GenderCountCopyWithImpl<$Res, _$_GenderCount>
    implements _$$_GenderCountCopyWith<$Res> {
  __$$_GenderCountCopyWithImpl(
      _$_GenderCount _value, $Res Function(_$_GenderCount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? male = null,
    Object? female = null,
    Object? notBinary = null,
    Object? notAvailable = null,
  }) {
    return _then(_$_GenderCount(
      male: null == male
          ? _value.male
          : male // ignore: cast_nullable_to_non_nullable
              as int,
      female: null == female
          ? _value.female
          : female // ignore: cast_nullable_to_non_nullable
              as int,
      notBinary: null == notBinary
          ? _value.notBinary
          : notBinary // ignore: cast_nullable_to_non_nullable
              as int,
      notAvailable: null == notAvailable
          ? _value.notAvailable
          : notAvailable // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GenderCount implements _GenderCount {
  const _$_GenderCount(
      {required this.male,
      required this.female,
      required this.notBinary,
      this.notAvailable = 0});

  factory _$_GenderCount.fromJson(Map<String, dynamic> json) =>
      _$$_GenderCountFromJson(json);

  @override
  final int male;
  @override
  final int female;
  @override
  final int notBinary;
  @override
  @JsonKey()
  final int notAvailable;

  @override
  String toString() {
    return 'GenderCount(male: $male, female: $female, notBinary: $notBinary, notAvailable: $notAvailable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenderCount &&
            (identical(other.male, male) || other.male == male) &&
            (identical(other.female, female) || other.female == female) &&
            (identical(other.notBinary, notBinary) ||
                other.notBinary == notBinary) &&
            (identical(other.notAvailable, notAvailable) ||
                other.notAvailable == notAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, male, female, notBinary, notAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenderCountCopyWith<_$_GenderCount> get copyWith =>
      __$$_GenderCountCopyWithImpl<_$_GenderCount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenderCountToJson(
      this,
    );
  }
}

abstract class _GenderCount implements GenderCount {
  const factory _GenderCount(
      {required final int male,
      required final int female,
      required final int notBinary,
      final int notAvailable}) = _$_GenderCount;

  factory _GenderCount.fromJson(Map<String, dynamic> json) =
      _$_GenderCount.fromJson;

  @override
  int get male;
  @override
  int get female;
  @override
  int get notBinary;
  @override
  int get notAvailable;
  @override
  @JsonKey(ignore: true)
  _$$_GenderCountCopyWith<_$_GenderCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CMIQuerySubEvent {
  String get providerId => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CMIQuerySubEventCopyWith<CMIQuerySubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CMIQuerySubEventCopyWith<$Res> {
  factory $CMIQuerySubEventCopyWith(
          CMIQuerySubEvent value, $Res Function(CMIQuerySubEvent) then) =
      _$CMIQuerySubEventCopyWithImpl<$Res, CMIQuerySubEvent>;
  @useResult
  $Res call({String providerId, String eventId});
}

/// @nodoc
class _$CMIQuerySubEventCopyWithImpl<$Res, $Val extends CMIQuerySubEvent>
    implements $CMIQuerySubEventCopyWith<$Res> {
  _$CMIQuerySubEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? eventId = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CMIQuerySubEventCopyWith<$Res>
    implements $CMIQuerySubEventCopyWith<$Res> {
  factory _$$_CMIQuerySubEventCopyWith(
          _$_CMIQuerySubEvent value, $Res Function(_$_CMIQuerySubEvent) then) =
      __$$_CMIQuerySubEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String providerId, String eventId});
}

/// @nodoc
class __$$_CMIQuerySubEventCopyWithImpl<$Res>
    extends _$CMIQuerySubEventCopyWithImpl<$Res, _$_CMIQuerySubEvent>
    implements _$$_CMIQuerySubEventCopyWith<$Res> {
  __$$_CMIQuerySubEventCopyWithImpl(
      _$_CMIQuerySubEvent _value, $Res Function(_$_CMIQuerySubEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? eventId = null,
  }) {
    return _then(_$_CMIQuerySubEvent(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CMIQuerySubEvent implements _CMIQuerySubEvent {
  const _$_CMIQuerySubEvent({required this.providerId, required this.eventId});

  @override
  final String providerId;
  @override
  final String eventId;

  @override
  String toString() {
    return 'CMIQuerySubEvent(providerId: $providerId, eventId: $eventId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMIQuerySubEvent &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, providerId, eventId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CMIQuerySubEventCopyWith<_$_CMIQuerySubEvent> get copyWith =>
      __$$_CMIQuerySubEventCopyWithImpl<_$_CMIQuerySubEvent>(this, _$identity);
}

abstract class _CMIQuerySubEvent implements CMIQuerySubEvent {
  const factory _CMIQuerySubEvent(
      {required final String providerId,
      required final String eventId}) = _$_CMIQuerySubEvent;

  @override
  String get providerId;
  @override
  String get eventId;
  @override
  @JsonKey(ignore: true)
  _$$_CMIQuerySubEventCopyWith<_$_CMIQuerySubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
