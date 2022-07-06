// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cmi_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CMIProvider _$CMIProviderFromJson(Map<String, dynamic> json) {
  return _CMIProvider.fromJson(json);
}

/// @nodoc
mixin _$CMIProvider {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get domainRequirement => throw _privateConstructorUsedError;
  bool get acceptPassepartout => throw _privateConstructorUsedError;
  bool get releaseWom => throw _privateConstructorUsedError;
  @CMIProviderStatusConverter()
  CMIProviderStatus? get status => throw _privateConstructorUsedError;
  @MyDateTimeConverter()
  DateTime get createdOn => throw _privateConstructorUsedError;
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
      _$CMIProviderCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String? domainRequirement,
      bool acceptPassepartout,
      bool releaseWom,
      @CMIProviderStatusConverter() CMIProviderStatus? status,
      @MyDateTimeConverter() DateTime createdOn,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class _$CMIProviderCopyWithImpl<$Res> implements $CMIProviderCopyWith<$Res> {
  _$CMIProviderCopyWithImpl(this._value, this._then);

  final CMIProvider _value;
  // ignore: unused_field
  final $Res Function(CMIProvider) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? domainRequirement = freezed,
    Object? acceptPassepartout = freezed,
    Object? releaseWom = freezed,
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
      domainRequirement: domainRequirement == freezed
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptPassepartout: acceptPassepartout == freezed
          ? _value.acceptPassepartout
          : acceptPassepartout // ignore: cast_nullable_to_non_nullable
              as bool,
      releaseWom: releaseWom == freezed
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestedOn: requestedOn == freezed
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_CMIProviderCopyWith<$Res>
    implements $CMIProviderCopyWith<$Res> {
  factory _$$_CMIProviderCopyWith(
          _$_CMIProvider value, $Res Function(_$_CMIProvider) then) =
      __$$_CMIProviderCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String? domainRequirement,
      bool acceptPassepartout,
      bool releaseWom,
      @CMIProviderStatusConverter() CMIProviderStatus? status,
      @MyDateTimeConverter() DateTime createdOn,
      @MyDateTimeConverter() DateTime requestedOn});
}

/// @nodoc
class __$$_CMIProviderCopyWithImpl<$Res> extends _$CMIProviderCopyWithImpl<$Res>
    implements _$$_CMIProviderCopyWith<$Res> {
  __$$_CMIProviderCopyWithImpl(
      _$_CMIProvider _value, $Res Function(_$_CMIProvider) _then)
      : super(_value, (v) => _then(v as _$_CMIProvider));

  @override
  _$_CMIProvider get _value => super._value as _$_CMIProvider;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? domainRequirement = freezed,
    Object? acceptPassepartout = freezed,
    Object? releaseWom = freezed,
    Object? status = freezed,
    Object? createdOn = freezed,
    Object? requestedOn = freezed,
  }) {
    return _then(_$_CMIProvider(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      domainRequirement: domainRequirement == freezed
          ? _value.domainRequirement
          : domainRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptPassepartout: acceptPassepartout == freezed
          ? _value.acceptPassepartout
          : acceptPassepartout // ignore: cast_nullable_to_non_nullable
              as bool,
      releaseWom: releaseWom == freezed
          ? _value.releaseWom
          : releaseWom // ignore: cast_nullable_to_non_nullable
              as bool,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CMIProviderStatus?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestedOn: requestedOn == freezed
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CMIProvider implements _CMIProvider {
  const _$_CMIProvider(
      {required this.id,
      required this.name,
      this.domainRequirement,
      this.acceptPassepartout = false,
      this.releaseWom = false,
      @CMIProviderStatusConverter() this.status,
      @MyDateTimeConverter() required this.createdOn,
      @MyDateTimeConverter() required this.requestedOn});

  factory _$_CMIProvider.fromJson(Map<String, dynamic> json) =>
      _$$_CMIProviderFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? domainRequirement;
  @override
  @JsonKey()
  final bool acceptPassepartout;
  @override
  @JsonKey()
  final bool releaseWom;
  @override
  @CMIProviderStatusConverter()
  final CMIProviderStatus? status;
  @override
  @MyDateTimeConverter()
  final DateTime createdOn;
  @override
  @MyDateTimeConverter()
  final DateTime requestedOn;

  @override
  String toString() {
    return 'CMIProvider(id: $id, name: $name, domainRequirement: $domainRequirement, acceptPassepartout: $acceptPassepartout, releaseWom: $releaseWom, status: $status, createdOn: $createdOn, requestedOn: $requestedOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CMIProvider &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.domainRequirement, domainRequirement) &&
            const DeepCollectionEquality()
                .equals(other.acceptPassepartout, acceptPassepartout) &&
            const DeepCollectionEquality()
                .equals(other.releaseWom, releaseWom) &&
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
      const DeepCollectionEquality().hash(domainRequirement),
      const DeepCollectionEquality().hash(acceptPassepartout),
      const DeepCollectionEquality().hash(releaseWom),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(createdOn),
      const DeepCollectionEquality().hash(requestedOn));

  @JsonKey(ignore: true)
  @override
  _$$_CMIProviderCopyWith<_$_CMIProvider> get copyWith =>
      __$$_CMIProviderCopyWithImpl<_$_CMIProvider>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CMIProviderToJson(this);
  }
}

abstract class _CMIProvider implements CMIProvider {
  const factory _CMIProvider(
          {required final String id,
          required final String name,
          final String? domainRequirement,
          final bool acceptPassepartout,
          final bool releaseWom,
          @CMIProviderStatusConverter() final CMIProviderStatus? status,
          @MyDateTimeConverter() required final DateTime createdOn,
          @MyDateTimeConverter() required final DateTime requestedOn}) =
      _$_CMIProvider;

  factory _CMIProvider.fromJson(Map<String, dynamic> json) =
      _$_CMIProvider.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get domainRequirement => throw _privateConstructorUsedError;
  @override
  bool get acceptPassepartout => throw _privateConstructorUsedError;
  @override
  bool get releaseWom => throw _privateConstructorUsedError;
  @override
  @CMIProviderStatusConverter()
  CMIProviderStatus? get status => throw _privateConstructorUsedError;
  @override
  @MyDateTimeConverter()
  DateTime get createdOn => throw _privateConstructorUsedError;
  @override
  @MyDateTimeConverter()
  DateTime get requestedOn => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CMIProviderCopyWith<_$_CMIProvider> get copyWith =>
      throw _privateConstructorUsedError;
}
