import 'package:application/models/user.dart';
import 'package:application/screens/home/notifiers/home_screen_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreenNotifier extends Notifier<User?> {
  @override
  User? build() {
    final currentUser = ref.watch(homeScreenNotifier);
    return currentUser;
  }
}

final historyScreenNotifier = NotifierProvider<HistoryScreenNotifier,User?> (
    () => HistoryScreenNotifier()
);