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
  emailVerified: boolean;
  //providersRole: Map<string, string>;

  constructor(
    uid: string,
    name: string,
    surname: string,
    email: string,
    emailVerified: boolean
    //providersRole: Map<string, string>
  ) {
    this.uid = uid;
    this.name = name;
    this.surname = surname;
    this.email = email;
    this.emailVerified = emailVerified;
    //this.providersRole = providersRole;
  }

  toJson() {
    return {
      uid: this.uid,
      surname: this.surname,
      name: this.name,
      email: this.email,
      emailVerified: this.emailVerified,
      //providersRole: this.providersRole,
    };
  }
}
