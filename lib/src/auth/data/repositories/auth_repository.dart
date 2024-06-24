import 'package:countmein/my_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:countmein/src/auth/domain/entities/exceptions.dart';
import 'package:countmein/src/auth/domain/repositories/i_auth_repository.dart';

class AuthRepository extends IAuthRepository {
  @override
  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logger.i(userCredential.user);
    } on FirebaseAuthException catch (ex) {
      logger.e(ex);
      throw SignInException.fromFirebaseException(ex);
    } catch (ex, st) {
      logger.e(ex);
      logger.e(st);
      throw UnknownException();
    }
  }

  @override
  Future<void> signUp(
      String name, String surname, String email, String password,) async {
    try {
      /*final authUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authUser.user != null && !authUser.user!.emailVerified) {
        logger.i('user not verififed send email');
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
        logger.i('user is null from AuthUser');
      }*/
    } on FirebaseAuthException catch (ex) {
      logger.e(ex);
      throw SignUpException.fromFirebaseException(ex);
    } catch (ex) {
      logger.e(ex);
      throw UnknownException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (ex) {
      logger.e(ex);
      throw SignInException.fromFirebaseException(ex);
    } catch (ex) {
      logger.e(ex);
      throw UnknownException();
    }
  }
}
