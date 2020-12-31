import 'package:flutter/material.dart';

const kPickerTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const kTimeTextStyle = TextStyle(
  fontSize: 80.0,
  fontWeight: FontWeight.w900,
);

const kAccentColor = Color(0xFF27205F);

const kDurationRoundBtnColour = Color(0xFF27205F);

String durationString(Duration duration) {
  String seconds = (duration.inSeconds).toString();
  return seconds;
}

String formatTime(Duration duration) {
  String minutes = (duration.inMinutes).toString().padLeft(2, '0');
  String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
