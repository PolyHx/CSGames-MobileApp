import 'package:CSGamesApp/components/bullet-point.dart';
import 'package:CSGamesApp/services/localization.service.dart';
import 'package:CSGamesApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BringPage extends StatelessWidget {
    final Map<String, dynamic> _values;

    BringPage(this._values);

    void _close(BuildContext context) {
        Navigator.of(context).pop();
    }

    Widget _buildBulletPoint(String value) {
        return Padding(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    BulletPoint(7.0),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                    value,
                                    softWrap: true,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 18.0
                                    )
                                )
                            )
                        )
                    )
                ]
            )
        );
    }

    Widget _buildCard(BuildContext context) {
        return Container(
            child: Hero(
                tag: "guide-card-1",
                child: Stack(
                    children: <Widget>[
                        Positioned(
                            top: 17.0,
                            left: 9.0,
                            child: Center(
                                child: Container(
                                    width: 20,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4.0,
                                                offset: Offset(0, 1),
                                                spreadRadius: 0.0
                                            )
                                        ]
                                    ),
                                    child: Material(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Constants.csBlue,
                                        child: Text('')
                                    )
                                )
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(15.0),
                                child: Column(
                                    children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons.clipboardCheck,
                                                        size: 38.0,
                                                        color: Constants.csBlue,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(left: 10.0),
                                                        child: Text(
                                                            LocalizationService
                                                                .of(context)
                                                                .eventInfo['bring'].toUpperCase(),
                                                            style: TextStyle(
                                                                fontFamily: 'flipbash',
                                                                fontSize: 24.0
                                                            )
                                                        )
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                        icon: Icon(FontAwesomeIcons.times),
                                                        onPressed: () => _close(context),
                                                    )
                                                ],
                                            )
                                        ),
                                        Expanded(
                                            child: ListView(
                                                children: <Widget>[
                                                    _buildBulletPoint(_values['clothes']),
                                                    _buildBulletPoint(_values['degrise']),
                                                    _buildBulletPoint(_values['banquet']),
                                                    _buildBulletPoint(_values['laptop']),
                                                    _buildBulletPoint(_values['pool']),
                                                    _buildBulletPoint(_values['snack']),
                                                    _buildBulletPoint(_values['beverage']),
                                                    _buildBulletPoint(_values['costume'])
                                                ]
                                            )
                                        )
                                    ]
                                )
                            )
                        )
                    ]
                )
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(top: 70.0 + MediaQuery
                .of(context)
                .padding
                .top, bottom: 65.0 + MediaQuery
                .of(context)
                .padding
                .bottom),
            child:  _buildCard(context)
        );
    }
}