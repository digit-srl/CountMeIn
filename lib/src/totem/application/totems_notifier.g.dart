// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totems_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotemsHash() => r'e537ea48301a244f3bee39132042aaae2384216e';

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

String _$getTotemsByEventHash() => r'1e031939a741ec008c52e6e74b25de6c19a495ca';

/// See also [getTotemsByEvent].
@ProviderFor(getTotemsByEvent)
const getTotemsByEventProvider = GetTotemsByEventFamily();

/// See also [getTotemsByEvent].
class GetTotemsByEventFamily extends Family<AsyncValue<List<EmbeddedData>>> {
  /// See also [getTotemsByEvent].
  const GetTotemsByEventFamily();

  /// See also [getTotemsByEvent].
  GetTotemsByEventProvider call(
    String providerId,
    String eventId,
  ) {
    return GetTotemsByEventProvider(
      providerId,
      eventId,
    );
  }

  @override
  GetTotemsByEventProvider getProviderOverride(
    covariant GetTotemsByEventProvider provider,
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
  String? get name => r'getTotemsByEventProvider';
}

/// See also [getTotemsByEvent].
class GetTotemsByEventProvider
    extends AutoDisposeStreamProvider<List<EmbeddedData>> {
  /// See also [getTotemsByEvent].
  GetTotemsByEventProvider(
    String providerId,
    String eventId,
  ) : this._internal(
          (ref) => getTotemsByEvent(
            ref as GetTotemsByEventRef,
            providerId,
            eventId,
          ),
          from: getTotemsByEventProvider,
          name: r'getTotemsByEventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotemsByEventHash,
          dependencies: GetTotemsByEventFamily._dependencies,
          allTransitiveDependencies:
              GetTotemsByEventFamily._allTransitiveDependencies,
          providerId: providerId,
          eventId: eventId,
        );

  GetTotemsByEventProvider._internal(
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
    Stream<List<EmbeddedData>> Function(GetTotemsByEventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTotemsByEventProvider._internal(
        (ref) => create(ref as GetTotemsByEventRef),
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
    return _GetTotemsByEventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotemsByEventProvider &&
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

mixin GetTotemsByEventRef on AutoDisposeStreamProviderRef<List<EmbeddedData>> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _GetTotemsByEventProviderElement
    extends AutoDisposeStreamProviderElement<List<EmbeddedData>>
    with GetTotemsByEventRef {
  _GetTotemsByEventProviderElement(super.provider);

  @override
  String get providerId => (origin as GetTotemsByEventProvider).providerId;
  @override
  String get eventId => (origin as GetTotemsByEventProvider).eventId;
}

String _$getAvailableTotemsHash() =>
    r'8cb2d8cb2a1d4618c04cb903d9da0eec07fda3ac';

/// See also [getAvailableTotems].
@ProviderFor(getAvailableTotems)
const getAvailableTotemsProvider = GetAvailableTotemsFamily();

/// See also [getAvailableTotems].
class GetAvailableTotemsFamily extends Family<AsyncValue<List<EmbeddedData>>> {
  /// See also [getAvailableTotems].
  const GetAvailableTotemsFamily();

  /// See also [getAvailableTotems].
  GetAvailableTotemsProvider call(
    String providerId,
  ) {
    return GetAvailableTotemsProvider(
      providerId,
    );
  }

  @override
  GetAvailableTotemsProvider getProviderOverride(
    covariant GetAvailableTotemsProvider provider,
  ) {
    return call(
      provider.providerId,
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
  String? get name => r'getAvailableTotemsProvider';
}

/// See also [getAvailableTotems].
class GetAvailableTotemsProvider
    extends AutoDisposeStreamProvider<List<EmbeddedData>> {
  /// See also [getAvailableTotems].
  GetAvailableTotemsProvider(
    String providerId,
  ) : this._internal(
          (ref) => getAvailableTotems(
            ref as GetAvailableTotemsRef,
            providerId,
          ),
          from: getAvailableTotemsProvider,
          name: r'getAvailableTotemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAvailableTotemsHash,
          dependencies: GetAvailableTotemsFamily._dependencies,
          allTransitiveDependencies:
              GetAvailableTotemsFamily._allTransitiveDependencies,
          providerId: providerId,
        );

  GetAvailableTotemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
  }) : super.internal();

  final String providerId;

  @override
  Override overrideWith(
    Stream<List<EmbeddedData>> Function(GetAvailableTotemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAvailableTotemsProvider._internal(
        (ref) => create(ref as GetAvailableTotemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<EmbeddedData>> createElement() {
    return _GetAvailableTotemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAvailableTotemsProvider &&
        other.providerId == providerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAvailableTotemsRef
    on AutoDisposeStreamProviderRef<List<EmbeddedData>> {
  /// The parameter `providerId` of this provider.
  String get providerId;
}

class _GetAvailableTotemsProviderElement
    extends AutoDisposeStreamProviderElement<List<EmbeddedData>>
    with GetAvailableTotemsRef {
  _GetAvailableTotemsProviderElement(super.provider);

  @override
  String get providerId => (origin as GetAvailableTotemsProvider).providerId;
}

String _$getProviderTotemsHash() => r'a42e381fad7973a808d50527a0e574bac4cdb70c';

/// See also [getProviderTotems].
@ProviderFor(getProviderTotems)
const getProviderTotemsProvider = GetProviderTotemsFamily();

/// See also [getProviderTotems].
class GetProviderTotemsFamily extends Family<AsyncValue<List<EmbeddedData>>> {
  /// See also [getProviderTotems].
  const GetProviderTotemsFamily();

  /// See also [getProviderTotems].
  GetProviderTotemsProvider call(
    String providerId,
  ) {
    return GetProviderTotemsProvider(
      providerId,
    );
  }

  @override
  GetProviderTotemsProvider getProviderOverride(
    covariant GetProviderTotemsProvider provider,
  ) {
    return call(
      provider.providerId,
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
  String? get name => r'getProviderTotemsProvider';
}

/// See also [getProviderTotems].
class GetProviderTotemsProvider
    extends AutoDisposeStreamProvider<List<EmbeddedData>> {
  /// See also [getProviderTotems].
  GetProviderTotemsProvider(
    String providerId,
  ) : this._internal(
          (ref) => getProviderTotems(
            ref as GetProviderTotemsRef,
            providerId,
          ),
          from: getProviderTotemsProvider,
          name: r'getProviderTotemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProviderTotemsHash,
          dependencies: GetProviderTotemsFamily._dependencies,
          allTransitiveDependencies:
              GetProviderTotemsFamily._allTransitiveDependencies,
          providerId: providerId,
        );

  GetProviderTotemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
  }) : super.internal();

  final String providerId;

  @override
  Override overrideWith(
    Stream<List<EmbeddedData>> Function(GetProviderTotemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProviderTotemsProvider._internal(
        (ref) => create(ref as GetProviderTotemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<EmbeddedData>> createElement() {
    return _GetProviderTotemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProviderTotemsProvider && other.providerId == providerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProviderTotemsRef on AutoDisposeStreamProviderRef<List<EmbeddedData>> {
  /// The parameter `providerId` of this provider.
  String get providerId;
}

class _GetProviderTotemsProviderElement
    extends AutoDisposeStreamProviderElement<List<EmbeddedData>>
    with GetProviderTotemsRef {
  _GetProviderTotemsProviderElement(super.provider);

  @override
  String get providerId => (origin as GetProviderTotemsProvider).providerId;
}

String _$getSessionTotemsHash() => r'aafb4b96d78fe489e87f84ca406ed0f1e22b68ef';

/// See also [getSessionTotems].
@ProviderFor(getSessionTotems)
const getSessionTotemsProvider = GetSessionTotemsFamily();

/// See also [getSessionTotems].
class GetSessionTotemsFamily extends Family<AsyncValue<List<EmbeddedData>>> {
  /// See also [getSessionTotems].
  const GetSessionTotemsFamily();

  /// See also [getSessionTotems].
  GetSessionTotemsProvider call(
    String providerId,
    String eventId,
    String sessionId,
  ) {
    return GetSessionTotemsProvider(
      providerId,
      eventId,
      sessionId,
    );
  }

  @override
  GetSessionTotemsProvider getProviderOverride(
    covariant GetSessionTotemsProvider provider,
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
  String? get name => r'getSessionTotemsProvider';
}

/// See also [getSessionTotems].
class GetSessionTotemsProvider
    extends AutoDisposeStreamProvider<List<EmbeddedData>> {
  /// See also [getSessionTotems].
  GetSessionTotemsProvider(
    String providerId,
    String eventId,
    String sessionId,
  ) : this._internal(
          (ref) => getSessionTotems(
            ref as GetSessionTotemsRef,
            providerId,
            eventId,
            sessionId,
          ),
          from: getSessionTotemsProvider,
          name: r'getSessionTotemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSessionTotemsHash,
          dependencies: GetSessionTotemsFamily._dependencies,
          allTransitiveDependencies:
              GetSessionTotemsFamily._allTransitiveDependencies,
          providerId: providerId,
          eventId: eventId,
          sessionId: sessionId,
        );

  GetSessionTotemsProvider._internal(
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
    Stream<List<EmbeddedData>> Function(GetSessionTotemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSessionTotemsProvider._internal(
        (ref) => create(ref as GetSessionTotemsRef),
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
    return _GetSessionTotemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSessionTotemsProvider &&
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

mixin GetSessionTotemsRef on AutoDisposeStreamProviderRef<List<EmbeddedData>> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;

  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _GetSessionTotemsProviderElement
    extends AutoDisposeStreamProviderElement<List<EmbeddedData>>
    with GetSessionTotemsRef {
  _GetSessionTotemsProviderElement(super.provider);

  @override
  String get providerId => (origin as GetSessionTotemsProvider).providerId;
  @override
  String get eventId => (origin as GetSessionTotemsProvider).eventId;
  @override
  String get sessionId => (origin as GetSessionTotemsProvider).sessionId;
}

String _$getTotemDataHash() => r'a3c29cb3aa7a8aa4211373a508281c8be498d986';

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
    String totemId,
  ) {
    return GetTotemDataProvider(
      providerId,
      totemId,
    );
  }

  @override
  GetTotemDataProvider getProviderOverride(
    covariant GetTotemDataProvider provider,
  ) {
    return call(
      provider.providerId,
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
    String totemId,
  ) : this._internal(
          (ref) => getTotemData(
            ref as GetTotemDataRef,
            providerId,
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
    required this.totemId,
  }) : super.internal();

  final String providerId;
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
        other.totemId == totemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);
    hash = _SystemHash.combine(hash, totemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotemDataRef on AutoDisposeStreamProviderRef<EmbeddedData> {
  /// The parameter `providerId` of this provider.
  String get providerId;

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
  String get totemId => (origin as GetTotemDataProvider).totemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
