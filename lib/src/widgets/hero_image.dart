import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  // TODO: Change hero image
  final imageName = "children_with_bananas_lq";
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpg',
    );
  }
}
