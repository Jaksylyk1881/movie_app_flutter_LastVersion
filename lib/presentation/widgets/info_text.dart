import 'package:flutter/material.dart';
import 'package:movie_app/utilits/constants.dart';
class InfoText extends StatelessWidget {
  final String label;
  final String info;
  const InfoText({
    required this.label,
    required this.info
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('$label         ',style: kLabelTextStyle),
      title: Text(info, style: kMainTextStyle,textAlign: TextAlign.right,),
    );
  }
}
