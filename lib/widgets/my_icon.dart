import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

/// An image in a rounded box
class MyIcon extends StatelessWidget {
  /// The link of the image
  final String image;

  /// The diameter to apply to the circle
  final double diameter;

  MyIcon({this.image, this.diameter});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Container(
        width: this.diameter,
        height: this.diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeProvider.theme.themeData.primaryColor,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(this.image),
          ),
        ),
      );
    });
  }
}
