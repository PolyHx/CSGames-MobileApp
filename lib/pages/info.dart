import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/domain/event.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final Event _event;

  InfoPage(this._event);

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Text(
                  _event.details[LocalizationService.of(context).language],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 20.0,
                    height: 1.15
                  )
                )
              ]
            )
          ) 
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppTitle(LocalizationService.of(context).info['title'], MainAxisAlignment.start),
        _buildInfo(context)
      ]
    );
  }
}