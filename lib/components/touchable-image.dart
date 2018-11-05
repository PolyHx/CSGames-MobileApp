import 'package:flutter/material.dart';

class TouchableImage extends StatelessWidget {
  final double widthFactor;
  final EdgeInsetsGeometry padding;
  final String source;
  final Function onTap;

  const TouchableImage(this.widthFactor, this.padding, this.source, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: this.padding,
        child: Image.asset(
          this.source,
          width: MediaQuery.of(context).size.width * this.widthFactor
        )
      )
    );
  }
}