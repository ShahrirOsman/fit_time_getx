import 'package:fit_time_getx/screens/workout_screen.dart';
import 'package:fit_time_getx/state/timer_state.dart';
import 'package:fit_time_getx/widgets/simple_duration_picker.dart';
import 'package:fit_time_getx/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DurationInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _timerState = Get.put(TimerState());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Fit Time')),
        backgroundColor: kAccentColor,
      ),
      body: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SimpleDurationPicker(
                title: 'Prepare',
                duration: formatTime(_timerState.prepareDuration.value),
                onPressedMinus: _timerState.prepareDurationDecrement,
                onPressedPlus: _timerState.prepareDurationIncrement,
              ),
              SimpleDurationPicker(
                title: 'Work',
                duration: formatTime(_timerState.workDuration.value),
                onPressedMinus: _timerState.workDurationDecrement,
                onPressedPlus: _timerState.workDurationIncrement,
              ),
              SimpleDurationPicker(
                title: 'Rest',
                duration: formatTime(_timerState.restDuration.value),
                onPressedMinus: _timerState.restDurationDecrement,
                onPressedPlus: _timerState.restDurationIncrement,
              ),
              SimpleDurationPicker(
                title: 'Cycle',
                duration: _timerState.cycles.value.toString(),
                onPressedMinus: _timerState.cyclesDecrement,
                onPressedPlus: _timerState.cyclesIncrement,
              ),
              SimpleDurationPicker(
                title: 'Set',
                duration: _timerState.sets.value.toString(),
                onPressedMinus: _timerState.setsDecrement,
                onPressedPlus: _timerState.setsIncrement,
              ),
              SimpleDurationPicker(
                title: 'Break',
                duration: formatTime(_timerState.breakDuration.value),
                onPressedMinus: _timerState.breakDurationDecrement,
                onPressedPlus: _timerState.breakDurationIncrement,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                formatTime(_timerState.getTotalTime()),
                style: kTimeTextStyle,
              ),
              SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                child: Icon(
                  Icons.play_arrow,
                  size: 60.0,
                ),
                onPressed: () {
                  Get.off(WorkoutScreen());
                },
                style: ElevatedButton.styleFrom(
                  primary: kAccentColor,
                  minimumSize: Size(300.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
