// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cmi_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CMIProvider _$CMIProviderFromJson(Map<String, dynamic> json) {
  return _CMIProvider.fromJson(json);
}

/// @nodoc
mixin _$CMIProvider {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get adminName => throw _privateConstructorUsedError;
  String get adminSurname => throw _privateConstructorUsedError;
  String get adminEmail => throw _privateConstructorUsedError;
  Map<String, ProviderManager> get managers =>
      throw _privateConstructorUsedError;
  String? get apiKey => throw _privateConstructorUsedError;
  List<String>? get aims => throw _privateConstructorUsedError;
  String? get aim => throw _privateConstructorUsedError;
  String? get domainRequirement => throw _privateConstructorUsedError;
  bool get releaseWom => throw _privateConstructorUsedError;
  @CMIProviderStatusConverter()
  CMIProviderStatus? get status => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime? get createdOn => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get requestedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CMIProviderCopyWith<CMIProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CMIProviderCopyWith<$Res> {
  factory $CMIProviderCopyWith(
          CMIProvider value, $Res Function(CMIProvider) then) =
      _$CMIProviderCopyWithImpl<$Res, CMIProvider>;
  @useResult
  $Res call(
      {String id,
      String name,
      String adminName,
      String adminSurname,
      String adminEmail,
      Map<String, ProviderManager> managers,
      String? apiKey,
      List<String>? aims,
      String? aim,
      String? domainRequirement,
      bool releaseWom,
      @CMIProviderStatusConverter() CMIProviderStatus? status,
      @MyDateTimeConverter() DateTime? createdOn,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class _$CMIProviderCopyWithImpl<$Res, $Val extends CMIProvider>
    implements $CMIProviderCopyWith<$Res> {
  _$CMIProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminName = null,
    Object? adminSurname = null,
    Object? adminEmail = null,
    Object? managers = null,
    Object? apiKey = freezed,
    Object? aims = freezed,
    Object? aim = freezed,
    Object? domainRequirement = freezed,
    Object? releaseWom = null,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? requestedOn = null,
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
      adminName: null == adminName
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      adminSurname: null == adminSurname
          ? _value.adminSurname
          : adminSurname // ignore: cast_nullable_to_non_nullable
              as String,
      adminEmail: null == adminEmail
          ? _value.adminEmail
          : adminEmail // ignore: cast_nullable_to_non_nullable
              as String,
      managers: null == managers
          ? _value.managers
          : managers // ignore: cast_nullable_to_non_nullable
              as Map<String, ProviderManager>,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      aims: freezed == aims
          ? _value.aims
          : aims // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      aim: freezed == aim
          ? _value.aim
          : aim // ignore: cast_nullable_to_non_nullable
              as String?,
      domainRequirement: freezed == domainRequirement
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseWom: null == releaseWom
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestedOn: null == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CMIProviderImplCopyWith<$Res>
    implements $CMIProviderCopyWith<$Res> {
  factory _$$CMIProviderImplCopyWith(
          _$CMIProviderImpl value, $Res Function(_$CMIProviderImpl) then) =
      __$$CMIProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String adminName,
      String adminSurname,
      String adminEmail,
      Map<String, ProviderManager> managers,
      String? apiKey,
      List<String>? aims,
      String? aim,
      String? domainRequirement,
      bool releaseWom,
      @CMIProviderStatusConverter() CMIProviderStatus? status,
      @MyDateTimeConverter() DateTime? createdOn,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class __$$CMIProviderImplCopyWithImpl<$Res>
    extends _$CMIProviderCopyWithImpl<$Res, _$CMIProviderImpl>
    implements _$$CMIProviderImplCopyWith<$Res> {
  __$$CMIProviderImplCopyWithImpl(
      _$CMIProviderImpl _value, $Res Function(_$CMIProviderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminName = null,
    Object? adminSurname = null,
    Object? adminEmail = null,
    Object? managers = null,
    Object? apiKey = freezed,
    Object? aims = freezed,
    Object? aim = freezed,
    Object? domainRequirement = freezed,
    Object? releaseWom = null,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? requestedOn = null,
  }) {
    return _then(_$CMIProviderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: null == adminName
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      adminSurname: null == adminSurname
          ? _value.adminSurname
          : adminSurname // ignore: cast_nullable_to_non_nullable
              as String,
      adminEmail: null == adminEmail
          ? _value.adminEmail
          : adminEmail // ignore: cast_nullable_to_non_nullable
              as String,
      managers: null == managers
          ? _value._managers
          : managers // ignore: cast_nullable_to_non_nullable
              as Map<String, ProviderManager>,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      aims: freezed == aims
          ? _value._aims
          : aims // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      aim: freezed == aim
          ? _value.aim
          : aim // ignore: cast_nullable_to_non_nullable
              as String?,
      domainRequirement: freezed == domainRequirement
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseWom: null == releaseWom
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestedOn: null == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CMIProviderImpl implements _CMIProvider {
  const _$CMIProviderImpl(
      {required this.id,
      required this.name,
      required this.adminName,
      required this.adminSurname,
      required this.adminEmail,
      final Map<String, ProviderManager> managers =
          const <String, ProviderManager>{},
      this.apiKey,
      final List<String>? aims,
      this.aim,
      this.domainRequirement,
      this.releaseWom = false,
      @CMIProviderStatusConverter() this.status,
      @MyDateTimeConverter() this.createdOn,
      @MyDateTimeConverter() required this.requestedOn})
      : _managers = managers,
        _aims = aims;

  factory _$CMIProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$CMIProviderImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String adminName;
  @override
  final String adminSurname;
  @override
  final String adminEmail;
  final Map<String, ProviderManager> _managers;
  @override
  @JsonKey()
  Map<String, ProviderManager> get managers {
    if (_managers is EqualUnmodifiableMapView) return _managers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_managers);
  }

  @override
  final String? apiKey;
  final List<String>? _aims;
  @override
  List<String>? get aims {
    final value = _aims;
    if (value == null) return null;
    if (_aims is EqualUnmodifiableListView) return _aims;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? aim;
  @override
  final String? domainRequirement;
  @override
  @JsonKey()
  final bool releaseWom;
  @override
  @CMIProviderStatusConverter()
  final CMIProviderStatus? status;
  @override
  @MyDateTimeConverter()
  final DateTime? createdOn;
  @override
  @MyDateTimeConverter()
  final DateTime requestedOn;

  @override
  String toString() {
    return 'CMIProvider(id: $id, name: $name, adminName: $adminName, adminSurname: $adminSurname, adminEmail: $adminEmail, managers: $managers, apiKey: $apiKey, aims: $aims, aim: $aim, domainRequirement: $domainRequirement, releaseWom: $releaseWom, status: $status, createdOn: $createdOn, requestedOn: $requestedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CMIProviderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.adminName, adminName) ||
                other.adminName == adminName) &&
            (identical(other.adminSurname, adminSurname) ||
                other.adminSurname == adminSurname) &&
            (identical(other.adminEmail, adminEmail) ||
                other.adminEmail == adminEmail) &&
            const DeepCollectionEquality().equals(other._managers, _managers) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            const DeepCollectionEquality().equals(other._aims, _aims) &&
            (identical(other.aim, aim) || other.aim == aim) &&
            (identical(other.domainRequirement, domainRequirement) ||
                other.domainRequirement == domainRequirement) &&
            (identical(other.releaseWom, releaseWom) ||
                other.releaseWom == releaseWom) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.requestedOn, requestedOn) ||
                other.requestedOn == requestedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      adminName,
      adminSurname,
      adminEmail,
      const DeepCollectionEquality().hash(_managers),
      apiKey,
      const DeepCollectionEquality().hash(_aims),
      aim,
      domainRequirement,
      releaseWom,
      status,
      createdOn,
      requestedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CMIProviderImplCopyWith<_$CMIProviderImpl> get copyWith =>
      __$$CMIProviderImplCopyWithImpl<_$CMIProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CMIProviderImplToJson(
      this,
    );
  }
}

abstract class _CMIProvider implements CMIProvider {
  const factory _CMIProvider(
          {required final String id,
          required final String name,
          required final String adminName,
          required final String adminSurname,
          required final String adminEmail,
          final Map<String, ProviderManager> managers,
          final String? apiKey,
          final List<String>? aims,
          final String? aim,
          final String? domainRequirement,
          final bool releaseWom,
          @CMIProviderStatusConverter() final CMIProviderStatus? status,
          @MyDateTimeConverter() final DateTime? createdOn,
          @MyDateTimeConverter() required final DateTime requestedOn}) =
      _$CMIProviderImpl;

  factory _CMIProvider.fromJson(Map<String, dynamic> json) =
      _$CMIProviderImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get adminName;
  @override
  String get adminSurname;
  @override
  String get adminEmail;
  @override
  Map<String, ProviderManager> get managers;
  @override
  String? get apiKey;
  @override
  List<String>? get aims;
  @override
  String? get aim;
  @override
  String? get domainRequirement;
  @override
  bool get releaseWom;
  @override
  @CMIProviderStatusConverter()
  CMIProviderStatus? get status;
  @override
  @MyDateTimeConverter()
  DateTime? get createdOn;
  @override
  @MyDateTimeConverter()
  DateTime get requestedOn;
  @override
  @JsonKey(ignore: true)
  _$$CMIProviderImplCopyWith<_$CMIProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingProviderManager _$PendingProviderManagerFromJson(
    Map<String, dynamic> json) {
  return _PendingProviderManager.fromJson(json);
}

/// @nodoc
mixin _$PendingProviderManager {
  String get id => throw _privateConstructorUsedError;
  @UserRoleConverter()
  UserRole get role => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get secret => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get invitedOn => throw _privateConstructorUsedError;
  @ManagerStatusConverter()
  ProviderManagerStatus get status => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PendingProviderManagerCopyWith<PendingProviderManager> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingProviderManagerCopyWith<$Res> {
  factory $PendingProviderManagerCopyWith(PendingProviderManager value,
          $Res Function(PendingProviderManager) then) =
      _$PendingProviderManagerCopyWithImpl<$Res, PendingProviderManager>;
  @useResult
  $Res call(
      {String id,
      @UserRoleConverter() UserRole role,
      String name,
      String secret,
      String providerName,
      String email,
      @MyDateTimeConverter() DateTime invitedOn,
      @ManagerStatusConverter() ProviderManagerStatus status,
      String? eventId});
}

/// @nodoc
class _$PendingProviderManagerCopyWithImpl<$Res,
        $Val extends PendingProviderManager>
    implements $PendingProviderManagerCopyWith<$Res> {
  _$PendingProviderManagerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? name = null,
    Object? secret = null,
    Object? providerName = null,
    Object? email = null,
    Object? invitedOn = null,
    Object? status = null,
    Object? eventId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      invitedOn: null == invitedOn
          ? _value.invitedOn
          : invitedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProviderManagerStatus,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PendingProviderManagerImplCopyWith<$Res>
    implements $PendingProviderManagerCopyWith<$Res> {
  factory _$$PendingProviderManagerImplCopyWith(
          _$PendingProviderManagerImpl value,
          $Res Function(_$PendingProviderManagerImpl) then) =
      __$$PendingProviderManagerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @UserRoleConverter() UserRole role,
      String name,
      String secret,
      String providerName,
      String email,
      @MyDateTimeConverter() DateTime invitedOn,
      @ManagerStatusConverter() ProviderManagerStatus status,
      String? eventId});
}

/// @nodoc
class __$$PendingProviderManagerImplCopyWithImpl<$Res>
    extends _$PendingProviderManagerCopyWithImpl<$Res,
        _$PendingProviderManagerImpl>
    implements _$$PendingProviderManagerImplCopyWith<$Res> {
  __$$PendingProviderManagerImplCopyWithImpl(
      _$PendingProviderManagerImpl _value,
      $Res Function(_$PendingProviderManagerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? name = null,
    Object? secret = null,
    Object? providerName = null,
    Object? email = null,
    Object? invitedOn = null,
    Object? status = null,
    Object? eventId = freezed,
  }) {
    return _then(_$PendingProviderManagerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      secret: null == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String,
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      invitedOn: null == invitedOn
          ? _value.invitedOn
          : invitedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProviderManagerStatus,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingProviderManagerImpl implements _PendingProviderManager {
  const _$PendingProviderManagerImpl(
      {required this.id,
      @UserRoleConverter() required this.role,
      required this.name,
      required this.secret,
      required this.providerName,
      required this.email,
      @MyDateTimeConverter() required this.invitedOn,
      @ManagerStatusConverter() required this.status,
      this.eventId});

  factory _$PendingProviderManagerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingProviderManagerImplFromJson(json);

  @override
  final String id;
  @override
  @UserRoleConverter()
  final UserRole role;
  @override
  final String name;
  @override
  final String secret;
  @override
  final String providerName;
  @override
  final String email;
  @override
  @MyDateTimeConverter()
  final DateTime invitedOn;
  @override
  @ManagerStatusConverter()
  final ProviderManagerStatus status;
  @override
  final String? eventId;

  @override
  String toString() {
    return 'PendingProviderManager(id: $id, role: $role, name: $name, secret: $secret, providerName: $providerName, email: $email, invitedOn: $invitedOn, status: $status, eventId: $eventId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingProviderManagerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.secret, secret) || other.secret == secret) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.invitedOn, invitedOn) ||
                other.invitedOn == invitedOn) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eventId, eventId) || other.eventId == eventId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, name, secret,
      providerName, email, invitedOn, status, eventId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingProviderManagerImplCopyWith<_$PendingProviderManagerImpl>
      get copyWith => __$$PendingProviderManagerImplCopyWithImpl<
          _$PendingProviderManagerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingProviderManagerImplToJson(
      this,
    );
  }
}

abstract class _PendingProviderManager implements PendingProviderManager {
  const factory _PendingProviderManager(
      {required final String id,
      @UserRoleConverter() required final UserRole role,
      required final String name,
      required final String secret,
      required final String providerName,
      required final String email,
      @MyDateTimeConverter() required final DateTime invitedOn,
      @ManagerStatusConverter() required final ProviderManagerStatus status,
      final String? eventId}) = _$PendingProviderManagerImpl;

  factory _PendingProviderManager.fromJson(Map<String, dynamic> json) =
      _$PendingProviderManagerImpl.fromJson;

  @override
  String get id;
  @override
  @UserRoleConverter()
  UserRole get role;
  @override
  String get name;
  @override
  String get secret;
  @override
  String get providerName;
  @override
  String get email;
  @override
  @MyDateTimeConverter()
  DateTime get invitedOn;
  @override
  @ManagerStatusConverter()
  ProviderManagerStatus get status;
  @override
  String? get eventId;
  @override
  @JsonKey(ignore: true)
  _$$PendingProviderManagerImplCopyWith<_$PendingProviderManagerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProviderManager _$ProviderManagerFromJson(Map<String, dynamic> json) {
  return _ProviderManager.fromJson(json);
}

/// @nodoc
mixin _$ProviderManager {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @UserRoleConverter()
  UserRole get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProviderManagerCopyWith<ProviderManager> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderManagerCopyWith<$Res> {
  factory $ProviderManagerCopyWith(
          ProviderManager value, $Res Function(ProviderManager) then) =
      _$ProviderManagerCopyWithImpl<$Res, ProviderManager>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @UserRoleConverter() UserRole role});
}

/// @nodoc
class _$ProviderManagerCopyWithImpl<$Res, $Val extends ProviderManager>
    implements $ProviderManagerCopyWith<$Res> {
  _$ProviderManagerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProviderManagerImplCopyWith<$Res>
    implements $ProviderManagerCopyWith<$Res> {
  factory _$$ProviderManagerImplCopyWith(_$ProviderManagerImpl value,
          $Res Function(_$ProviderManagerImpl) then) =
      __$$ProviderManagerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @UserRoleConverter() UserRole role});
}

/// @nodoc
class __$$ProviderManagerImplCopyWithImpl<$Res>
    extends _$ProviderManagerCopyWithImpl<$Res, _$ProviderManagerImpl>
    implements _$$ProviderManagerImplCopyWith<$Res> {
  __$$ProviderManagerImplCopyWithImpl(
      _$ProviderManagerImpl _value, $Res Function(_$ProviderManagerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
  }) {
    return _then(_$ProviderManagerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderManagerImpl implements _ProviderManager {
  const _$ProviderManagerImpl(
      {required this.id,
      required this.name,
      required this.email,
      @UserRoleConverter() required this.role});

  factory _$ProviderManagerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderManagerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  @UserRoleConverter()
  final UserRole role;

  @override
  String toString() {
    return 'ProviderManager(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderManagerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderManagerImplCopyWith<_$ProviderManagerImpl> get copyWith =>
      __$$ProviderManagerImplCopyWithImpl<_$ProviderManagerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderManagerImplToJson(
      this,
    );
  }
}

abstract class _ProviderManager implements ProviderManager {
  const factory _ProviderManager(
          {required final String id,
          required final String name,
          required final String email,
          @UserRoleConverter() required final UserRole role}) =
      _$ProviderManagerImpl;

  factory _ProviderManager.fromJson(Map<String, dynamic> json) =
      _$ProviderManagerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @UserRoleConverter()
  UserRole get role;
  @override
  @JsonKey(ignore: true)
  _$$ProviderManagerImplCopyWith<_$ProviderManagerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
