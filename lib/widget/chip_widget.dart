import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String text;
  final int colorCode;

  const ChipWidget({Key? key, required this.text, required this.colorCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
      decoration: BoxDecoration(
          color: Color(colorCode),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.white, fontSize: 12),
      ),
    );
  }
}
