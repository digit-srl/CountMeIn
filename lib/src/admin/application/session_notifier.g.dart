// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionsStreamHash() => r'bf0141dfeb614dac2f42ccddf5fcaa184ac8450c';

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

/// See also [sessionsStream].
@ProviderFor(sessionsStream)
const sessionsStreamProvider = SessionsStreamFamily();

/// See also [sessionsStream].
class SessionsStreamFamily extends Family<AsyncValue<List<CMISubEvent>>> {
  /// See also [sessionsStream].
  const SessionsStreamFamily();

  /// See also [sessionsStream].
  SessionsStreamProvider call(
    EventIds ids,
  ) {
    return SessionsStreamProvider(
      ids,
    );
  }

  @override
  SessionsStreamProvider getProviderOverride(
    covariant SessionsStreamProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'sessionsStreamProvider';
}

/// See also [sessionsStream].
class SessionsStreamProvider
    extends AutoDisposeStreamProvider<List<CMISubEvent>> {
  /// See also [sessionsStream].
  SessionsStreamProvider(
    EventIds ids,
  ) : this._internal(
          (ref) => sessionsStream(
            ref as SessionsStreamRef,
            ids,
          ),
          from: sessionsStreamProvider,
          name: r'sessionsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionsStreamHash,
          dependencies: SessionsStreamFamily._dependencies,
          allTransitiveDependencies:
              SessionsStreamFamily._allTransitiveDependencies,
          ids: ids,
        );

  SessionsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
  }) : super.internal();

  final EventIds ids;

  @override
  Override overrideWith(
    Stream<List<CMISubEvent>> Function(SessionsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionsStreamProvider._internal(
        (ref) => create(ref as SessionsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CMISubEvent>> createElement() {
    return _SessionsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionsStreamProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SessionsStreamRef on AutoDisposeStreamProviderRef<List<CMISubEvent>> {
  /// The parameter `ids` of this provider.
  EventIds get ids;
}

class _SessionsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<CMISubEvent>>
    with SessionsStreamRef {
  _SessionsStreamProviderElement(super.provider);

  @override
  EventIds get ids => (origin as SessionsStreamProvider).ids;
}

String _$getSessionHash() => r'472639b77eeeeba928645b90cc80213abc3c17cb';

/// See also [getSession].
@ProviderFor(getSession)
const getSessionProvider = GetSessionFamily();

/// See also [getSession].
class GetSessionFamily extends Family<AsyncValue<CMISubEvent>> {
  /// See also [getSession].
  const GetSessionFamily();

  /// See also [getSession].
  GetSessionProvider call(
    EventIds ids,
  ) {
    return GetSessionProvider(
      ids,
    );
  }

  @override
  GetSessionProvider getProviderOverride(
    covariant GetSessionProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'getSessionProvider';
}

/// See also [getSession].
class GetSessionProvider extends AutoDisposeStreamProvider<CMISubEvent> {
  /// See also [getSession].
  GetSessionProvider(
    EventIds ids,
  ) : this._internal(
          (ref) => getSession(
            ref as GetSessionRef,
            ids,
          ),
          from: getSessionProvider,
          name: r'getSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSessionHash,
          dependencies: GetSessionFamily._dependencies,
          allTransitiveDependencies:
              GetSessionFamily._allTransitiveDependencies,
          ids: ids,
        );

  GetSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
  }) : super.internal();

  final EventIds ids;

  @override
  Override overrideWith(
    Stream<CMISubEvent> Function(GetSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSessionProvider._internal(
        (ref) => create(ref as GetSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<CMISubEvent> createElement() {
    return _GetSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSessionProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSessionRef on AutoDisposeStreamProviderRef<CMISubEvent> {
  /// The parameter `ids` of this provider.
  EventIds get ids;
}

class _GetSessionProviderElement
    extends AutoDisposeStreamProviderElement<CMISubEvent> with GetSessionRef {
  _GetSessionProviderElement(super.provider);

  @override
  EventIds get ids => (origin as GetSessionProvider).ids;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
