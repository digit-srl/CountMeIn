import 'package:countmein/src/user/application/user_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userProfileNotifierProvider = StateNotifierProvider.autoDispose.family<UserProfileNotifier, UserProfileState, String >((ref, userId) {
  return UserProfileNotifier(userId);
});

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final String userId;
  UserProfileNotifier(this.userId) : super(const UserProfileLoading());

  init(){

  }
}
