import 'package:countmein/my_logger.dart';
import 'package:countmein/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../constants.dart';
import 'confirm_invite_state.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      headers: {'content-type': 'application/json'},
    ),
  );
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  return dio;
});

final confirmInviteProvider = StateNotifierProvider.autoDispose
    .family<ConfirmInviteNotifier, ConfirmInviteState, InviteRequest>(
        (ref, request) {
  return ConfirmInviteNotifier(request, ref);
});

class ConfirmInviteNotifier extends StateNotifier<ConfirmInviteState> {
  final InviteRequest request;
  final Ref ref;

  ConfirmInviteNotifier(this.request, this.ref)
      : super(const ConfirmInviteLoading()) {
    init();
  }

  init() async {
    if (request.userId == null) {
      state = const NewUser();
    } else {
      state = const UserAlreadyRegistered();
    }
  }

  void confirmInviteNewUser(
      String name, String surname, String email, String cf) {}

  void confirmInvite({String? name, String? surname, String? cf}) async {
    final data = <String, dynamic>{};
    final currentState = state;
    state = const ConfirmInviteLoading();
    if (currentState is UserAlreadyRegistered) {
      data.addAll({
        'secret': request.secret,
        'inviteId': request.inviteId,
        'providerId': request.providerId,
      });
    } else if (currentState is NewUser) {
      data.addAll({
        'secret': request.secret,
        'inviteId': request.inviteId,
        'providerId': request.providerId,
        'name': name,
        'surname': surname,
        'cf': cf
      });
    }

    //http://localhost:5003/count-me-in-ef93b/europe-west3/confirmPendingInvite
    try {
      final res = await ref.read(dioProvider).post(confirmPendingInviteUrl, data: data);
      final map = Map.from(res.data);
      final status =
          enumFromString(map['status'], ConfirmInviteResponseStatus.values);
      logger.i(status);
      state = ConfirmResponse(status);
    } catch (ex, st) {
      logger.i(ex);
      logger.i(st);
      state = ConfirmInviteError(ex, st);
    }
  }
}
