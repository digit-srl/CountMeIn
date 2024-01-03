// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotemDataHash() => r'0eb56fbe28e926a73ffb5ce00fa5c90ebe8c255d';

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

/// See also [getTotemData].
@ProviderFor(getTotemData)
const getTotemDataProvider = GetTotemDataFamily();

/// See also [getTotemData].
class GetTotemDataFamily extends Family<AsyncValue<EmbeddedData>> {
  /// See also [getTotemData].
  const GetTotemDataFamily();

  /// See also [getTotemData].
  GetTotemDataProvider call(
    String providerId,
    String eventId,
    String sessionId,
    String totemId,
  ) {
    return GetTotemDataProvider(
      providerId,
      eventId,
      sessionId,
      totemId,
    );
  }

  @override
  GetTotemDataProvider getProviderOverride(
    covariant GetTotemDataProvider provider,
  ) {
    return call(
      provider.providerId,
      provider.eventId,
      provider.sessionId,
      provider.totemId,
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
  String? get name => r'getTotemDataProvider';
}

/// See also [getTotemData].
class GetTotemDataProvider extends AutoDisposeStreamProvider<EmbeddedData> {
  /// See also [getTotemData].
  GetTotemDataProvider(
    String providerId,
    String eventId,
    String sessionId,
    String totemId,
  ) : this._internal(
          (ref) => getTotemData(
            ref as GetTotemDataRef,
            providerId,
            eventId,
            sessionId,
            totemId,
          ),
          from: getTotemDataProvider,
          name: r'getTotemDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotemDataHash,
          dependencies: GetTotemDataFamily._dependencies,
          allTransitiveDependencies:
              GetTotemDataFamily._allTransitiveDependencies,
          providerId: providerId,
          eventId: eventId,
          sessionId: sessionId,
          totemId: totemId,
        );

  GetTotemDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
    required this.eventId,
    required this.sessionId,
    required this.totemId,
  }) : super.internal();

  final String providerId;
  final String eventId;
  final String sessionId;
  final String totemId;

  @override
  Override overrideWith(
    Stream<EmbeddedData> Function(GetTotemDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTotemDataProvider._internal(
        (ref) => create(ref as GetTotemDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
        eventId: eventId,
        sessionId: sessionId,
        totemId: totemId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<EmbeddedData> createElement() {
    return _GetTotemDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotemDataProvider &&
        other.providerId == providerId &&
        other.eventId == eventId &&
        other.sessionId == sessionId &&
        other.totemId == totemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);
    hash = _SystemHash.combine(hash, totemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotemDataRef on AutoDisposeStreamProviderRef<EmbeddedData> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;

  /// The parameter `sessionId` of this provider.
  String get sessionId;

  /// The parameter `totemId` of this provider.
  String get totemId;
}

class _GetTotemDataProviderElement
    extends AutoDisposeStreamProviderElement<EmbeddedData>
    with GetTotemDataRef {
  _GetTotemDataProviderElement(super.provider);

  @override
  String get providerId => (origin as GetTotemDataProvider).providerId;
  @override
  String get eventId => (origin as GetTotemDataProvider).eventId;
  @override
  String get sessionId => (origin as GetTotemDataProvider).sessionId;
  @override
  String get totemId => (origin as GetTotemDataProvider).totemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
