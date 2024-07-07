import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInSectionNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void showLoading() {
    state = true;
  }

  void notShowLoading() {
    state = false;
  }
}

final signInSectionNotifier = NotifierProvider<SignInSectionNotifier, bool> (
        () => SignInSectionNotifier()
);