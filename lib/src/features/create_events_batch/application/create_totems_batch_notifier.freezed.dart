// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_totems_batch_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateTotemsBatchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTotemsBatchStateCopyWith<$Res> {
  factory $CreateTotemsBatchStateCopyWith(CreateTotemsBatchState value,
          $Res Function(CreateTotemsBatchState) then) =
      _$CreateTotemsBatchStateCopyWithImpl<$Res, CreateTotemsBatchState>;
}

/// @nodoc
class _$CreateTotemsBatchStateCopyWithImpl<$Res,
        $Val extends CreateTotemsBatchState>
    implements $CreateTotemsBatchStateCopyWith<$Res> {
  _$CreateTotemsBatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateTotemsBatchStateInitialImplCopyWith<$Res> {
  factory _$$CreateTotemsBatchStateInitialImplCopyWith(
          _$CreateTotemsBatchStateInitialImpl value,
          $Res Function(_$CreateTotemsBatchStateInitialImpl) then) =
      __$$CreateTotemsBatchStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateTotemsBatchStateInitialImplCopyWithImpl<$Res>
    extends _$CreateTotemsBatchStateCopyWithImpl<$Res,
        _$CreateTotemsBatchStateInitialImpl>
    implements _$$CreateTotemsBatchStateInitialImplCopyWith<$Res> {
  __$$CreateTotemsBatchStateInitialImplCopyWithImpl(
      _$CreateTotemsBatchStateInitialImpl _value,
      $Res Function(_$CreateTotemsBatchStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateTotemsBatchStateInitialImpl
    implements CreateTotemsBatchStateInitial {
  const _$CreateTotemsBatchStateInitialImpl();

  @override
  String toString() {
    return 'CreateTotemsBatchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTotemsBatchStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
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
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CreateTotemsBatchStateInitial implements CreateTotemsBatchState {
  const factory CreateTotemsBatchStateInitial() =
      _$CreateTotemsBatchStateInitialImpl;
}

/// @nodoc
abstract class _$$CreateTotemsBatchStateCompletedImplCopyWith<$Res> {
  factory _$$CreateTotemsBatchStateCompletedImplCopyWith(
          _$CreateTotemsBatchStateCompletedImpl value,
          $Res Function(_$CreateTotemsBatchStateCompletedImpl) then) =
      __$$CreateTotemsBatchStateCompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateTotemsBatchStateCompletedImplCopyWithImpl<$Res>
    extends _$CreateTotemsBatchStateCopyWithImpl<$Res,
        _$CreateTotemsBatchStateCompletedImpl>
    implements _$$CreateTotemsBatchStateCompletedImplCopyWith<$Res> {
  __$$CreateTotemsBatchStateCompletedImplCopyWithImpl(
      _$CreateTotemsBatchStateCompletedImpl _value,
      $Res Function(_$CreateTotemsBatchStateCompletedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateTotemsBatchStateCompletedImpl
    implements CreateTotemsBatchStateCompleted {
  const _$CreateTotemsBatchStateCompletedImpl();

  @override
  String toString() {
    return 'CreateTotemsBatchState.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTotemsBatchStateCompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
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
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class CreateTotemsBatchStateCompleted
    implements CreateTotemsBatchState {
  const factory CreateTotemsBatchStateCompleted() =
      _$CreateTotemsBatchStateCompletedImpl;
}

/// @nodoc
abstract class _$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWith<$Res> {
  factory _$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWith(
          _$CreateTotemsBatchStateCsvTotemsLoadedImpl value,
          $Res Function(_$CreateTotemsBatchStateCsvTotemsLoadedImpl) then) =
      __$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String totemsFileName,
      List<List<dynamic>> totemsCsv,
      String eventId,
      String providerId});
}

/// @nodoc
class __$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWithImpl<$Res>
    extends _$CreateTotemsBatchStateCopyWithImpl<$Res,
        _$CreateTotemsBatchStateCsvTotemsLoadedImpl>
    implements _$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWith<$Res> {
  __$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWithImpl(
      _$CreateTotemsBatchStateCsvTotemsLoadedImpl _value,
      $Res Function(_$CreateTotemsBatchStateCsvTotemsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totemsFileName = null,
    Object? totemsCsv = null,
    Object? eventId = null,
    Object? providerId = null,
  }) {
    return _then(_$CreateTotemsBatchStateCsvTotemsLoadedImpl(
      totemsFileName: null == totemsFileName
          ? _value.totemsFileName
          : totemsFileName // ignore: cast_nullable_to_non_nullable
              as String,
      totemsCsv: null == totemsCsv
          ? _value._totemsCsv
          : totemsCsv // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateTotemsBatchStateCsvTotemsLoadedImpl
    implements CreateTotemsBatchStateCsvTotemsLoaded {
  const _$CreateTotemsBatchStateCsvTotemsLoadedImpl(
      {required this.totemsFileName,
      required final List<List<dynamic>> totemsCsv,
      required this.eventId,
      required this.providerId})
      : _totemsCsv = totemsCsv;

  @override
  final String totemsFileName;
  final List<List<dynamic>> _totemsCsv;
  @override
  List<List<dynamic>> get totemsCsv {
    if (_totemsCsv is EqualUnmodifiableListView) return _totemsCsv;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_totemsCsv);
  }

  @override
  final String eventId;
  @override
  final String providerId;

  @override
  String toString() {
    return 'CreateTotemsBatchState.csvTotemsLoaded(totemsFileName: $totemsFileName, totemsCsv: $totemsCsv, eventId: $eventId, providerId: $providerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTotemsBatchStateCsvTotemsLoadedImpl &&
            (identical(other.totemsFileName, totemsFileName) ||
                other.totemsFileName == totemsFileName) &&
            const DeepCollectionEquality()
                .equals(other._totemsCsv, _totemsCsv) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totemsFileName,
      const DeepCollectionEquality().hash(_totemsCsv), eventId, providerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWith<
          _$CreateTotemsBatchStateCsvTotemsLoadedImpl>
      get copyWith => __$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWithImpl<
          _$CreateTotemsBatchStateCsvTotemsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return csvTotemsLoaded(totemsFileName, totemsCsv, eventId, providerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return csvTotemsLoaded?.call(
        totemsFileName, totemsCsv, eventId, providerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (csvTotemsLoaded != null) {
      return csvTotemsLoaded(totemsFileName, totemsCsv, eventId, providerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) {
    return csvTotemsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) {
    return csvTotemsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (csvTotemsLoaded != null) {
      return csvTotemsLoaded(this);
    }
    return orElse();
  }
}

abstract class CreateTotemsBatchStateCsvTotemsLoaded
    implements CreateTotemsBatchState {
  const factory CreateTotemsBatchStateCsvTotemsLoaded(
          {required final String totemsFileName,
          required final List<List<dynamic>> totemsCsv,
          required final String eventId,
          required final String providerId}) =
      _$CreateTotemsBatchStateCsvTotemsLoadedImpl;

  String get totemsFileName;
  List<List<dynamic>> get totemsCsv;
  String get eventId;
  String get providerId;
  @JsonKey(ignore: true)
  _$$CreateTotemsBatchStateCsvTotemsLoadedImplCopyWith<
          _$CreateTotemsBatchStateCsvTotemsLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateTotemsBatchStateLoadingImplCopyWith<$Res> {
  factory _$$CreateTotemsBatchStateLoadingImplCopyWith(
          _$CreateTotemsBatchStateLoadingImpl value,
          $Res Function(_$CreateTotemsBatchStateLoadingImpl) then) =
      __$$CreateTotemsBatchStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateTotemsBatchStateLoadingImplCopyWithImpl<$Res>
    extends _$CreateTotemsBatchStateCopyWithImpl<$Res,
        _$CreateTotemsBatchStateLoadingImpl>
    implements _$$CreateTotemsBatchStateLoadingImplCopyWith<$Res> {
  __$$CreateTotemsBatchStateLoadingImplCopyWithImpl(
      _$CreateTotemsBatchStateLoadingImpl _value,
      $Res Function(_$CreateTotemsBatchStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateTotemsBatchStateLoadingImpl
    implements CreateTotemsBatchStateLoading {
  const _$CreateTotemsBatchStateLoadingImpl();

  @override
  String toString() {
    return 'CreateTotemsBatchState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTotemsBatchStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
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
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CreateTotemsBatchStateLoading implements CreateTotemsBatchState {
  const factory CreateTotemsBatchStateLoading() =
      _$CreateTotemsBatchStateLoadingImpl;
}

/// @nodoc
abstract class _$$CreateTotemsBatchStateGeneratedImplCopyWith<$Res> {
  factory _$$CreateTotemsBatchStateGeneratedImplCopyWith(
          _$CreateTotemsBatchStateGeneratedImpl value,
          $Res Function(_$CreateTotemsBatchStateGeneratedImpl) then) =
      __$$CreateTotemsBatchStateGeneratedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<EmbeddedData> list,
      String eventId,
      String providerId,
      bool uploadInProgress});
}

/// @nodoc
class __$$CreateTotemsBatchStateGeneratedImplCopyWithImpl<$Res>
    extends _$CreateTotemsBatchStateCopyWithImpl<$Res,
        _$CreateTotemsBatchStateGeneratedImpl>
    implements _$$CreateTotemsBatchStateGeneratedImplCopyWith<$Res> {
  __$$CreateTotemsBatchStateGeneratedImplCopyWithImpl(
      _$CreateTotemsBatchStateGeneratedImpl _value,
      $Res Function(_$CreateTotemsBatchStateGeneratedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? eventId = null,
    Object? providerId = null,
    Object? uploadInProgress = null,
  }) {
    return _then(_$CreateTotemsBatchStateGeneratedImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<EmbeddedData>,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      uploadInProgress: null == uploadInProgress
          ? _value.uploadInProgress
          : uploadInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreateTotemsBatchStateGeneratedImpl
    implements CreateTotemsBatchStateGenerated {
  const _$CreateTotemsBatchStateGeneratedImpl(
      {required final List<EmbeddedData> list,
      required this.eventId,
      required this.providerId,
      this.uploadInProgress = false})
      : _list = list;

  final List<EmbeddedData> _list;
  @override
  List<EmbeddedData> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final String eventId;
  @override
  final String providerId;
  @override
  @JsonKey()
  final bool uploadInProgress;

  @override
  String toString() {
    return 'CreateTotemsBatchState.generated(list: $list, eventId: $eventId, providerId: $providerId, uploadInProgress: $uploadInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTotemsBatchStateGeneratedImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.uploadInProgress, uploadInProgress) ||
                other.uploadInProgress == uploadInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      eventId,
      providerId,
      uploadInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTotemsBatchStateGeneratedImplCopyWith<
          _$CreateTotemsBatchStateGeneratedImpl>
      get copyWith => __$$CreateTotemsBatchStateGeneratedImplCopyWithImpl<
          _$CreateTotemsBatchStateGeneratedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return generated(list, eventId, providerId, uploadInProgress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return generated?.call(list, eventId, providerId, uploadInProgress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
        generated,
    TResult Function(Object error, StackTrace st)? error,
    required TResult orElse(),
  }) {
    if (generated != null) {
      return generated(list, eventId, providerId, uploadInProgress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) {
    return generated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) {
    return generated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (generated != null) {
      return generated(this);
    }
    return orElse();
  }
}

abstract class CreateTotemsBatchStateGenerated
    implements CreateTotemsBatchState {
  const factory CreateTotemsBatchStateGenerated(
      {required final List<EmbeddedData> list,
      required final String eventId,
      required final String providerId,
      final bool uploadInProgress}) = _$CreateTotemsBatchStateGeneratedImpl;

  List<EmbeddedData> get list;
  String get eventId;
  String get providerId;
  bool get uploadInProgress;
  @JsonKey(ignore: true)
  _$$CreateTotemsBatchStateGeneratedImplCopyWith<
          _$CreateTotemsBatchStateGeneratedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateTotemsBatchStateErrorImplCopyWith<$Res> {
  factory _$$CreateTotemsBatchStateErrorImplCopyWith(
          _$CreateTotemsBatchStateErrorImpl value,
          $Res Function(_$CreateTotemsBatchStateErrorImpl) then) =
      __$$CreateTotemsBatchStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, StackTrace st});
}

/// @nodoc
class __$$CreateTotemsBatchStateErrorImplCopyWithImpl<$Res>
    extends _$CreateTotemsBatchStateCopyWithImpl<$Res,
        _$CreateTotemsBatchStateErrorImpl>
    implements _$$CreateTotemsBatchStateErrorImplCopyWith<$Res> {
  __$$CreateTotemsBatchStateErrorImplCopyWithImpl(
      _$CreateTotemsBatchStateErrorImpl _value,
      $Res Function(_$CreateTotemsBatchStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? st = null,
  }) {
    return _then(_$CreateTotemsBatchStateErrorImpl(
      null == error ? _value.error : error,
      null == st
          ? _value.st
          : st // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$CreateTotemsBatchStateErrorImpl implements CreateTotemsBatchStateError {
  const _$CreateTotemsBatchStateErrorImpl(this.error, this.st);

  @override
  final Object error;
  @override
  final StackTrace st;

  @override
  String toString() {
    return 'CreateTotemsBatchState.error(error: $error, st: $st)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTotemsBatchStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.st, st) || other.st == st));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error), st);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTotemsBatchStateErrorImplCopyWith<_$CreateTotemsBatchStateErrorImpl>
      get copyWith => __$$CreateTotemsBatchStateErrorImplCopyWithImpl<
          _$CreateTotemsBatchStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() completed,
    required TResult Function(String totemsFileName,
            List<List<dynamic>> totemsCsv, String eventId, String providerId)
        csvTotemsLoaded,
    required TResult Function() loading,
    required TResult Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)
        generated,
    required TResult Function(Object error, StackTrace st) error,
  }) {
    return error(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? completed,
    TResult? Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult? Function()? loading,
    TResult? Function(List<EmbeddedData> list, String eventId,
            String providerId, bool uploadInProgress)?
        generated,
    TResult? Function(Object error, StackTrace st)? error,
  }) {
    return error?.call(this.error, st);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? completed,
    TResult Function(String totemsFileName, List<List<dynamic>> totemsCsv,
            String eventId, String providerId)?
        csvTotemsLoaded,
    TResult Function()? loading,
    TResult Function(List<EmbeddedData> list, String eventId, String providerId,
            bool uploadInProgress)?
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
    required TResult Function(CreateTotemsBatchStateInitial value) initial,
    required TResult Function(CreateTotemsBatchStateCompleted value) completed,
    required TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)
        csvTotemsLoaded,
    required TResult Function(CreateTotemsBatchStateLoading value) loading,
    required TResult Function(CreateTotemsBatchStateGenerated value) generated,
    required TResult Function(CreateTotemsBatchStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTotemsBatchStateInitial value)? initial,
    TResult? Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult? Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult? Function(CreateTotemsBatchStateLoading value)? loading,
    TResult? Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult? Function(CreateTotemsBatchStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTotemsBatchStateInitial value)? initial,
    TResult Function(CreateTotemsBatchStateCompleted value)? completed,
    TResult Function(CreateTotemsBatchStateCsvTotemsLoaded value)?
        csvTotemsLoaded,
    TResult Function(CreateTotemsBatchStateLoading value)? loading,
    TResult Function(CreateTotemsBatchStateGenerated value)? generated,
    TResult Function(CreateTotemsBatchStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CreateTotemsBatchStateError implements CreateTotemsBatchState {
  const factory CreateTotemsBatchStateError(
          final Object error, final StackTrace st) =
      _$CreateTotemsBatchStateErrorImpl;

  Object get error;
  StackTrace get st;
  @JsonKey(ignore: true)
  _$$CreateTotemsBatchStateErrorImplCopyWith<_$CreateTotemsBatchStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
