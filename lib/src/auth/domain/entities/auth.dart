import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
abstract class Auth with _$Auth {
  factory Auth({
    required String id,
  }) = _Auth;
}
