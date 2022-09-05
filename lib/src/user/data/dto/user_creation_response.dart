import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_creation_response.freezed.dart';

part 'user_creation_response.g.dart';

@freezed
class UserCreationResponse with _$UserCreationResponse {
  const factory UserCreationResponse({
    required String status,
    String? userId,
    bool? emailVerified,
  }) = _UserCreationResponse;

  factory UserCreationResponse.fromJson(Map<String, Object?> json) =>
      _$UserCreationResponseFromJson(json);

}