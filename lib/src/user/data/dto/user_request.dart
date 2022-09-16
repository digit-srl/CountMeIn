import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';

part 'user_request.g.dart';

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    required String name,
    required String surname,
    required String cf,
    required String email,
    required String providerId,
    required String providerName,
    // required String gender,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, Object?> json) =>
      _$UserRequestFromJson(json);

}