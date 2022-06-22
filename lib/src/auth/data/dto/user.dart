import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class MUUserDTO with _$MUUserDTO {
  const factory MUUserDTO({
    required String uid,
    required String name,
    required String surname,
    required String email,
    required bool emailVerified,
    required DateTime createdAt,
  }) = _MUUserDTO;

  factory MUUserDTO.fromJson(Map<String, dynamic> json) =>
      _$MUUserDTOFromJson(json);
}

extension MUUserDTOX on MUUserDTO {
  MUUser toDomain() {
    return MUUser(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      emailVerified: emailVerified,
      createdAt: createdAt,
    );
  }
}
