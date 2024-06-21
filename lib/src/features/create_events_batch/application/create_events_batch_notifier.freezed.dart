// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_events_batch_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateEventsBatchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEventsBatchStateCopyWith<$Res> {
  factory $CreateEventsBatchStateCopyWith(CreateEventsBatchState value,
          $Res Function(CreateEventsBatchState) then) =
      _$CreateEventsBatchStateCopyWithImpl<$Res, CreateEventsBatchState>;
}

/// @nodoc
class _$CreateEventsBatchStateCopyWithImpl<$Res,
        $Val extends CreateEventsBatchState>
    implements $CreateEventsBatchStateCopyWith<$Res> {
  _$CreateEventsBatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateDataImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateDataImplCopyWith(
          _$CreateEventsBatchStateDataImpl value,
          $Res Function(_$CreateEventsBatchStateDataImpl) then) =
      __$$CreateEventsBatchStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> items, int totalItemsCount, bool hasReachedMax});
}

/// @nodoc
class __$$CreateEventsBatchStateDataImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateDataImpl>
    implements _$$CreateEventsBatchStateDataImplCopyWith<$Res> {
  __$$CreateEventsBatchStateDataImplCopyWithImpl(
      _$CreateEventsBatchStateDataImpl _value,
      $Res Function(_$CreateEventsBatchStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalItemsCount = null,
    Object? hasReachedMax = null,
  }) {
    return _then(_$CreateEventsBatchStateDataImpl(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == totalItemsCount
          ? _value.totalItemsCount
          : totalItemsCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreateEventsBatchStateDataImpl implements CreateEventsBatchStateData {
  const _$CreateEventsBatchStateDataImpl(
      final List<String> items, this.totalItemsCount,
      {this.hasReachedMax = true})
      : _items = items;

  final List<String> _items;
  @override
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalItemsCount;
  @override
  @JsonKey()
  final bool hasReachedMax;

  @override
  String toString() {
    return 'CreateEventsBatchState.data(items: $items, totalItemsCount: $totalItemsCount, hasReachedMax: $hasReachedMax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateDataImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalItemsCount, totalItemsCount) ||
                other.totalItemsCount == totalItemsCount) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      totalItemsCount,
      hasReachedMax);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEventsBatchStateDataImplCopyWith<_$CreateEventsBatchStateDataImpl>
      get copyWith => __$$CreateEventsBatchStateDataImplCopyWithImpl<
          _$CreateEventsBatchStateDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return data(items, totalItemsCount, hasReachedMax);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return data?.call(items, totalItemsCount, hasReachedMax);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(items, totalItemsCount, hasReachedMax);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateData implements CreateEventsBatchState {
  const factory CreateEventsBatchStateData(
      final List<String> items, final int totalItemsCount,
      {final bool hasReachedMax}) = _$CreateEventsBatchStateDataImpl;

  List<String> get items;
  int get totalItemsCount;
  bool get hasReachedMax;
  @JsonKey(ignore: true)
  _$$CreateEventsBatchStateDataImplCopyWith<_$CreateEventsBatchStateDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateInitialImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateInitialImplCopyWith(
          _$CreateEventsBatchStateInitialImpl value,
          $Res Function(_$CreateEventsBatchStateInitialImpl) then) =
      __$$CreateEventsBatchStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateEventsBatchStateInitialImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateInitialImpl>
    implements _$$CreateEventsBatchStateInitialImplCopyWith<$Res> {
  __$$CreateEventsBatchStateInitialImplCopyWithImpl(
      _$CreateEventsBatchStateInitialImpl _value,
      $Res Function(_$CreateEventsBatchStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateEventsBatchStateInitialImpl
    implements CreateEventsBatchStateInitial {
  const _$CreateEventsBatchStateInitialImpl();

  @override
  String toString() {
    return 'CreateEventsBatchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateInitial implements CreateEventsBatchState {
  const factory CreateEventsBatchStateInitial() =
      _$CreateEventsBatchStateInitialImpl;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateCompletedImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateCompletedImplCopyWith(
          _$CreateEventsBatchStateCompletedImpl value,
          $Res Function(_$CreateEventsBatchStateCompletedImpl) then) =
      __$$CreateEventsBatchStateCompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateEventsBatchStateCompletedImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateCompletedImpl>
    implements _$$CreateEventsBatchStateCompletedImplCopyWith<$Res> {
  __$$CreateEventsBatchStateCompletedImplCopyWithImpl(
      _$CreateEventsBatchStateCompletedImpl _value,
      $Res Function(_$CreateEventsBatchStateCompletedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateEventsBatchStateCompletedImpl
    implements CreateEventsBatchStateCompleted {
  const _$CreateEventsBatchStateCompletedImpl();

  @override
  String toString() {
    return 'CreateEventsBatchState.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateCompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateCompleted
    implements CreateEventsBatchState {
  const factory CreateEventsBatchStateCompleted() =
      _$CreateEventsBatchStateCompletedImpl;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateCsvEventsLoadedImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateCsvEventsLoadedImplCopyWith(
          _$CreateEventsBatchStateCsvEventsLoadedImpl value,
          $Res Function(_$CreateEventsBatchStateCsvEventsLoadedImpl) then) =
      __$$CreateEventsBatchStateCsvEventsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String eventsFileName,
      List<List<dynamic>> eventsCsv,
      String? sessionsFileName,
      List<List<dynamic>>? sessionsCsv});
}

/// @nodoc
class __$$CreateEventsBatchStateCsvEventsLoadedImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateCsvEventsLoadedImpl>
    implements _$$CreateEventsBatchStateCsvEventsLoadedImplCopyWith<$Res> {
  __$$CreateEventsBatchStateCsvEventsLoadedImplCopyWithImpl(
      _$CreateEventsBatchStateCsvEventsLoadedImpl _value,
      $Res Function(_$CreateEventsBatchStateCsvEventsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventsFileName = null,
    Object? eventsCsv = null,
    Object? sessionsFileName = freezed,
    Object? sessionsCsv = freezed,
  }) {
    return _then(_$CreateEventsBatchStateCsvEventsLoadedImpl(
      eventsFileName: null == eventsFileName
          ? _value.eventsFileName
          : eventsFileName // ignore: cast_nullable_to_non_nullable
              as String,
      eventsCsv: null == eventsCsv
          ? _value._eventsCsv
          : eventsCsv // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>,
      sessionsFileName: freezed == sessionsFileName
          ? _value.sessionsFileName
          : sessionsFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionsCsv: freezed == sessionsCsv
          ? _value._sessionsCsv
          : sessionsCsv // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>?,
    ));
  }
}

/// @nodoc

class _$CreateEventsBatchStateCsvEventsLoadedImpl
    implements CreateEventsBatchStateCsvEventsLoaded {
  const _$CreateEventsBatchStateCsvEventsLoadedImpl(
      {required this.eventsFileName,
      required final List<List<dynamic>> eventsCsv,
      this.sessionsFileName,
      final List<List<dynamic>>? sessionsCsv})
      : _eventsCsv = eventsCsv,
        _sessionsCsv = sessionsCsv;

  @override
  final String eventsFileName;
  final List<List<dynamic>> _eventsCsv;
  @override
  List<List<dynamic>> get eventsCsv {
    if (_eventsCsv is EqualUnmodifiableListView) return _eventsCsv;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eventsCsv);
  }

  @override
  final String? sessionsFileName;
  final List<List<dynamic>>? _sessionsCsv;
  @override
  List<List<dynamic>>? get sessionsCsv {
    final value = _sessionsCsv;
    if (value == null) return null;
    if (_sessionsCsv is EqualUnmodifiableListView) return _sessionsCsv;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CreateEventsBatchState.csvEventsLoaded(eventsFileName: $eventsFileName, eventsCsv: $eventsCsv, sessionsFileName: $sessionsFileName, sessionsCsv: $sessionsCsv)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateCsvEventsLoadedImpl &&
            (identical(other.eventsFileName, eventsFileName) ||
                other.eventsFileName == eventsFileName) &&
            const DeepCollectionEquality()
                .equals(other._eventsCsv, _eventsCsv) &&
            (identical(other.sessionsFileName, sessionsFileName) ||
                other.sessionsFileName == sessionsFileName) &&
            const DeepCollectionEquality()
                .equals(other._sessionsCsv, _sessionsCsv));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventsFileName,
      const DeepCollectionEquality().hash(_eventsCsv),
      sessionsFileName,
      const DeepCollectionEquality().hash(_sessionsCsv));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEventsBatchStateCsvEventsLoadedImplCopyWith<
          _$CreateEventsBatchStateCsvEventsLoadedImpl>
      get copyWith => __$$CreateEventsBatchStateCsvEventsLoadedImplCopyWithImpl<
          _$CreateEventsBatchStateCsvEventsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return csvEventsLoaded(
        eventsFileName, eventsCsv, sessionsFileName, sessionsCsv);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return csvEventsLoaded?.call(
        eventsFileName, eventsCsv, sessionsFileName, sessionsCsv);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (csvEventsLoaded != null) {
      return csvEventsLoaded(
          eventsFileName, eventsCsv, sessionsFileName, sessionsCsv);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return csvEventsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return csvEventsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (csvEventsLoaded != null) {
      return csvEventsLoaded(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateCsvEventsLoaded
    implements CreateEventsBatchState {
  const factory CreateEventsBatchStateCsvEventsLoaded(
          {required final String eventsFileName,
          required final List<List<dynamic>> eventsCsv,
          final String? sessionsFileName,
          final List<List<dynamic>>? sessionsCsv}) =
      _$CreateEventsBatchStateCsvEventsLoadedImpl;

  String get eventsFileName;
  List<List<dynamic>> get eventsCsv;
  String? get sessionsFileName;
  List<List<dynamic>>? get sessionsCsv;
  @JsonKey(ignore: true)
  _$$CreateEventsBatchStateCsvEventsLoadedImplCopyWith<
          _$CreateEventsBatchStateCsvEventsLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateLoadingImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateLoadingImplCopyWith(
          _$CreateEventsBatchStateLoadingImpl value,
          $Res Function(_$CreateEventsBatchStateLoadingImpl) then) =
      __$$CreateEventsBatchStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateEventsBatchStateLoadingImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateLoadingImpl>
    implements _$$CreateEventsBatchStateLoadingImplCopyWith<$Res> {
  __$$CreateEventsBatchStateLoadingImplCopyWithImpl(
      _$CreateEventsBatchStateLoadingImpl _value,
      $Res Function(_$CreateEventsBatchStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateEventsBatchStateLoadingImpl
    implements CreateEventsBatchStateLoading {
  const _$CreateEventsBatchStateLoadingImpl();

  @override
  String toString() {
    return 'CreateEventsBatchState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateLoading implements CreateEventsBatchState {
  const factory CreateEventsBatchStateLoading() =
      _$CreateEventsBatchStateLoadingImpl;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateGeneratedImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateGeneratedImplCopyWith(
          _$CreateEventsBatchStateGeneratedImpl value,
          $Res Function(_$CreateEventsBatchStateGeneratedImpl) then) =
      __$$CreateEventsBatchStateGeneratedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<EventAndSessions> list, bool uploadInProgress});
}

/// @nodoc
class __$$CreateEventsBatchStateGeneratedImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateGeneratedImpl>
    implements _$$CreateEventsBatchStateGeneratedImplCopyWith<$Res> {
  __$$CreateEventsBatchStateGeneratedImplCopyWithImpl(
      _$CreateEventsBatchStateGeneratedImpl _value,
      $Res Function(_$CreateEventsBatchStateGeneratedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? uploadInProgress = null,
  }) {
    return _then(_$CreateEventsBatchStateGeneratedImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<EventAndSessions>,
      uploadInProgress: null == uploadInProgress
          ? _value.uploadInProgress
          : uploadInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreateEventsBatchStateGeneratedImpl
    implements CreateEventsBatchStateGenerated {
  const _$CreateEventsBatchStateGeneratedImpl(
      {required final List<EventAndSessions> list,
      this.uploadInProgress = false})
      : _list = list;

  final List<EventAndSessions> _list;
  @override
  List<EventAndSessions> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool uploadInProgress;

  @override
  String toString() {
    return 'CreateEventsBatchState.generated(list: $list, uploadInProgress: $uploadInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateGeneratedImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.uploadInProgress, uploadInProgress) ||
                other.uploadInProgress == uploadInProgress));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), uploadInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEventsBatchStateGeneratedImplCopyWith<
          _$CreateEventsBatchStateGeneratedImpl>
      get copyWith => __$$CreateEventsBatchStateGeneratedImplCopyWithImpl<
          _$CreateEventsBatchStateGeneratedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return generated(list, uploadInProgress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return generated?.call(list, uploadInProgress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (generated != null) {
      return generated(list, uploadInProgress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return generated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return generated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (generated != null) {
      return generated(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateGenerated
    implements CreateEventsBatchState {
  const factory CreateEventsBatchStateGenerated(
      {required final List<EventAndSessions> list,
      final bool uploadInProgress}) = _$CreateEventsBatchStateGeneratedImpl;

  List<EventAndSessions> get list;
  bool get uploadInProgress;
  @JsonKey(ignore: true)
  _$$CreateEventsBatchStateGeneratedImplCopyWith<
          _$CreateEventsBatchStateGeneratedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateEventsBatchStateErrorImplCopyWith<$Res> {
  factory _$$CreateEventsBatchStateErrorImplCopyWith(
          _$CreateEventsBatchStateErrorImpl value,
          $Res Function(_$CreateEventsBatchStateErrorImpl) then) =
      __$$CreateEventsBatchStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace st});
}

/// @nodoc
class __$$CreateEventsBatchStateErrorImplCopyWithImpl<$Res>
    extends _$CreateEventsBatchStateCopyWithImpl<$Res,
        _$CreateEventsBatchStateErrorImpl>
    implements _$$CreateEventsBatchStateErrorImplCopyWith<$Res> {
  __$$CreateEventsBatchStateErrorImplCopyWithImpl(
      _$CreateEventsBatchStateErrorImpl _value,
      $Res Function(_$CreateEventsBatchStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? st = null,
  }) {
    return _then(_$CreateEventsBatchStateErrorImpl(
      null == error ? _value.error : error,
      null == st
          ? _value.st
          : st // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$CreateEventsBatchStateErrorImpl implements CreateEventsBatchStateError {
  const _$CreateEventsBatchStateErrorImpl(this.error, this.st);

  @override
  final Object error;
  @override
  final StackTrace st;

  @override
  String toString() {
    return 'CreateEventsBatchState.error(error: $error, st: $st)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventsBatchStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.st, st) || other.st == st));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error), st);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEventsBatchStateErrorImplCopyWith<_$CreateEventsBatchStateErrorImpl>
      get copyWith => __$$CreateEventsBatchStateErrorImplCopyWithImpl<
          _$CreateEventsBatchStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)
        data,
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(
            String eventsFileName,
            List<List<dynamic>> eventsCsv,
            String? sessionsFileName,
            List<List<dynamic>>? sessionsCsv)
        csvEventsLoaded,
    required TResult Function() loading,
    required TResult Function(
            List<EventAndSessions> list, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return error(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return error?.call(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> items, int totalItemsCount, bool hasReachedMax)?
        data,
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String eventsFileName, List<List<dynamic>> eventsCsv,
            String? sessionsFileName, List<List<dynamic>>? sessionsCsv)?
        csvEventsLoaded,
    TResult Function()? loading,
    TResult Function(List<EventAndSessions> list, bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, st);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateEventsBatchStateData value) data,
    required TResult Function(CreateEventsBatchStateInitial value) initial,
    required TResult Function(CreateEventsBatchStateCompleted value) completed,
    required TResult Function(CreateEventsBatchStateCsvEventsLoaded value)
        csvEventsLoaded,
    required TResult Function(CreateEventsBatchStateLoading value) loading,
    required TResult Function(CreateEventsBatchStateGenerated value) generated,
    required TResult Function(CreateEventsBatchStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateEventsBatchStateData value)? data,
    TResult? Function(CreateEventsBatchStateInitial value)? initial,
    TResult? Function(CreateEventsBatchStateCompleted value)? completed,
    TResult? Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult? Function(CreateEventsBatchStateLoading value)? loading,
    TResult? Function(CreateEventsBatchStateGenerated value)? generated,
    TResult? Function(CreateEventsBatchStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateEventsBatchStateData value)? data,
    TResult Function(CreateEventsBatchStateInitial value)? initial,
    TResult Function(CreateEventsBatchStateCompleted value)? completed,
    TResult Function(CreateEventsBatchStateCsvEventsLoaded value)?
        csvEventsLoaded,
    TResult Function(CreateEventsBatchStateLoading value)? loading,
    TResult Function(CreateEventsBatchStateGenerated value)? generated,
    TResult Function(CreateEventsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CreateEventsBatchStateError implements CreateEventsBatchState {
  const factory CreateEventsBatchStateError(
          final Object error, final StackTrace st) =
      _$CreateEventsBatchStateErrorImpl;

  Object get error;
  StackTrace get st;
  @JsonKey(ignore: true)
  _$$CreateEventsBatchStateErrorImplCopyWith<_$CreateEventsBatchStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
