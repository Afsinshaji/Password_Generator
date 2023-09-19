import 'dart:convert';
import 'dart:math';

import '../domain/password_generator.dart';

class PasswordGeneratorImplementation implements PasswordGeneratorService {
  @override
  String generatePassword(String passwordtype, int passwordLength) {
    var numGenerator = Random.secure();

    if (passwordtype == 'Easy') {
      var alphabet = List.from(
          utf8.encode('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'));
      var password = String.fromCharCodes(List.generate(passwordLength,
          (_) => alphabet[numGenerator.nextInt(alphabet.length)]));

      return password;
    } else if (passwordtype == 'Medium') {
      var alphabet = List.from(utf8.encode(
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'));
      var password = String.fromCharCodes(List.generate(passwordLength,
          (_) => alphabet[numGenerator.nextInt(alphabet.length)]));

      return password;
    } else if (passwordtype == 'Hard') {
      var alphabet = List.from(utf8.encode(
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^*()&'));
      var password = String.fromCharCodes(List.generate(passwordLength,
          (_) => alphabet[numGenerator.nextInt(alphabet.length)]));

      return password;
    } else {
      return '';
    }
  }
}
