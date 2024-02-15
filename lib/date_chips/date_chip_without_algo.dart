import 'package:flutter/material.dart';

///[DateChipWithoutAlgo] use to show the date breakers on the chat view
///[color] parameter is optional default color code `8AD3D5`
///
///
class DateChipWithoutAlgo extends StatelessWidget {
  final Color color;
  final String text;
  late final DateTime date;

  ///
  ///
  ///
  DateChipWithoutAlgo({
    Key? key,
    required this.text,
    required this.date,
    this.color = const Color(0x558AD3D5),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
        bottom: 7,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
