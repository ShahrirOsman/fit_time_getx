import 'package:fit_time_getx/interval_timer/screens/duration_input_screen.dart';
import 'package:fit_time_getx/interval_timer/state/timer_state.dart';
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
                timerState.durationText.value,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                formatTime(timerState.timeLeft.value),
                style: kTimeTextStyle,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Elapsed:\n${formatTime(timerState.totalTimeElapsed.value)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
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
                        '${timerState.getCyclesCount()}/${timerState.cycles.value}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
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
                        '${timerState.getSetsCount()}/${timerState.sets.value}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
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
              !timerState.isRunning.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          child: FloatingActionButton(
                            heroTag: 'btn3',
                            backgroundColor: kAccentColor,
                            child: Icon(
                              Icons.refresh,
                              size: 50,
                            ),
                            onPressed: () {
                              timerState.reset();
                              Get.off(DurationInputScreen());
                            },
                          ),
                        ),
                        SizedBox(
                          width: 80.0,
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          child: FloatingActionButton(
                            heroTag: 'btn1',
                            backgroundColor: kAccentColor,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 50,
                            ),
                            onPressed: () {
                              timerState.start();
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 80,
                      width: 90,
                      child: FloatingActionButton(
                        heroTag: 'btn2',
                        backgroundColor: kAccentColor,
                        child: Icon(
                          Icons.pause,
                          size: 50,
                        ),
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
