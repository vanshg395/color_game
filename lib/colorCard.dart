import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  final Color colour;

  ColorCard(this.colour);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
