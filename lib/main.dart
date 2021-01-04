import 'package:fit_time_getx/interval_timer/screens/duration_input_screen.dart';
import 'package:fit_time_getx/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(accentColor: Color(0xFF27205F)),
      home: DurationInputScreen(),
    );
  }
}
