import 'package:countmein/domain/entities/date_time_converter.dart';
import 'package:countmein/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
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
    @MyDateTimeConverter() required DateTime createdAt,
    String? role,
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
      role: enumFromString(role ?? 'unknown', UserRole.values),
    );
  }
}
