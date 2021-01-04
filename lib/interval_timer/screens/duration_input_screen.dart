import 'package:fit_time_getx/interval_timer/screens/workout_screen.dart';
import 'package:fit_time_getx/interval_timer/state/timer_state.dart';
import 'package:fit_time_getx/user_preferences.dart';
import 'package:fit_time_getx/widgets/simple_duration_picker.dart';
import 'package:fit_time_getx/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DurationInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _timerState = Get.put(TimerState());
    final _prefs = UserPreferences();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Fit Time')),
          backgroundColor: kAccentColor,
        ),
        body: Obx(
          () {
            _timerState.init();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SimpleDurationPicker(
                      title: 'Prepare',
                      // duration: formatTime(_timerState.prepareDuration.value),
                      duration:
                          formatTime(Duration(seconds: _prefs.prepareDuration)),
                      onPressedMinus: _timerState.prepareDurationDecrement,
                      onPressedPlus: _timerState.prepareDurationIncrement,
                    ),
                    SimpleDurationPicker(
                      title: 'Work',
                      duration:
                          formatTime(Duration(seconds: _prefs.workDuration)),
                      onPressedMinus: _timerState.workDurationDecrement,
                      onPressedPlus: _timerState.workDurationIncrement,
                    ),
                    SimpleDurationPicker(
                      title: 'Rest',
                      duration:
                          formatTime(Duration(seconds: _prefs.restDuration)),
                      onPressedMinus: _timerState.restDurationDecrement,
                      onPressedPlus: _timerState.restDurationIncrement,
                    ),
                    SimpleDurationPicker(
                      title: 'Cycle',
                      duration: _prefs.cycles.toString(),
                      onPressedMinus: _timerState.cyclesDecrement,
                      onPressedPlus: _timerState.cyclesIncrement,
                    ),
                    SimpleDurationPicker(
                      title: 'Set',
                      duration: _prefs.sets.toString(),
                      onPressedMinus: _timerState.setsDecrement,
                      onPressedPlus: _timerState.setsIncrement,
                    ),
                    SimpleDurationPicker(
                      title: 'Break',
                      duration:
                          formatTime(Duration(seconds: _prefs.breakDuration)),
                      onPressedMinus: _timerState.breakDurationDecrement,
                      onPressedPlus: _timerState.breakDurationIncrement,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.restore_rounded),
                      iconSize: 40.0,
                      tooltip: 'Reset Duration to Default',
                      splashRadius: 30.0,
                      onPressed: () {
                        _timerState.resetToDefault();
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Center(
                      child: Text(
                        formatTime(_timerState.getTotalTime()),
                        style: kTimeTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.play_arrow,
                      size: 60.0,
                    ),
                    onPressed: () {
                      Get.off(WorkoutScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kAccentColor,
                      minimumSize: Size(300.0, 70.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
