// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sessions_batch_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createSessionsBatchNotifierHash() =>
    r'c9434a69f80a9378b317ec791090681b0d4ddddf';

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

abstract class _$CreateSessionsBatchNotifier
    extends BuildlessAutoDisposeNotifier<CreateSessionsBatchState> {
  late final String providerId;
  late final String eventId;

  CreateSessionsBatchState build(
    String providerId,
    String eventId,
  );
}

/// See also [CreateSessionsBatchNotifier].
@ProviderFor(CreateSessionsBatchNotifier)
const createSessionsBatchNotifierProvider = CreateSessionsBatchNotifierFamily();

/// See also [CreateSessionsBatchNotifier].
class CreateSessionsBatchNotifierFamily
    extends Family<CreateSessionsBatchState> {
  /// See also [CreateSessionsBatchNotifier].
  const CreateSessionsBatchNotifierFamily();

  /// See also [CreateSessionsBatchNotifier].
  CreateSessionsBatchNotifierProvider call(
    String providerId,
    String eventId,
  ) {
    return CreateSessionsBatchNotifierProvider(
      providerId,
      eventId,
    );
  }

  @override
  CreateSessionsBatchNotifierProvider getProviderOverride(
    covariant CreateSessionsBatchNotifierProvider provider,
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
  String? get name => r'createSessionsBatchNotifierProvider';
}

/// See also [CreateSessionsBatchNotifier].
class CreateSessionsBatchNotifierProvider
    extends AutoDisposeNotifierProviderImpl<CreateSessionsBatchNotifier,
        CreateSessionsBatchState> {
  /// See also [CreateSessionsBatchNotifier].
  CreateSessionsBatchNotifierProvider(
    String providerId,
    String eventId,
  ) : this._internal(
          () => CreateSessionsBatchNotifier()
            ..providerId = providerId
            ..eventId = eventId,
          from: createSessionsBatchNotifierProvider,
          name: r'createSessionsBatchNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createSessionsBatchNotifierHash,
          dependencies: CreateSessionsBatchNotifierFamily._dependencies,
          allTransitiveDependencies:
              CreateSessionsBatchNotifierFamily._allTransitiveDependencies,
          providerId: providerId,
          eventId: eventId,
        );

  CreateSessionsBatchNotifierProvider._internal(
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
  CreateSessionsBatchState runNotifierBuild(
    covariant CreateSessionsBatchNotifier notifier,
  ) {
    return notifier.build(
      providerId,
      eventId,
    );
  }

  @override
  Override overrideWith(CreateSessionsBatchNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateSessionsBatchNotifierProvider._internal(
        () => create()
          ..providerId = providerId
          ..eventId = eventId,
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
  AutoDisposeNotifierProviderElement<CreateSessionsBatchNotifier,
      CreateSessionsBatchState> createElement() {
    return _CreateSessionsBatchNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateSessionsBatchNotifierProvider &&
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

mixin CreateSessionsBatchNotifierRef
    on AutoDisposeNotifierProviderRef<CreateSessionsBatchState> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _CreateSessionsBatchNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CreateSessionsBatchNotifier,
        CreateSessionsBatchState> with CreateSessionsBatchNotifierRef {
  _CreateSessionsBatchNotifierProviderElement(super.provider);

  @override
  String get providerId =>
      (origin as CreateSessionsBatchNotifierProvider).providerId;
  @override
  String get eventId => (origin as CreateSessionsBatchNotifierProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
