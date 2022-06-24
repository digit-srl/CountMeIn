import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class AuthUserDTO with _$AuthUserDTO {
  const factory AuthUserDTO({
    required String uid,
    required String name,
    required String surname,
    required String email,
    required List<String> activityIds,
    required bool emailVerified,
    required DateTime createdAt,
  }) = _AuthUserDTO;

  factory AuthUserDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDTOFromJson(json);
}

extension AuthUserDTOX on AuthUserDTO {
  AuthUser toDomain() {
    return AuthUser(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      emailVerified: emailVerified,
      createdAt: createdAt, activityIds: [],
    );
  }
}
