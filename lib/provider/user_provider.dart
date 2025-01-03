import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/authentication/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(null);

  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
    // print('User state updated: ${state?.phone}');
  } 

  void signOut() {
    state = null;
    print('User signed out');
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
