import 'package:countmein/my_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cloud.dart';
import '../../admin/application/providers_stream.dart';
import '../data/dto/user.dart';
import '../domain/entities/exceptions.dart';
import '../domain/entities/user.dart';
import '../domain/repositories/i_auth_repository.dart';
import 'auth_state.dart';
import 'package:collection/collection.dart';

final signInErrorProvider = StateProvider.autoDispose<SignInException?>((ref) {
  return null;
});

final signUpErrorProvider = StateProvider.autoDispose<SignUpException?>((ref) {
  return null;
});

final _userProvider =
StreamProvider.family<Map<String, dynamic>?, String>((ref, userId) async* {
  final stream = Cloud.credentialsCollection.doc(userId).snapshots();
  await for (final doc in stream) {
    final data = doc.data();
    if (doc.exists && data != null) {
      // final userDto = AuthUserDTO.fromJson(data);
      yield data;
    } else {
      yield null;
    }
  }
});

final authStateStreamProvider = StreamProvider<AuthState>((ref) async* {
  final userAsync = ref.watch(_authStateChangesProvider);
  yield* userAsync.when(
    data: (user) async* {
      if (user != null) {
        if (!user.emailVerified) {
          yield EmailNotVerified(user);
        } else {
          final userFromFirestore = ref.watch(_userProvider(user.uid));
          yield* userFromFirestore.when(
            data: (data) async* {
              if (data != null) {
                final idToken = await user.getIdTokenResult();
                final map = <String, dynamic>{};
                map.addAll(data);
                map['role'] = idToken.claims?['role'];
                final dto = AuthUserDTO.fromJson(map);
                final u = dto.toDomain();
                yield AuthState.authenticated(u);
              } else {
                yield const Unautenticated();
              }
            },
            error: (err, stack) async* {
              logger.i(stack);
              yield AuthError(err, stack);
            },
            loading: () async* {
              yield const AuthLoading();
            },
          );
        }
      } else {
        yield const Unautenticated();
      }
    },
    error: (err, stack) async* {
      yield AuthError(err, stack);
    },
    loading: () async* {
      yield const AuthLoading();
    },
  );
});

final authStateProvider = Provider<AuthState>((ref) {
  return ref.watch(authStateStreamProvider).when(
    data: (state) => state,
    error: (err, stack) => AuthState.error(err, stack),
    loading: () => const AuthState.loading(),
  );
});

final authUserRoleProvider = Provider<PlatformRole>((ref) {
  return ref.watch(authStateProvider).maybeWhen(
    authenticated: (user) => user.role,
    orElse: () => PlatformRole.unknown,
  );
});

final userRoleProvider = Provider.family<UserRole, String>((ref, providerId) {
  final state = ref.watch(authStateProvider);
  var role = UserRole.unknown;
  if (state is Authenticated) {
    final provider = ref.watch(singleCMIProviderProvider(providerId));
    final manager = provider.valueOrNull?.managers?.values.firstWhereOrNull((element) =>
    element.id == state.user.uid);
    role = manager?.role ?? UserRole.unknown;
  }
  return role;
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

/*
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final userAsync = ref.watch(_authStateChangesProvider);
  return AuthStateNotifier(const AuthState.loading(), userAsync.asData?.value);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthState initialState;
  final User? user;

  AuthStateNotifier(this.initialState, this.user) : super(initialState) {
    _init();
  }

  _init() async{
    if (user != null) {
      if (!user!.emailVerified) {
        return EmailNotVerified(user!);
      } else {
        final idToken = await user!.getIdTokenResult();
        final userFromFirestore = ref.watch(_userProvider(user.uid));
        return userFromFirestore.when(
            data: (data) {
              if (data != null) {
                final map = <String,dynamic>{};
                map.addAll(data);
                map['role'] =
                final dto = AuthUserDTO.fromJson(map);
                return AuthState.authenticated(dto.toDomain());
              } else {
                return const Unautenticated();
              }
            },
            error: (err, stack) => AuthError(err, stack),
            loading: () => const AuthLoading());
      }
    } else {
      return const Unautenticated();
    }

    if(user!= null){
      if(!user!.emailVerified){
        state = Email
      }
    }else{
      state = const AuthState.loading();
    }
  }
}*/

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
  return SignInNotifier(ref);
});

class SignInNotifier extends StateNotifier<bool> {
  final Ref ref;

  SignInNotifier(this.ref) : super(false);

  Future<bool> signIn(String email, String password) async {
    state = true;
    try {
      await ref.read(authRepositoryProvider).signIn(email, password);
      // authChangeNotifier.isLogged = true;
      state = false;
      return true;
    } on SignInException catch (ex) {
      logger.i(ex);
      state = false;
      return false;
    }
  }

  @override
  set state(bool value) {
    if (mounted) {
      super.state = value;
    }
  }

  signOut() async {
    try {
      await ref.read(authRepositoryProvider).signOut();
      // authChangeNotifier.isLogged = true;
      state = false;
      return true;
    } on SignInException catch (ex) {
      logger.i(ex);
      state = false;
      return false;
    }
  }
}

final signUpNotifierProvider =
StateNotifierProvider.autoDispose<SignUpNotifier, bool>((ref) {
  return SignUpNotifier(ref);
});

class SignUpNotifier extends StateNotifier<bool> {
  final Ref ref;

  SignUpNotifier(this.ref) : super(false);

  Future<bool> signUp(String name, String surname, String email,
      String password) async {
    state = true;
    try {
      await ref.read(authRepositoryProvider).signUp(name, surname, email, password);
      return true;
    } on SignUpException catch (ex) {
      logger.i(ex);
      ref.read(signUpErrorProvider.notifier).state = ex;
      state = false;
      return false;
    }
  }
}
