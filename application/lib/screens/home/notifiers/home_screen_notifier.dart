import 'package:application/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenNotifier extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  void changeUser(User? user) => state = user;
}

final homeScreenNotifier = NotifierProvider<HomeScreenNotifier, User?>(
    () => HomeScreenNotifier()
);