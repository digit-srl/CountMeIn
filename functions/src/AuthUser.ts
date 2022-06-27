/*
  const factory AuthUserDTO({
    required String uid,
    required String name,
    required String surname,
    required String email,
    required List<String> activityIds,
    required bool emailVerified,
    required DateTime createdAt,
  }) = _AuthUserDTO;

*/

export class AuthUser {
  uid: string;
  name: string;
  surname: string;
  email: string;
  activityIds: string[];
  emailVerified: boolean;

  constructor(
    uid: string,
    name: string,
    surname: string,
    email: string,
    activityIds: string[],
    emailVerified: boolean
  ) {
    this.uid = uid;
    this.name = name;
    this.surname = surname;
    this.email = email;
    this.activityIds = activityIds;
    this.emailVerified = emailVerified;
  }

  toJson() {
    return {
      uid: this.uid,
      surname: this.surname,
      name: this.name,
      email: this.email,
      activityIds: this.activityIds,
      emailVerified: this.emailVerified,
    };
  }
}
