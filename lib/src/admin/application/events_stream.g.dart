// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsStreamHash() => r'ec667748749e7e92a99717aa3511f387c2128ffa';

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

/// See also [eventsStream].
@ProviderFor(eventsStream)
const eventsStreamProvider = EventsStreamFamily();

/// See also [eventsStream].
class EventsStreamFamily extends Family<AsyncValue<List<CMIEvent>>> {
  /// See also [eventsStream].
  const EventsStreamFamily();

  /// See also [eventsStream].
  EventsStreamProvider call(
    String providerId, {
    EventStatus status = EventStatus.live,
  }) {
    return EventsStreamProvider(
      providerId,
      status: status,
    );
  }

  @override
  EventsStreamProvider getProviderOverride(
    covariant EventsStreamProvider provider,
  ) {
    return call(
      provider.providerId,
      status: provider.status,
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
  String? get name => r'eventsStreamProvider';
}

/// See also [eventsStream].
class EventsStreamProvider extends AutoDisposeStreamProvider<List<CMIEvent>> {
  /// See also [eventsStream].
  EventsStreamProvider(
    String providerId, {
    EventStatus status = EventStatus.live,
  }) : this._internal(
          (ref) => eventsStream(
            ref as EventsStreamRef,
            providerId,
            status: status,
          ),
          from: eventsStreamProvider,
          name: r'eventsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsStreamHash,
          dependencies: EventsStreamFamily._dependencies,
          allTransitiveDependencies:
              EventsStreamFamily._allTransitiveDependencies,
          providerId: providerId,
          status: status,
        );

  EventsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
    required this.status,
  }) : super.internal();

  final String providerId;
  final EventStatus status;

  @override
  Override overrideWith(
    Stream<List<CMIEvent>> Function(EventsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsStreamProvider._internal(
        (ref) => create(ref as EventsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CMIEvent>> createElement() {
    return _EventsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsStreamProvider &&
        other.providerId == providerId &&
        other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsStreamRef on AutoDisposeStreamProviderRef<List<CMIEvent>> {
  /// The parameter `providerId` of this provider.
  String get providerId;

  /// The parameter `status` of this provider.
  EventStatus get status;
}

class _EventsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<CMIEvent>>
    with EventsStreamRef {
  _EventsStreamProviderElement(super.provider);

  @override
  String get providerId => (origin as EventsStreamProvider).providerId;
  @override
  EventStatus get status => (origin as EventsStreamProvider).status;
}

String _$eventHash() => r'05d661212bfb806282e0f2f4fe8184507fa80413';

/// See also [event].
@ProviderFor(event)
const eventProvider = EventFamily();

/// See also [event].
class EventFamily extends Family<AsyncValue<CMIEvent>> {
  /// See also [event].
  const EventFamily();

  /// See also [event].
  EventProvider call(
    EventIds ids,
  ) {
    return EventProvider(
      ids,
    );
  }

  @override
  EventProvider getProviderOverride(
    covariant EventProvider provider,
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
  String? get name => r'eventProvider';
}

/// See also [event].
class EventProvider extends AutoDisposeStreamProvider<CMIEvent> {
  /// See also [event].
  EventProvider(
    EventIds ids,
  ) : this._internal(
          (ref) => event(
            ref as EventRef,
            ids,
          ),
          from: eventProvider,
          name: r'eventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventHash,
          dependencies: EventFamily._dependencies,
          allTransitiveDependencies: EventFamily._allTransitiveDependencies,
          ids: ids,
        );

  EventProvider._internal(
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
    Stream<CMIEvent> Function(EventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventProvider._internal(
        (ref) => create(ref as EventRef),
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
  AutoDisposeStreamProviderElement<CMIEvent> createElement() {
    return _EventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventRef on AutoDisposeStreamProviderRef<CMIEvent> {
  /// The parameter `ids` of this provider.
  EventIds get ids;
}

class _EventProviderElement extends AutoDisposeStreamProviderElement<CMIEvent>
    with EventRef {
  _EventProviderElement(super.provider);

  @override
  EventIds get ids => (origin as EventProvider).ids;
}

String _$eventFilterNotifierHash() =>
    r'e48417df69aef2d7cd065308a16446f7985e200b';

/// See also [EventFilterNotifier].
@ProviderFor(EventFilterNotifier)
final eventFilterNotifierProvider =
    AutoDisposeNotifierProvider<EventFilterNotifier, EventFilter>.internal(
  EventFilterNotifier.new,
  name: r'eventFilterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventFilterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EventFilterNotifier = AutoDisposeNotifier<EventFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
