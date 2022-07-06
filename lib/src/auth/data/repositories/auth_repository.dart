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
    } catch (ex) {
      print(ex);
      throw UnknownException();
    }
  }

  @override
  Future<void> signUp(
      String name, String surname, String email, String password) async {
    try {
      /*final authUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authUser.user != null && !authUser.user!.emailVerified) {
        print('user not verififed send email');
        authUser.user!.sendEmailVerification();
      }

      if (authUser.user != null) {
        final authUser = AuthUserDTO(
          uid: authUser.user!.uid,
          name: name,
          surname: surname,
          email: email,
          createdAt: DateTime.now().toUtc(),
          emailVerified: false,
          activityIds: [],
        );
        await Cloud.credentialsCollection
            .doc(authUser.user!.uid)
            .set(authUser.toJson());
      } else {
        print('user is null from AuthUser');
      }*/
    } on FirebaseAuthException catch (ex) {
      throw SignUpException.fromFirebaseException(ex);
    } catch (ex) {
      throw UnknownException();
    }
  }
}
