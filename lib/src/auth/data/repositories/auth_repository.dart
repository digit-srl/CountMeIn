import 'package:firebase_auth/firebase_auth.dart';

import '../../../../cloud.dart';
import '../../data/dto/user.dart';
import '../../domain/entities/exceptions.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthRepository extends IAuthRepository {
  @override
  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user);
    } on FirebaseAuthException catch (ex) {
      throw SignInException.fromFirebaseException(ex);
    }
  }

  @override
  Future<void> signUp(
      String name, String surname, String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        print('user not verififed send email');
        userCredential.user!.sendEmailVerification();
      }

      if (userCredential.user != null) {
        final muUser = MUUserDTO(
          uid: userCredential.user!.uid,
          name: name,
          surname: surname,
          email: email,
          createdAt: DateTime.now().toUtc(),
          emailVerified: false,
        );
        await Cloud.credentialsCollection.doc(userCredential.user!.uid).set(muUser.toJson());
      } else {
        print('user is null from usercredential');
      }
    } on FirebaseAuthException catch (ex) {
      throw SignUpException.fromFirebaseException(ex);
    } catch (ex) {
      throw UnknownException();
    }
  }
}
