import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/src/user/application/user_profile_state.dart';
import 'package:countmein/src/user/data/dto/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../admin/application/confirm_invite.dart';

final userProfileStreamProvider = StreamProvider.autoDispose
    .family<UserProfile, UserIds>((ref, userIds) async* {
  final stream =
      Cloud.userProfileDoc(userIds.providerId, userIds.userId).snapshots();

  await for (final snap in stream) {
    if (snap.exists) {
      yield (UserProfile.fromJson(snap.data()!));
    }
  }
});

final userProfileNotifierProvider = StateNotifierProvider.autoDispose
    .family<UserProfileNotifier, UserProfileState, UserIds>((ref, userIds) {
  return UserProfileNotifier(userIds, ref.read);
});

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final UserIds userIds;
  final Reader read;

  UserProfileNotifier(this.userIds, this.read)
      : super(const UserProfileInitial());

  Future getOtpCode() async {
    state = const UserProfileLoading();
    final res = await read(dioProvider).post(
      requestOtpCodeUrl,
      data: {'userId': userIds.userId},
    );
    if (res.statusCode == 200) {
      // final map = Map<String, dynamic>.from(res.data);
      state = const UserProfileWaitingOtpCode();
    } else {
      state = const UserProfileError();
    }
  }

  Future verifyOtpCode(String otpCode) async {
    state = const UserProfileLoading();
    try {
      final res = await read(dioProvider).post(
        verifyOtpCodeUrl,
        data: {
          'userId': userIds.userId,
          'otpCode': otpCode,
          'providerId': userIds.providerId
        },
      );
      if (res.statusCode == 200) {
        // final map = Map<String, dynamic>.from(res.data);
        state = const UserProfileData();
      } else {
        state = const UserProfileError();
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      rethrow;
    }
  }

  void reset() {
    state = const UserProfileInitial();
  }
}
