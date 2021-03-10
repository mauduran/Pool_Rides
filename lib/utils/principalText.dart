import 'package:flutter/material.dart';

Widget principalText({
  @required upText,
  @required downText,
  @required context,
  @required colorDefault,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 2.5),
        child: Text(
          upText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          top: 5,
          bottom: 5,
        ),
        child: Icon(
          Icons.south,
          size: 30,
          color:
              colorDefault ? Theme.of(context).primaryColor : Color(0xFFEFF2F6),
        ),
      ),
      Text(
        downText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}
