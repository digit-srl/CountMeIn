import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';


enum UserRole {
  owner,
  collaborator,
  unknown,
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
    required Map<String,UserRole> providersRole
  }) = _AuthUser;

/*  factory AuthUser.signUp(String name, String surname, String email, String uid) {
    return AuthUser(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      emailVerified: false,
      activityIds: [],
      createdAt: DateTime.now().toUtc(),
    );
  }*/
}

extension AuthUserX on AuthUser {
  String get firstNameLetters {
    return '${name[0]}${surname[0]}'.toUpperCase();
  }
}
