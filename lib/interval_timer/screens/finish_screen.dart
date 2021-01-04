import 'package:fit_time_getx/const.dart';
import 'package:fit_time_getx/interval_timer/screens/duration_input_screen.dart';
import 'package:fit_time_getx/interval_timer/state/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen/screen.dart';

class FinishScreen extends StatelessWidget {
  final _timerState = Get.put(TimerState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF7E5),
      body: Obx(() {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'Well Done! You Are One Step Closer To Your Goal',
                  style: kBodyTextStyle,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/high_five.jpeg'),
                alignment: Alignment.center,
              ),
              Text(
                'Total Workout Time:',
                style: kBodyTextStyle,
              ),
              Text(
                formatTime(_timerState.totalTimeElapsed.value),
                style: kTimeTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text('DONE', style: TextStyle(fontSize: 25.0)),
                onPressed: () {
                  Get.off(DurationInputScreen());
                   Screen.keepOn(false);
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
