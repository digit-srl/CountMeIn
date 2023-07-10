import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum PlatformRole {
  cmi,
  unknown
}

enum UserRole {
  admin,
  collaborator,
  scanner,
  unknown;

  String get text{
    switch(this){
      case UserRole.admin:
        return 'Admin';
      case UserRole.collaborator:
        return 'Collaboratore';
      case UserRole.scanner:
        return 'Scanner';
      case UserRole.unknown:
        return 'Sconosciuto';
    }
  }
}

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    required String name,
    required String surname,
    required String email,
    required bool emailVerified,
    required DateTime createdOn,
    required PlatformRole role,
    @Default(true) bool temporaryPassword,
    // required Map<String,UserRole> providersRole
  }) = _AuthUser;
}

extension AuthUserX on AuthUser {
  String get firstNameLetters {
    return '${name[0]}${surname[0]}'.toUpperCase();
  }

  String get fullName => '$name $surname';
}
