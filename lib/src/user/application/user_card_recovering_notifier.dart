import 'package:countmein/constants.dart';
import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/user/application/user_card_recovering_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userCardRecoveringProvider = StateNotifierProvider.autoDispose<
    UserCardRecoveringNotifier, UserCardRecoveringState>((ref) {
  return UserCardRecoveringNotifier(ref);
});

class UserCardRecoveringNotifier
    extends StateNotifier<UserCardRecoveringState> {
  final Ref ref;

  UserCardRecoveringNotifier(this.ref)
      : super(const UserCardRecoveringInitial());

  late UserCardRecoveringState _cache;

  Future check(String cf, String providerId) async {
    _cache = state;
    state = const UserCardRecoveringLoading();
    try {
      final res = await ref.read(dioProvider).post(
        recoverUserUrl,
        data: <String, dynamic>{
          'cf': cf.toUpperCase(),
          'providerId': providerId,
        },
      );
      if (res.statusCode == 200) {
        final map = Map<String, dynamic>.from(res.data);
        final status = map['status'];

        switch (status) {
          case 'email_sent':
            final userId = map['userId'];
            state = UserCardRecoveringWaitingOtpCode(
              ids: UserIds(
                providerId: providerId,
                userId: userId,
              ),
            );
            break;
          case 'invalid_fiscal_code':
            state = const UserCardRecoveringInvalidFiscalCode();
            break;
          case 'user_not_exists':
            state = const UserCardRecoveringUserNotExists();
            break;
          default:
            state = const UserCardRecoveringError();
        }
      } else {
        state = const UserCardRecoveringError();
      }
    } catch (ex, st) {
      state = UserCardRecoveringError(error: ex, st: st);
      logger.i(ex);
      logger.i(st);
    }
  }

  Future verifyOtpCode(
    UserIds ids,
    String otpCode,
  ) async {
    _cache = state;
    state = const UserCardRecoveringLoading();
    try {
      final res = await ref.read(dioProvider).post(
        verifyOtpCodeUrl,
        data: {
          'userId': ids.userId,
          'otpCode': otpCode,
          'providerId': ids.providerId,
        },
      );

      if (res.statusCode == 200) {
        // final map = Map<String, dynamic>.from(res.data);
        state = UserCardRecoveringProfile(ids: ids);
      } else {
        state = const UserCardRecoveringError();
      }
    } on DioError catch (ex, st) {
      logger.i(ex);
      logger.i(st);
      state = UserCardRecoveringError(error: ex, st: st);
    } catch (ex, st) {
      logger.i(ex);
      logger.i(st);
      state = UserCardRecoveringError(error: ex, st: st);
    }
  }

  void reset() {
    state = _cache;
  }
}
