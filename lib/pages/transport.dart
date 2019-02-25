import 'dart:io';

import 'package:CSGamesApp/components/pill-button.dart';
import 'package:CSGamesApp/domain/guide.dart';
import 'package:CSGamesApp/services/localization.service.dart';
import 'package:CSGamesApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportPage extends StatelessWidget {
    final Transport _transport;

    TransportPage(this._transport);

    void _close(BuildContext context) {
        Navigator.of(context).pop();
    }

    Future _clickNavigate() async {
        var url = '';
        if (Platform.isIOS) {
            // url = 'http://maps.apple.com/?daddr=$_latitudePrincipal,$_longitudePrincipal';
        } else if (Platform.isAndroid) {
            url = 'https://www.google.com/maps/dir/?api=1&origin=${_transport.hotelLatitude},${_transport.hotelLongitude}&destination=${_transport.schoolLatitude},${_transport.schoolLongitude}&travelmode=transit';
        }
        if (await canLaunch(url)) {
            await launch(url);
        } else {
            print('Cannot open the map application.');
        }
    }

    Widget _buildCard(BuildContext context) {
        return Container(
            child: Hero(
                tag: "guide-card-transport",
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons.subway,
                                                        size: 38.0,
                                                        color: Constants.csBlue,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(left: 10.0),
                                                        child: Text(
                                                            LocalizationService
                                                                .of(context)
                                                                .eventInfo['transport'].toUpperCase(),
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
                                                ]
                                            )
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                            child: Text(
                                                _transport.info[LocalizationService.of(context).language],
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontSize: 16.0,
                                                    height: 1.15
                                                )
                                            )
                                        ),
                                        Image.network(
                                            _transport.image,
                                            width: MediaQuery.of(context).size.width * 0.8
                                        ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(left: 20.0),
                                                    child: Icon(
                                                        Icons.school,
                                                        size: 38.0,
                                                        color: Constants.csBlue
                                                    )
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                                                        child: Text(
                                                            _transport.school,
                                                            style: TextStyle(
                                                                fontFamily: 'Raleway',
                                                                fontSize: 17.0
                                                            )
                                                        )
                                                    )
                                                )
                                            ]
                                        ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(left: 20.0),
                                                    child: Icon(
                                                        Icons.hotel,
                                                        size: 38.0,
                                                        color: Constants.csBlue
                                                    )
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                                                        child: Text(
                                                            _transport.hotel,
                                                            style: TextStyle(
                                                                fontFamily: 'Raleway',
                                                                fontSize: 17.0
                                                            )
                                                        )
                                                    )
                                                )
                                            ]
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: PillButton(
                                                color: Constants.csBlue,
                                                onPressed: _clickNavigate,
                                                child: Padding(
                                                    padding: EdgeInsets.fromLTRB(16.0, 12.5, 16.0, 12.5),
                                                    child: Text(
                                                        'Directions',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.0
                                                        )
                                                    )
                                                )
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