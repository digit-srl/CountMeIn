import 'package:countmein/domain/entities/activity.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/src/user_register/application/user_registering_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../cloud.dart';

final userRegisteringProvider = StateNotifierProvider.autoDispose<
    UserRegisteringNotifier, UserRegisteringState>((ref) {
  return UserRegisteringNotifier();
});

class UserRegisteringNotifier extends StateNotifier<UserRegisteringState> {
  UserRegisteringNotifier() : super(const UserRegisteringInitial());

  Future<void> register(Activity activity, UserCard user) async {
    try {
      state = const UserRegisteringLoading();
      //TODO if email is null
      if (activity.releaseWom) {
        final snap = await Cloud.usersCollection
            .where('email', isEqualTo: user.email)
            .limit(1)
            .get();
        if (snap.docs.isNotEmpty) {
          final userOnFirestore = UserCard.fromJson(snap.docs.first.data());
          if (userOnFirestore.email == null) {
            return;
          }
          if (userOnFirestore.emailVerified) {
            await sendUserCardByEmail();
            state = UserRegisteringUserCardSentByEmail(
                email: userOnFirestore.email!);
          } else {
            await sendVerificationEmail();
            state = UserRegisteringVerificationEmailSent(
                email: userOnFirestore.email!);
          }
          // final u = user.copyWith(
          //   id: userOnFirestore.id,
          //   addedOn: userOnFirestore.addedOn,
          // );
        } else {
          if (user.email == null) return;
          await Cloud.usersCollection.doc(user.id).set({
            ...user.toJson(),
            'activityId':activity.id,
            'activityName':activity.name,
          });
          await sendVerificationEmail();
          state = UserRegisteringVerificationEmailSent(
            newUser: true,
            email: user.email!,
          );
        }
      } else {
        Hive.box('user').put('myUser', user.toJson());
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      state = UserRegisteringError(ex, st);
    }
  }

  sendVerificationEmail() async {}

  sendUserCardByEmail() async {}
}
