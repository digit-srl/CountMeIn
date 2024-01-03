// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totems_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotemsHash() => r'cc4546e54974f16db5e67a76dc6ebbef5e9d1c49';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getTotems].
@ProviderFor(getTotems)
const getTotemsProvider = GetTotemsFamily();

/// See also [getTotems].
class GetTotemsFamily extends Family<AsyncValue<List<EmbeddedData>>> {
  /// See also [getTotems].
  const GetTotemsFamily();

  /// See also [getTotems].
  GetTotemsProvider call(
    String providerId,
    String eventId,
  ) {
    return GetTotemsProvider(
      providerId,
      eventId,
    );
  }

  @override
  GetTotemsProvider getProviderOverride(
    covariant GetTotemsProvider provider,
  ) {
    return call(
      provider.providerId,
      provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getTotemsProvider';
}

/// See also [getTotems].
class GetTotemsProvider extends AutoDisposeStreamProvider<List<EmbeddedData>> {
  /// See also [getTotems].
  GetTotemsProvider(
    String providerId,
    String eventId,
  ) : this._internal(
          (ref) => getTotems(
            ref as GetTotemsRef,
            providerId,
            eventId,
          ),
          from: getTotemsProvider,
          name: r'getTotemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotemsHash,
          dependencies: GetTotemsFamily._dependencies,
          allTransitiveDependencies: GetTotemsFamily._allTransitiveDependencies,
          providerId: providerId,
          eventId: eventId,
        );

  GetTotemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
    required this.eventId,
  }) : super.internal();

  final String providerId;
  final String eventId;

  @override
  Override overrideWith(
    Stream<List<EmbeddedData>> Function(GetTotemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTotemsProvider._internal(
        (ref) => create(ref as GetTotemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<EmbeddedData>> createElement() {
    return _GetTotemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotemsProvider &&
        other.providerId == providerId &&
        other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotemsRef on AutoDisposeStreamProviderRef<List<EmbeddedData>> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _GetTotemsProviderElement
    extends AutoDisposeStreamProviderElement<List<EmbeddedData>>
    with GetTotemsRef {
  _GetTotemsProviderElement(super.provider);

  @override
  String get providerId => (origin as GetTotemsProvider).providerId;
  @override
  String get eventId => (origin as GetTotemsProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
