import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.unknown({
    @Default('Unknown error') String description,
  }) = AuthUnknownFailure;
}

class AuthException implements Exception {
  AuthException({required this.failure});

  final AuthFailure failure;

  @override
  String toString() {
    return '''
Auth Error: ${failure.toString()}
    ''';
  }
}
