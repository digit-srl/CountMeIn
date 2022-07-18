import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/errors/mu_exceptions.dart';


class SignInException extends MUException {
  SignInException() : super('SignInException', '');

  factory SignInException.fromFirebaseException(FirebaseAuthException ex) {

    switch (ex.code) {
      case 'network-request-failed':
        return NetworkRequestFailed();
      case 'invalid-email':
      case 'wrong-password':
        return InvalidEmailOrPasswordException();
      case 'user-disabled':
        return UserDisabledException();
      case 'user-not-found':
        return UserNotFoundException();
      default:
        return UnknownException();
    }
  }
}

class InvalidEmailOrPasswordException extends SignInException {}

class UserNotFoundException extends SignInException {}

class UserDisabledException extends SignInException {}

class NetworkRequestFailed extends SignInException {}

class UnknownException extends SignInException {}

class SignUpException extends MUException {
  SignUpException() : super('SignInException', '');

  factory SignUpException.fromFirebaseException(FirebaseAuthException ex) {
    switch (ex.code) {
      case 'email-already-in-use':
        return EmailAlreadyInUseException();
      case 'invalid-email':
        return InvalidEmailException();
      case 'weak-password':
        return WeakPasswordException();
      default:
        return SignUpException();
    }
  }
}

class WeakPasswordException extends SignUpException {}

class EmailAlreadyInUseException extends SignUpException {}

class InvalidEmailException extends SignUpException {}
