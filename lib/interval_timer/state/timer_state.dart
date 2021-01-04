import 'package:fit_time_getx/interval_timer/screens/finish_screen.dart';
import 'package:fit_time_getx/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';

enum WorkoutState { initial, prepare, work, rest, breakTime, finished }

class TimerState extends GetxController {
  WorkoutState _state = WorkoutState.initial;
  Timer _t;
  int _cyclesCount = 0;
  int _setsCount = 1;
  var _player = AudioCache();
  var _prefs = UserPreferences();

  var prepareDuration = Duration(seconds: 15).obs;
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

  void init() {
    prepareDuration.value = Duration(seconds: _prefs.prepareDuration);
    workDuration.value = Duration(seconds: _prefs.workDuration);
    restDuration.value = Duration(seconds: _prefs.restDuration);
    breakDuration.value = Duration(seconds: _prefs.breakDuration);
    sets.value = _prefs.sets;
    cycles.value = _prefs.cycles;
  }

  void resetToDefault() {
    _prefs.clear();
    init();
  }

  void prepareDurationIncrement() {
    prepareDuration.value += Duration(seconds: 5);
    _prefs.prepareDuration = prepareDuration.value.inSeconds;
  }

  void prepareDurationDecrement() {
    prepareDuration.value -= Duration(seconds: 5);
    prepareDuration.value = prepareDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : prepareDuration.value;
    UserPreferences().prepareDuration = prepareDuration.value.inSeconds;
  }

  void workDurationIncrement() {
    workDuration.value += Duration(seconds: 5);
    UserPreferences().workDuration = workDuration.value.inSeconds;
  }

  void workDurationDecrement() {
    workDuration.value -= Duration(seconds: 5);
    workDuration.value = workDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : workDuration.value;
    UserPreferences().workDuration = workDuration.value.inSeconds;
  }

  void restDurationIncrement() {
    restDuration.value += Duration(seconds: 5);
    UserPreferences().restDuration = restDuration.value.inSeconds;
  }

  void restDurationDecrement() {
    restDuration.value -= Duration(seconds: 5);
    restDuration.value = restDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : restDuration.value;
    UserPreferences().restDuration = restDuration.value.inSeconds;
  }

  void breakDurationIncrement() {
    breakDuration.value += Duration(seconds: 5);
    UserPreferences().breakDuration = breakDuration.value.inSeconds;
  }

  void breakDurationDecrement() {
    breakDuration.value -= Duration(seconds: 5);
    breakDuration.value = breakDuration.value < Duration(seconds: 5)
        ? Duration(seconds: 5)
        : breakDuration.value;
    UserPreferences().breakDuration = breakDuration.value.inSeconds;
  }

  void cyclesIncrement() {
    cycles.value++;
    UserPreferences().cycles = cycles.value;
  }

  void cyclesDecrement() {
    cycles.value--;
    cycles.value = sets.value < 1 ? 1 : cycles.value;
    UserPreferences().cycles = cycles.value;
  }

  void setsIncrement() {
    sets.value++;
    UserPreferences().sets = sets.value;
  }

  void setsDecrement() {
    sets.value--;
    sets.value = sets.value < 1 ? 1 : sets.value;
    UserPreferences().sets = sets.value;
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
      _cyclesCount = 0;
      _setsCount = 1;
    }

    _t = Timer.periodic(Duration(seconds: 1), _tick);

    isRunning.value = true;
    isFinished.value = false;
  }

  void _tick(Timer timer) {
    totalTimeElapsed.value += Duration(seconds: 1);
    timeLeft.value -= Duration(seconds: 1);
    stateChange();
    if (timeLeft.value.inSeconds <= 3 && timeLeft.value.inSeconds >= 1) {
      _player.play('pip.mp3');
    }
  }

  void stateChange() {
    if (timeLeft.value.inSeconds == 0 && _cyclesCount < cycles.value) {
      switch (_state) {
        case WorkoutState.prepare:
          _state = WorkoutState.work;
          durationText.value = 'Work';
          timeLeft.value = workDuration.value;
          _player.play('bleep.mp3');
          backgroundColor.value = Colors.green[900];
          _cyclesCount++;
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
          _cyclesCount++;
          break;
        case WorkoutState.breakTime:
          _state = WorkoutState.work;
          durationText.value = 'Work';
          timeLeft.value = workDuration.value;
          _player.play('bleep.mp3');
          backgroundColor.value = Colors.green[900];
          _cyclesCount++;
          _setsCount++;
          break;
        default:
      }
    } else if (timeLeft.value.inSeconds == 0 &&
        _cyclesCount == cycles.value &&
        _setsCount < sets.value) {
      _state = WorkoutState.breakTime;
      backgroundColor.value = Colors.lightBlueAccent;
      _cyclesCount = 0;
      timeLeft.value = breakDuration.value;
      durationText.value = 'Break';
    } else if (timeLeft.value.inSeconds == 0 &&
        _cyclesCount == cycles.value &&
        _setsCount == sets.value) {
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
      Get.off(FinishScreen());
    });
  }

  int getCyclesCount() {
    return _cyclesCount;
  }

  int getSetsCount() {
    return _setsCount;
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
