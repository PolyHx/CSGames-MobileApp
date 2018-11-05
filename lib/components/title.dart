import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String title;
  final MainAxisAlignment alignment;
  final Widget icon;

  AppTitle(this.title, this.alignment, [this.icon]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(22.5),
      child: Row(
        mainAxisAlignment: this.alignment,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Flipbash',
              fontSize: 40.0
            )
          ),
          this.icon != null ? this.icon : Padding(padding: EdgeInsets.all(0.0))
        ]
      )
    );
  }
}