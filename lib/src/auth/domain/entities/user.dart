import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class MUUser with _$MUUser {
  const factory MUUser({
    required String uid,
    required String name,
    required String surname,
    required String email,
    required bool emailVerified,
    required DateTime createdAt,
  }) = _MUUser;

  factory MUUser.signUp(String name, String surname, String email, String uid) {
    return MUUser(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      emailVerified: false,
      createdAt: DateTime.now().toUtc(),
    );
  }
}

extension MUUserX on MUUser {
  String get firstNameLetters {
    return '${name[0]}${surname[0]}'.toUpperCase();
  }
}
