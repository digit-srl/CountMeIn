// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totems_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotemsHash() => r'258c2d77ebfdf4ed05f442d502b2416b59d9be38';

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
    String sessionId,
  ) {
    return GetTotemsProvider(
      providerId,
      eventId,
      sessionId,
    );
  }

  @override
  GetTotemsProvider getProviderOverride(
    covariant GetTotemsProvider provider,
  ) {
    return call(
      provider.providerId,
      provider.eventId,
      provider.sessionId,
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
    String sessionId,
  ) : this._internal(
          (ref) => getTotems(
            ref as GetTotemsRef,
            providerId,
            eventId,
            sessionId,
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
          sessionId: sessionId,
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
    required this.sessionId,
  }) : super.internal();

  final String providerId;
  final String eventId;
  final String sessionId;

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
        sessionId: sessionId,
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
        other.eventId == eventId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotemsRef on AutoDisposeStreamProviderRef<List<EmbeddedData>> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;

  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _GetTotemsProviderElement
    extends AutoDisposeStreamProviderElement<List<EmbeddedData>>
    with GetTotemsRef {
  _GetTotemsProviderElement(super.provider);

  @override
  String get providerId => (origin as GetTotemsProvider).providerId;
  @override
  String get eventId => (origin as GetTotemsProvider).eventId;
  @override
  String get sessionId => (origin as GetTotemsProvider).sessionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
