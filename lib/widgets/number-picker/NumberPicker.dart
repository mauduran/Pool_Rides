import 'package:flutter/material.dart';

class NumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final Function add;
  final Function subtract;
  final int currentValue;
  final String prefix;
  final String suffix;
  NumberPicker({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.currentValue,
    @required this.subtract,
    @required this.add,
    this.prefix = '',
    this.suffix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: (minValue == currentValue) ? Colors.grey : Colors.red[900],
              size: 32,
            ),
            onPressed: (minValue == currentValue) ? null : subtract,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "$prefix$currentValue$suffix",
              style: TextStyle(fontSize: 32),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color:
                  (maxValue == currentValue) ? Colors.grey : Colors.blue[900],
              size: 32,
            ),
            onPressed: (maxValue == currentValue) ? null : add,
          ),
        ],
      ),
    );
  }
}
