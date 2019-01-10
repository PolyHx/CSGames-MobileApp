import 'package:PolyHxApp/components/event-image.dart';
import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/domain/event.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
    final Event _event;

    InfoPage(this._event);

    Widget _buildInfo(BuildContext context) {
        return Stack(
            children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Material(
                        elevation: 2.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ListView(
                                children: <Widget>[
                                    Text(
                                        _event.details[LocalizationService
                                            .of(context)
                                            .language],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 20.0,
                                            height: 1.15
                                        )
                                    )
                                ]
                            )
                        )
                    )
                ),
                Align(
                    child: EventImage(_event)
                )
            ]
        );
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: _buildInfo(context)
        );
    }
}