import 'package:get_storage/get_storage.dart';

abstract class AppStorage {
  static final box = GetStorage();
  static final answeredQuestions = [].val('answeredQuestions', defVal: []);
  static final soundEnabled = true.val('soundEnabled');

  static final musicEnabled = true.val('musicEnabled');
}
