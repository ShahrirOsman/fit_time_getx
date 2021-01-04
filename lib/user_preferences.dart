import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  clear()async{
    await _prefs.clear();
  }

  get prepareDuration {
    return _prefs.getInt('prepareDuration') ?? 5;
  }

  set prepareDuration(int value) {
    _prefs.setInt('prepareDuration', value);
  }

  get restDuration {
    return _prefs.getInt('restDuration') ?? 15;
  }

  set restDuration(int value) {
    _prefs.setInt('restDuration', value);
  }

  get workDuration {
    return _prefs.getInt('workDuration') ?? 30;
  }

  set workDuration(int value) {
    _prefs.setInt('workDuration', value);
  }

  get breakDuration {
    return _prefs.getInt('breakDuration') ?? 15;
  }

  set breakDuration(int value) {
    _prefs.setInt('breakDuration', value);
  }

  get cycles {
    return _prefs.getInt('cycles') ?? 6;
  }

  set cycles(int value) {
    _prefs.setInt('cycles', value);
  }

  get sets {
    return _prefs.getInt('sets') ?? 2;
  }

  set sets(int value) {
    _prefs.setInt('sets', value);
  }
}
