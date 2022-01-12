import 'package:cng/constants/global.dart';
import 'package:flutter/material.dart';

class CustomDateChip extends StatelessWidget {
  final String date;
  const CustomDateChip({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
        bottom: 7,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color(0x558AD3D5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(chatDateParse(date)),
        ),
      ),
    );
  }
}
