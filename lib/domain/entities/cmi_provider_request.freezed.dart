// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cmi_provider_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CMIProviderRequest _$CMIProviderRequestFromJson(Map<String, dynamic> json) {
  return _CMIProviderRequest.fromJson(json);
}

/// @nodoc
mixin _$CMIProviderRequest {
  String get id => throw _privateConstructorUsedError;
  String get adminName => throw _privateConstructorUsedError;
  String get adminSurname => throw _privateConstructorUsedError;
  String get adminEmail => throw _privateConstructorUsedError;
  String get adminCf => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get aim => throw _privateConstructorUsedError;
  bool get releaseWom => throw _privateConstructorUsedError;
  String get pIva => throw _privateConstructorUsedError;
  Map<String, ProviderManager> get managers =>
      throw _privateConstructorUsedError;
  @CMIProviderStatusConverter()
  CMIProviderStatus get status => throw _privateConstructorUsedError;
  String? get apiKey => throw _privateConstructorUsedError;
  List<String>? get aims => throw _privateConstructorUsedError;
  String? get domainRequirement => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get requestedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CMIProviderRequestCopyWith<CMIProviderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CMIProviderRequestCopyWith<$Res> {
  factory $CMIProviderRequestCopyWith(
          CMIProviderRequest value, $Res Function(CMIProviderRequest) then) =
      _$CMIProviderRequestCopyWithImpl<$Res, CMIProviderRequest>;
  @useResult
  $Res call(
      {String id,
      String adminName,
      String adminSurname,
      String adminEmail,
      String adminCf,
      String name,
      String aim,
      bool releaseWom,
      String pIva,
      Map<String, ProviderManager> managers,
      @CMIProviderStatusConverter() CMIProviderStatus status,
      String? apiKey,
      List<String>? aims,
      String? domainRequirement,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class _$CMIProviderRequestCopyWithImpl<$Res, $Val extends CMIProviderRequest>
    implements $CMIProviderRequestCopyWith<$Res> {
  _$CMIProviderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? adminName = null,
    Object? adminSurname = null,
    Object? adminEmail = null,
    Object? adminCf = null,
    Object? name = null,
    Object? aim = null,
    Object? releaseWom = null,
    Object? pIva = null,
    Object? managers = null,
    Object? status = null,
    Object? apiKey = freezed,
    Object? aims = freezed,
    Object? domainRequirement = freezed,
    Object? requestedOn = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      adminCf: null == adminCf
          ? _value.adminCf
          : adminCf // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aim: null == aim
          ? _value.aim
          : aim // ignore: cast_nullable_to_non_nullable
              as String,
      releaseWom: null == releaseWom
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      pIva: null == pIva
          ? _value.pIva
          : pIva // ignore: cast_nullable_to_non_nullable
              as String,
      managers: null == managers
          ? _value.managers
          : managers // ignore: cast_nullable_to_non_nullable
              as Map<String, ProviderManager>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      aims: freezed == aims
          ? _value.aims
          : aims // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      domainRequirement: freezed == domainRequirement
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: null == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CMIProviderRequestCopyWith<$Res>
    implements $CMIProviderRequestCopyWith<$Res> {
  factory _$$_CMIProviderRequestCopyWith(_$_CMIProviderRequest value,
          $Res Function(_$_CMIProviderRequest) then) =
      __$$_CMIProviderRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String adminName,
      String adminSurname,
      String adminEmail,
      String adminCf,
      String name,
      String aim,
      bool releaseWom,
      String pIva,
      Map<String, ProviderManager> managers,
      @CMIProviderStatusConverter() CMIProviderStatus status,
      String? apiKey,
      List<String>? aims,
      String? domainRequirement,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class __$$_CMIProviderRequestCopyWithImpl<$Res>
    extends _$CMIProviderRequestCopyWithImpl<$Res, _$_CMIProviderRequest>
    implements _$$_CMIProviderRequestCopyWith<$Res> {
  __$$_CMIProviderRequestCopyWithImpl(
      _$_CMIProviderRequest _value, $Res Function(_$_CMIProviderRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? adminName = null,
    Object? adminSurname = null,
    Object? adminEmail = null,
    Object? adminCf = null,
    Object? name = null,
    Object? aim = null,
    Object? releaseWom = null,
    Object? pIva = null,
    Object? managers = null,
    Object? status = null,
    Object? apiKey = freezed,
    Object? aims = freezed,
    Object? domainRequirement = freezed,
    Object? requestedOn = null,
  }) {
    return _then(_$_CMIProviderRequest(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      adminCf: null == adminCf
          ? _value.adminCf
          : adminCf // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aim: null == aim
          ? _value.aim
          : aim // ignore: cast_nullable_to_non_nullable
              as String,
      releaseWom: null == releaseWom
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      pIva: null == pIva
          ? _value.pIva
          : pIva // ignore: cast_nullable_to_non_nullable
              as String,
      managers: null == managers
          ? _value._managers
          : managers // ignore: cast_nullable_to_non_nullable
              as Map<String, ProviderManager>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      aims: freezed == aims
          ? _value._aims
          : aims // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      domainRequirement: freezed == domainRequirement
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: null == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CMIProviderRequest implements _CMIProviderRequest {
  const _$_CMIProviderRequest(
      {required this.id,
      required this.adminName,
      required this.adminSurname,
      required this.adminEmail,
      required this.adminCf,
      required this.name,
      required this.aim,
      required this.releaseWom,
      required this.pIva,
      required final Map<String, ProviderManager> managers,
      @CMIProviderStatusConverter() required this.status,
      this.apiKey,
      final List<String>? aims,
      this.domainRequirement,
      @MyDateTimeConverter() required this.requestedOn})
      : _managers = managers,
        _aims = aims;

  factory _$_CMIProviderRequest.fromJson(Map<String, dynamic> json) =>
      _$$_CMIProviderRequestFromJson(json);

  @override
  final String id;
  @override
  final String adminName;
  @override
  final String adminSurname;
  @override
  final String adminEmail;
  @override
  final String adminCf;
  @override
  final String name;
  @override
  final String aim;
  @override
  final bool releaseWom;
  @override
  final String pIva;
  final Map<String, ProviderManager> _managers;
  @override
  Map<String, ProviderManager> get managers {
    if (_managers is EqualUnmodifiableMapView) return _managers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_managers);
  }

  @override
  @CMIProviderStatusConverter()
  final CMIProviderStatus status;
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
  final String? domainRequirement;
  @override
  @MyDateTimeConverter()
  final DateTime requestedOn;

  @override
  String toString() {
    return 'CMIProviderRequest(id: $id, adminName: $adminName, adminSurname: $adminSurname, adminEmail: $adminEmail, adminCf: $adminCf, name: $name, aim: $aim, releaseWom: $releaseWom, pIva: $pIva, managers: $managers, status: $status, apiKey: $apiKey, aims: $aims, domainRequirement: $domainRequirement, requestedOn: $requestedOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMIProviderRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.adminName, adminName) ||
                other.adminName == adminName) &&
            (identical(other.adminSurname, adminSurname) ||
                other.adminSurname == adminSurname) &&
            (identical(other.adminEmail, adminEmail) ||
                other.adminEmail == adminEmail) &&
            (identical(other.adminCf, adminCf) || other.adminCf == adminCf) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aim, aim) || other.aim == aim) &&
            (identical(other.releaseWom, releaseWom) ||
                other.releaseWom == releaseWom) &&
            (identical(other.pIva, pIva) || other.pIva == pIva) &&
            const DeepCollectionEquality().equals(other._managers, _managers) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            const DeepCollectionEquality().equals(other._aims, _aims) &&
            (identical(other.domainRequirement, domainRequirement) ||
                other.domainRequirement == domainRequirement) &&
            (identical(other.requestedOn, requestedOn) ||
                other.requestedOn == requestedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      adminName,
      adminSurname,
      adminEmail,
      adminCf,
      name,
      aim,
      releaseWom,
      pIva,
      const DeepCollectionEquality().hash(_managers),
      status,
      apiKey,
      const DeepCollectionEquality().hash(_aims),
      domainRequirement,
      requestedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CMIProviderRequestCopyWith<_$_CMIProviderRequest> get copyWith =>
      __$$_CMIProviderRequestCopyWithImpl<_$_CMIProviderRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CMIProviderRequestToJson(
      this,
    );
  }
}

abstract class _CMIProviderRequest implements CMIProviderRequest {
  const factory _CMIProviderRequest(
          {required final String id,
          required final String adminName,
          required final String adminSurname,
          required final String adminEmail,
          required final String adminCf,
          required final String name,
          required final String aim,
          required final bool releaseWom,
          required final String pIva,
          required final Map<String, ProviderManager> managers,
          @CMIProviderStatusConverter() required final CMIProviderStatus status,
          final String? apiKey,
          final List<String>? aims,
          final String? domainRequirement,
          @MyDateTimeConverter() required final DateTime requestedOn}) =
      _$_CMIProviderRequest;

  factory _CMIProviderRequest.fromJson(Map<String, dynamic> json) =
      _$_CMIProviderRequest.fromJson;

  @override
  String get id;
  @override
  String get adminName;
  @override
  String get adminSurname;
  @override
  String get adminEmail;
  @override
  String get adminCf;
  @override
  String get name;
  @override
  String get aim;
  @override
  bool get releaseWom;
  @override
  String get pIva;
  @override
  Map<String, ProviderManager> get managers;
  @override
  @CMIProviderStatusConverter()
  CMIProviderStatus get status;
  @override
  String? get apiKey;
  @override
  List<String>? get aims;
  @override
  String? get domainRequirement;
  @override
  @MyDateTimeConverter()
  DateTime get requestedOn;
  @override
  @JsonKey(ignore: true)
  _$$_CMIProviderRequestCopyWith<_$_CMIProviderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
