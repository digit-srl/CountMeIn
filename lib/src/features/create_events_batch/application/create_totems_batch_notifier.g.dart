// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_totems_batch_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createTotemsBatchNotifierHash() =>
    r'2443aa9b8119b5c01f1fa98e46b928eead348052';

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

abstract class _$CreateTotemsBatchNotifier
    extends BuildlessAutoDisposeNotifier<CreateTotemsBatchState> {
  late final String providerId;
  late final String eventId;

  CreateTotemsBatchState build(
    String providerId,
    String eventId,
  );
}

/// See also [CreateTotemsBatchNotifier].
@ProviderFor(CreateTotemsBatchNotifier)
const createTotemsBatchNotifierProvider = CreateTotemsBatchNotifierFamily();

/// See also [CreateTotemsBatchNotifier].
class CreateTotemsBatchNotifierFamily extends Family<CreateTotemsBatchState> {
  /// See also [CreateTotemsBatchNotifier].
  const CreateTotemsBatchNotifierFamily();

  /// See also [CreateTotemsBatchNotifier].
  CreateTotemsBatchNotifierProvider call(
    String providerId,
    String eventId,
  ) {
    return CreateTotemsBatchNotifierProvider(
      providerId,
      eventId,
    );
  }

  @override
  CreateTotemsBatchNotifierProvider getProviderOverride(
    covariant CreateTotemsBatchNotifierProvider provider,
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
  String? get name => r'createTotemsBatchNotifierProvider';
}

/// See also [CreateTotemsBatchNotifier].
class CreateTotemsBatchNotifierProvider extends AutoDisposeNotifierProviderImpl<
    CreateTotemsBatchNotifier, CreateTotemsBatchState> {
  /// See also [CreateTotemsBatchNotifier].
  CreateTotemsBatchNotifierProvider(
    String providerId,
    String eventId,
  ) : this._internal(
          () => CreateTotemsBatchNotifier()
            ..providerId = providerId
            ..eventId = eventId,
          from: createTotemsBatchNotifierProvider,
          name: r'createTotemsBatchNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createTotemsBatchNotifierHash,
          dependencies: CreateTotemsBatchNotifierFamily._dependencies,
          allTransitiveDependencies:
              CreateTotemsBatchNotifierFamily._allTransitiveDependencies,
          providerId: providerId,
          eventId: eventId,
        );

  CreateTotemsBatchNotifierProvider._internal(
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
  CreateTotemsBatchState runNotifierBuild(
    covariant CreateTotemsBatchNotifier notifier,
  ) {
    return notifier.build(
      providerId,
      eventId,
    );
  }

  @override
  Override overrideWith(CreateTotemsBatchNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateTotemsBatchNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<CreateTotemsBatchNotifier,
      CreateTotemsBatchState> createElement() {
    return _CreateTotemsBatchNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateTotemsBatchNotifierProvider &&
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

mixin CreateTotemsBatchNotifierRef
    on AutoDisposeNotifierProviderRef<CreateTotemsBatchState> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _CreateTotemsBatchNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CreateTotemsBatchNotifier,
        CreateTotemsBatchState> with CreateTotemsBatchNotifierRef {
  _CreateTotemsBatchNotifierProviderElement(super.provider);

  @override
  String get providerId =>
      (origin as CreateTotemsBatchNotifierProvider).providerId;
  @override
  String get eventId => (origin as CreateTotemsBatchNotifierProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
