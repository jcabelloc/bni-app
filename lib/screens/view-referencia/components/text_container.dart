import 'package:bniapp/utils/constants.dart';
import 'package:flutter/material.dart';

Widget textContainer(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 20.0,
          child: VerticalDivider(
            color: kPrimaryColorDark,
            thickness: 1,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ],
    ),
  );
}
