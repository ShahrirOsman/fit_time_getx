import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fit_time_getx/widgets/duration_round_button.dart';
import 'package:fit_time_getx/const.dart';

class SimpleDurationPicker extends StatelessWidget {
  const SimpleDurationPicker({
    this.title,
    this.duration,
    @required this.onPressedMinus,
    @required this.onPressedPlus,
  });
  final String title;
  final String duration;
  final Function onPressedMinus;
  final Function onPressedPlus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 50.0, top: 8.0),
          child: Text(
            title,
            style: kPickerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 60.0,bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DurationRoundButton(
                icon: Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.white,
                ),
                onPressed: onPressedMinus,
              ),
              Container(
                width: 85.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  duration,
                  style: kPickerTextStyle,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              DurationRoundButton(
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
                onPressed: onPressedPlus,
              )
            ],
          ),
        ),
      ],
    );
  }
}
