import 'package:firebase_auth/firebase_auth.dart';

import 'package:countmein/src/common/errors/mu_exceptions.dart';

class SignInException extends MUException {

  SignInException(String message) : super('SignInException', message);

  factory SignInException.fromFirebaseException(FirebaseAuthException ex) {
    switch (ex.code) {
      case 'network-request-failed':
        return NetworkRequestFailed('Abbiamo riscontrato dei problemi di rete');
      case 'invalid-email':
      case 'wrong-password':
        return InvalidEmailOrPasswordException('Email o password errate');
      case 'user-disabled':
        return UserDisabledException(
            'L\'utente non è più abilitato a accedere a questo servizio',);
      case 'user-not-found':
        return UserNotFoundException('Email o password errate');
      default:
        return UnknownException();
    }
  }
}

class InvalidEmailOrPasswordException extends SignInException {
  InvalidEmailOrPasswordException(super.message);
}

class UserNotFoundException extends SignInException {
  UserNotFoundException(super.message);
}

class UserDisabledException extends SignInException {
  UserDisabledException(super.message);
}

class NetworkRequestFailed extends SignInException {
  NetworkRequestFailed(super.message);
}

class UnknownException extends SignInException {
  UnknownException({String? message})
      : super(message ?? 'Si è verificato un errore imprevisto');
}

class SignUpException extends MUException {

  SignUpException(String message) : super('SignInException', message);

  factory SignUpException.fromFirebaseException(FirebaseAuthException ex) {
    switch (ex.code) {
      case 'email-already-in-use':
        return EmailAlreadyInUseException('Utente già esistente');
      case 'invalid-email':
        return InvalidEmailException('Email non valida');
      case 'weak-password':
        return WeakPasswordException('Password troppo debole');
      default:
        return SignUpException('Si è verificato un errore imprevisto');
    }
  }
}

class WeakPasswordException extends SignUpException {
  WeakPasswordException(super.message);
}

class EmailAlreadyInUseException extends SignUpException {
  EmailAlreadyInUseException(super.message);
}

class InvalidEmailException extends SignUpException {
  InvalidEmailException(super.message);
}
