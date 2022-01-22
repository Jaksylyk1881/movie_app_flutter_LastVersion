import 'package:flutter/material.dart';
class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 1,
        width: double.infinity,
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
