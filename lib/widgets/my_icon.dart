import 'package:flutter/material.dart';

/// An image in a rounded box
class MyIcon extends StatelessWidget {
  /// The link of the image
  final String image;

  /// The diameter to apply to the circle
  final double diameter;

  MyIcon({this.image, this.diameter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.diameter,
      height: this.diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(this.image),
        ),
      ),
    );
  }
}
