// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  String get adminCF => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get releaseWom => throw _privateConstructorUsedError;
  String get pIva => throw _privateConstructorUsedError;
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
      _$CMIProviderRequestCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String adminName,
      String adminSurname,
      String adminEmail,
      String adminCF,
      String name,
      bool releaseWom,
      String pIva,
      @CMIProviderStatusConverter() CMIProviderStatus status,
      String? apiKey,
      List<String>? aims,
      String? domainRequirement,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class _$CMIProviderRequestCopyWithImpl<$Res>
    implements $CMIProviderRequestCopyWith<$Res> {
  _$CMIProviderRequestCopyWithImpl(this._value, this._then);

  final CMIProviderRequest _value;
  // ignore: unused_field
  final $Res Function(CMIProviderRequest) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? adminName = freezed,
    Object? adminSurname = freezed,
    Object? adminEmail = freezed,
    Object? adminCF = freezed,
    Object? name = freezed,
    Object? releaseWom = freezed,
    Object? pIva = freezed,
    Object? status = freezed,
    Object? apiKey = freezed,
    Object? aims = freezed,
    Object? domainRequirement = freezed,
    Object? requestedOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: adminName == freezed
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      adminSurname: adminSurname == freezed
          ? _value.adminSurname
          : adminSurname // ignore: cast_nullable_to_non_nullable
              as String,
      adminEmail: adminEmail == freezed
          ? _value.adminEmail
          : adminEmail // ignore: cast_nullable_to_non_nullable
              as String,
      adminCF: adminCF == freezed
          ? _value.adminCF
          : adminCF // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      releaseWom: releaseWom == freezed
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      pIva: pIva == freezed
          ? _value.pIva
          : pIva // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus,
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      aims: aims == freezed
          ? _value.aims
          : aims // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      domainRequirement: domainRequirement == freezed
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: requestedOn == freezed
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_CMIProviderRequestCopyWith<$Res>
    implements $CMIProviderRequestCopyWith<$Res> {
  factory _$$_CMIProviderRequestCopyWith(_$_CMIProviderRequest value,
          $Res Function(_$_CMIProviderRequest) then) =
      __$$_CMIProviderRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String adminName,
      String adminSurname,
      String adminEmail,
      String adminCF,
      String name,
      bool releaseWom,
      String pIva,
      @CMIProviderStatusConverter() CMIProviderStatus status,
      String? apiKey,
      List<String>? aims,
      String? domainRequirement,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class __$$_CMIProviderRequestCopyWithImpl<$Res>
    extends _$CMIProviderRequestCopyWithImpl<$Res>
    implements _$$_CMIProviderRequestCopyWith<$Res> {
  __$$_CMIProviderRequestCopyWithImpl(
      _$_CMIProviderRequest _value, $Res Function(_$_CMIProviderRequest) _then)
      : super(_value, (v) => _then(v as _$_CMIProviderRequest));

  @override
  _$_CMIProviderRequest get _value => super._value as _$_CMIProviderRequest;

  @override
  $Res call({
    Object? id = freezed,
    Object? adminName = freezed,
    Object? adminSurname = freezed,
    Object? adminEmail = freezed,
    Object? adminCF = freezed,
    Object? name = freezed,
    Object? releaseWom = freezed,
    Object? pIva = freezed,
    Object? status = freezed,
    Object? apiKey = freezed,
    Object? aims = freezed,
    Object? domainRequirement = freezed,
    Object? requestedOn = freezed,
  }) {
    return _then(_$_CMIProviderRequest(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: adminName == freezed
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      adminSurname: adminSurname == freezed
          ? _value.adminSurname
          : adminSurname // ignore: cast_nullable_to_non_nullable
              as String,
      adminEmail: adminEmail == freezed
          ? _value.adminEmail
          : adminEmail // ignore: cast_nullable_to_non_nullable
              as String,
      adminCF: adminCF == freezed
          ? _value.adminCF
          : adminCF // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      releaseWom: releaseWom == freezed
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      pIva: pIva == freezed
          ? _value.pIva
          : pIva // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus,
      apiKey: apiKey == freezed
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      aims: aims == freezed
          ? _value._aims
          : aims // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      domainRequirement: domainRequirement == freezed
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: requestedOn == freezed
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
      required this.adminCF,
      required this.name,
      required this.releaseWom,
      required this.pIva,
      @CMIProviderStatusConverter() required this.status,
      this.apiKey,
      final List<String>? aims,
      this.domainRequirement,
      @MyDateTimeConverter() required this.requestedOn})
      : _aims = aims;

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
  final String adminCF;
  @override
  final String name;
  @override
  final bool releaseWom;
  @override
  final String pIva;
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
    return 'CMIProviderRequest(id: $id, adminName: $adminName, adminSurname: $adminSurname, adminEmail: $adminEmail, adminCF: $adminCF, name: $name, releaseWom: $releaseWom, pIva: $pIva, status: $status, apiKey: $apiKey, aims: $aims, domainRequirement: $domainRequirement, requestedOn: $requestedOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMIProviderRequest &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.adminName, adminName) &&
            const DeepCollectionEquality()
                .equals(other.adminSurname, adminSurname) &&
            const DeepCollectionEquality()
                .equals(other.adminEmail, adminEmail) &&
            const DeepCollectionEquality().equals(other.adminCF, adminCF) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.releaseWom, releaseWom) &&
            const DeepCollectionEquality().equals(other.pIva, pIva) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.apiKey, apiKey) &&
            const DeepCollectionEquality().equals(other._aims, _aims) &&
            const DeepCollectionEquality()
                .equals(other.domainRequirement, domainRequirement) &&
            const DeepCollectionEquality()
                .equals(other.requestedOn, requestedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(adminName),
      const DeepCollectionEquality().hash(adminSurname),
      const DeepCollectionEquality().hash(adminEmail),
      const DeepCollectionEquality().hash(adminCF),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(releaseWom),
      const DeepCollectionEquality().hash(pIva),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(apiKey),
      const DeepCollectionEquality().hash(_aims),
      const DeepCollectionEquality().hash(domainRequirement),
      const DeepCollectionEquality().hash(requestedOn));

  @JsonKey(ignore: true)
  @override
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
          required final String adminCF,
          required final String name,
          required final bool releaseWom,
          required final String pIva,
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
  String get adminCF;
  @override
  String get name;
  @override
  bool get releaseWom;
  @override
  String get pIva;
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
