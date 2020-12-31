import 'package:fit_time_getx/screens/duration_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:screen/screen.dart';

enum WorkoutState { initial, prepare, work, rest, breakTime, finished }

class TimerState extends GetxController {
  WorkoutState _state = WorkoutState.initial;
  Timer _t;
  int cyclesCount = 0;
  int setsCount = 1;
  var _player = AudioCache();

  var prepareDuration = Duration(seconds: 5).obs;
  var restDuration = Duration(seconds: 15).obs;
  var workDuration = Duration(seconds: 30).obs;
  var cycles = RxInt(6);
  var sets = RxInt(2);
  var breakDuration = Duration(seconds: 15).obs;
  var timeLeft = Duration(seconds: 0).obs;
  var totalTimeElapsed = Duration(seconds: 0).obs;
  var durationText = RxString('Prepare');
  var isRunning = RxBool(false);
  var isFinished = RxBool(false);
  var backgroundColor = Colors.white.obs;

  void prepareDurationIncrement() {
    prepareDuration.value += Duration(seconds: 5);
  }

  void prepareDurationDecrement() {
    prepareDuration.value -= Duration(seconds: 5);
    prepareDuration.value = prepareDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : prepareDuration.value;
  }

  void workDurationIncrement() {
    workDuration.value += Duration(seconds: 5);
  }

  void workDurationDecrement() {
    workDuration.value -= Duration(seconds: 5);
    workDuration.value = workDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : workDuration.value;
  }

  void restDurationIncrement() {
    restDuration.value += Duration(seconds: 5);
  }

  void restDurationDecrement() {
    restDuration.value -= Duration(seconds: 5);
    restDuration.value = restDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : restDuration.value;
  }

  void breakDurationIncrement() {
    breakDuration.value += Duration(seconds: 5);
  }

  void breakDurationDecrement() {
    breakDuration.value -= Duration(seconds: 5);
    breakDuration.value = breakDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : breakDuration.value;
  }

  void cyclesIncrement() {
    cycles.value++;
  }

  void cyclesDecrement() {
    cycles.value--;
    cycles.value = sets.value < 1 ? 1 : cycles.value;
  }

  void setsIncrement() {
    sets.value++;
  }

  void setsDecrement() {
    sets.value--;
    sets.value = sets.value < 1 ? 1 : sets.value;
  }

  Duration getTotalTime() {
    Duration totalWorkoutTime;
    totalWorkoutTime = ((workDuration.value * cycles.value * sets.value) +
            (restDuration.value * sets.value * (cycles.value - 1))) +
        (breakDuration.value * (sets.value - 1)) +
        prepareDuration.value;

    return totalWorkoutTime;
  }

  void start() {
    print('Starting Timer');
    if (_state == WorkoutState.initial) {
      _state = WorkoutState.prepare;
      durationText.value = 'Prepare';
      timeLeft.value = prepareDuration.value;
      backgroundColor.value = Colors.white;

      totalTimeElapsed.value = Duration(seconds: 0);
      cyclesCount = 0;
      setsCount = 1;
    }

    _t = Timer.periodic(Duration(seconds: 1), _tick);

    isRunning.value = true;
    isFinished.value = false;
  }

  void _tick(Timer timer) {
    totalTimeElapsed.value += Duration(seconds: 1);
    timeLeft.value -= Duration(seconds: 1);
    stateChange();
    print(timeLeft.value.inSeconds);
    if (timeLeft.value.inSeconds <= 3 && timeLeft.value.inSeconds >= 1) {
      _player.play('pip.mp3');
    }
  }

  void stateChange() {
    print(_state.toString());
    print('cycles: $cyclesCount/${cycles.value} ');
    print('sets: $setsCount/${sets.value} ');
    if (timeLeft.value.inSeconds == 0 && cyclesCount < cycles.value) {
      switch (_state) {
        case WorkoutState.prepare:
          _state = WorkoutState.work;
          durationText.value = 'Work';
          timeLeft.value = workDuration.value;
          _player.play('bleep.mp3');
          backgroundColor.value = Colors.green[900];
          cyclesCount++;
          break;
        case WorkoutState.work:
          _state = WorkoutState.rest;
          durationText.value = 'Rest';
          timeLeft.value = restDuration.value;
          _player.play('bell-ring.mp3');
          backgroundColor.value = Colors.deepOrangeAccent[700];
          break;
        case WorkoutState.rest:
          _state = WorkoutState.work;
          durationText.value = 'Work';
          timeLeft.value = workDuration.value;
          _player.play('bleep.mp3');
          backgroundColor.value = Colors.green[900];
          cyclesCount++;
          break;
        case WorkoutState.breakTime:
          _state = WorkoutState.work;
          durationText.value = 'Work';
          timeLeft.value = workDuration.value;
          _player.play('bleep.mp3');
          backgroundColor.value = Colors.red[900];
          cyclesCount++;
          setsCount++;
          break;
        default:
      }
    } else if (timeLeft.value.inSeconds == 0 &&
        cyclesCount == cycles.value &&
        setsCount < sets.value) {
      _state = WorkoutState.breakTime;
      cyclesCount = 0;
      timeLeft.value = breakDuration.value;
      durationText.value = 'Break';
    } else if (timeLeft.value.inSeconds == 0 &&
        cyclesCount == cycles.value &&
        setsCount == sets.value) {
      _state = WorkoutState.finished;
      _player.play('boxing-bell.mp3');
    }
    if (_state == WorkoutState.finished) {
      setTimerFinished();
    }
  }

  void setTimerFinished() {
    _t.cancel();
    backgroundColor.value = Colors.blue;
    durationText.value = 'Finished';
    _state = WorkoutState.initial;
    isFinished.value = true;
    Future.delayed(Duration(seconds: 2), () {
      Get.off(DurationInputScreen());
      Screen.keepOn(false);
    });
  }

  void pause() {
    print('timer pause');
    _t.cancel();
    isRunning.value = false;
  }

  void reset() {
    print('timer reset');
    _t.cancel();
    _state = WorkoutState.initial;
    durationText.value = 'Prepare';
    isRunning.value = false;
  }

  void dispose() {
    super.dispose();
    _t.cancel();
  }
}
