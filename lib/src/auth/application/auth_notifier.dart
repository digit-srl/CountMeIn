import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cloud.dart';
import '../data/dto/user.dart';
import '../domain/entities/exceptions.dart';
import '../domain/entities/user.dart';
import '../domain/repositories/i_auth_repository.dart';
import 'auth_state.dart';

final signInErrorProvider = StateProvider.autoDispose<SignInException?>((ref) {
  return null;
});

final signUpErrorProvider = StateProvider.autoDispose<SignUpException?>((ref) {
  return null;
});

final _userProvider =
    StreamProvider.family<MUUser?, String>((ref, userId) async* {
  final stream = Cloud.credentialsCollection.doc(userId).snapshots();
  await for (final doc in stream) {
    final data = doc.data();
    if (doc.exists && data != null) {
      final userDto = MUUserDTO.fromJson(data);
      yield userDto.toDomain();
    } else {
      yield null;
    }
  }
});

final authStateProvider = Provider<AuthState>((ref) {
  final userAsync = ref.watch(_authStateChangesProvider);
  return userAsync.when(
      data: (user) {
        if (user != null) {
          if (!user.emailVerified) {
            return EmailNotVerified(user);
          } else {
            final muUserAsync = ref.watch(_userProvider(user.uid));
            return muUserAsync.when(data: (data){
              if (data != null) {
                return AuthState.authenticated(muUserAsync.asData!.value!);
              }else{
                return const Unautenticated();
              }
            }, error: (err,stack)=>AuthError(err,stack), loading: ()=>const AuthLoading());
          }
        } else {
          return const Unautenticated();
        }
      },
      error: (err, stack) => AuthError(err, stack),
      loading: () => const AuthLoading());
});

final _authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  if (authState is Authenticated) {
    return authState.user.uid;
  }
  return null;
});

/*class AuthChangeNotifier extends ChangeNotifier {
  bool _isLogged = false;

  bool get isLogged => _isLogged;

  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }
}*/

final signInNotifierProvider =
    StateNotifierProvider.autoDispose<SignInNotifier, bool>((ref) {
  return SignInNotifier(ref.read);
});

class SignInNotifier extends StateNotifier<bool> {
  final Reader read;

  SignInNotifier(this.read) : super(false);

  Future<bool> signIn(String email, String password) async {
    state = true;
    try {
      await read(authRepositoryProvider).signIn(email, password);
      // authChangeNotifier.isLogged = true;
      state = false;
      return true;
    } on SignInException catch (ex) {
      print(ex);
      state = false;
      return false;
    }
  }
}

final signUpNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, bool>((ref) {
  return SignUpNotifier(ref.read);
});

class SignUpNotifier extends StateNotifier<bool> {
  final Reader read;

  SignUpNotifier(this.read) : super(false);

  Future<bool> signUp(
      String name, String surname, String email, String password) async {
    state = true;
    try {
      await read(authRepositoryProvider).signUp(name, surname, email, password);
      return true;
    } on SignUpException catch (ex) {
      print(ex);
      read(signUpErrorProvider.notifier).state = ex;
      state = false;
      return false;
    }
  }
}
