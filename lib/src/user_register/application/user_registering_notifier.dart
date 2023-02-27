import 'package:countmein/constants.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/user/data/dto/user_creation_response.dart';
import 'package:countmein/src/user/data/dto/user_request.dart';
import 'package:countmein/src/user_register/application/user_registering_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../cloud.dart';

final userRegisteringProvider = StateNotifierProvider.autoDispose<
    UserRegisteringNotifier, UserRegisteringState>((ref) {
  return UserRegisteringNotifier(ref);
});

class UserRegisteringNotifier extends StateNotifier<UserRegisteringState> {
  final Ref ref;

  UserRegisteringNotifier(this.ref) : super(const UserRegisteringInitial());

  Future<void> register(UserRequest request) async {
    try {
      state = const UserRegisteringLoading();
      final res = await _createUser(request);
      if (res.status == 'user_already_exist') {
        if (res.emailVerified != null && res.userId != null) {
          if (res.emailVerified!) {
            // await sendUserCardByEmail(
            //     res.userId!, request.providerId, request.providerName);
            state = UserRegisteringUserAlreadySubscribed(
              email: request.email,
              cf: res.cf,
              userId: res.userId!,
              providerId: request.providerId,
            );
          } else {
            // await sendVerificationEmail();
            state = UserRegisteringVerificationEmailSent(
              newUser: false,
              email: request.email,
            );
          }
        }
      } else if (res.status == 'invalid_fiscal_code') {
        state = const UserRegisteringInvalidFiscalCode();
      } else if (res.status == 'success') {
        state = UserRegisteringVerificationEmailSent(
          newUser: true,
          email: request.email,
        );
      }
    } catch (ex, st) {
      logger.i(ex);
      logger.i(st);
      state = UserRegisteringError(ex, st);
    }
  }

  registerLocalUser(UserCard user) {
    final json = user.toJson();
    json.remove('addedOn');
    Hive.box('user').put('myUser', json);
  }

  Future<UserCreationResponse> _createUser(UserRequest request) async {
    try {
      final res = await ref
          .read(dioProvider)
          .post(createUserUrl, data: request.toJson());
      final map = Map<String, dynamic>.from(res.data);
      return UserCreationResponse.fromJson(map);
    } catch (ex, st) {
      logger.i(ex);
      logger.i(st);
      rethrow;
    }
  }

  sendVerificationEmail() async {}

  Future sendUserCardByEmail(
      String userId, String providerId, String providerName) async {
    //TODO creare function per invio tesserino email da app
    await Cloud.usersCollection(providerId).doc(userId).update({
      'providerName': providerName,
      "providerId": providerId,
    });
  }
}
