import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider =
    StateNotifierProvider<LoginProvider, bool>((ref) => LoginProvider(true));

class LoginProvider extends StateNotifier<bool> {
  LoginProvider(super._state);

  void toggle() {
    state = !state;
  }
}
