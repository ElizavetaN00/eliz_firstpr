import 'package:get_storage/get_storage.dart';

abstract class AppStorage {
  static final box = GetStorage();

  static final bestMiles = 0.val('bestMiles');

  static final lastScore = 0.val('lastScore');

  static final soundEnabled = true.val('soundEnabled');

  static final musicEnabled = true.val('musicEnabled');
  static final cardColorId = 0.val('cardId');
}
