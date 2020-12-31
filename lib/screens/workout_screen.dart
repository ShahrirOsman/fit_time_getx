import 'package:fit_time_getx/screens/duration_input_screen.dart';
import 'package:fit_time_getx/state/timer_state.dart';
import 'package:fit_time_getx/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen/screen.dart';

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerState = Get.put(TimerState());
    timerState.start();
    Screen.keepOn(true);
    return Obx(() {
      return Scaffold(
        backgroundColor: timerState.backgroundColor.value,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                formatTime(timerState.timeLeft.value),
                style: kTimeTextStyle,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                timerState.durationText.value,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Elapsed: \n ${formatTime(timerState.totalTimeElapsed.value)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        ' ${timerState.cyclesCount}/${timerState.cycles.value}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Cycles',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        ' ${timerState.setsCount}/${timerState.sets.value}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Sets',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: !timerState.isRunning.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: 'btn3',
                            backgroundColor: kAccentColor,
                            child: Icon(Icons.refresh),
                            onPressed: () {
                              timerState.reset();
                              Get.off(DurationInputScreen());
                            },
                          ),
                          SizedBox(
                            width: 80.0,
                          ),
                          FloatingActionButton(
                            heroTag: 'btn1',
                            backgroundColor: kAccentColor,
                            child: Icon(Icons.play_arrow_rounded),
                            onPressed: () {
                              timerState.start();
                            },
                          ),
                        ],
                      )
                    : FloatingActionButton(
                        heroTag: 'btn2',
                        backgroundColor: kAccentColor,
                        child: Icon(Icons.pause),
                        onPressed: timerState.pause,
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
