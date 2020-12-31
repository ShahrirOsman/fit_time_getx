import 'package:fit_time_getx/const.dart';
import 'package:flutter/material.dart';

class DurationRoundButton extends StatelessWidget {
  const DurationRoundButton({
    @required this.icon,
    @required this.onPressed,
  });

  final Widget icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: icon,
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 40.0,
        height: 40.0,
      ),
      shape: CircleBorder(),
      fillColor: kDurationRoundBtnColour,
    );
  }
}
