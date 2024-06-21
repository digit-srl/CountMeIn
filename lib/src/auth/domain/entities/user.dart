import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum PlatformRole {
  cmi,
  unknown;

  String get text {
    return switch (this) { cmi => 'Super admin', _ => 'Admin' };
  }
}

enum UserRole {
  owner,
  admin,
  scanner,
  eventManager,
  unknown;

  String get text {
    switch (this) {
      case UserRole.owner:
        return 'Proprietario';
      case UserRole.admin:
        return 'Amministratore';
      case UserRole.scanner:
        return 'Scanner';
      case UserRole.eventManager:
        return 'Manager';
      case UserRole.unknown:
        return 'Sconosciuto';
    }
  }

  bool get canSeeAllEvents => switch (this) {
        UserRole.owner || UserRole.admin => true,
        _ => false,
      };
}

const collaboratorsEventRole = [
  UserRole.scanner,
  UserRole.eventManager,
];

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
