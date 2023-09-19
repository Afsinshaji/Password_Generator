import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/presentation/screen_password_generator.dart';

import '../infrastructure/password_generator.dart';

final passwordProvider = StateProvider(
  (ref) {
    return '';
  },
);
final passwordLengthProvider = StateProvider((ref) => 8);
final checkListProvider = StateProvider((ref) => CheckList.easy);

class PasswordGeneratorRiverpod {
  String createPassword(
      CheckList passwordtype, int passwordLength, WidgetRef? ref) {
    String passwortdType = '';
    switch (passwordtype) {
      case CheckList.easy:
        passwortdType = 'Easy';
        break;
      case CheckList.medium:
        passwortdType = 'Medium';
        break;
      case CheckList.hard:
        passwortdType = 'Hard';
        break;
      default:
        passwortdType = 'Easy';
        break;
    }

    final password = PasswordGeneratorImplementation()
        .generatePassword(passwortdType, passwordLength);
    log(password);

    if (ref != null) {
      ref.read(passwordProvider.notifier).state = password;
    }
    return password;
  }
}
