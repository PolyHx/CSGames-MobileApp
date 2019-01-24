import 'dart:io';

import 'package:CSGamesApp/components/pill-button.dart';
import 'package:CSGamesApp/services/localization.service.dart';
import 'package:CSGamesApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelState extends StatefulWidget {
    @override
    State createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelState> {
    final _latitudePrincipal = 45.5157006;
    final _longitudePrincipal = -73.5591572;
    final _iosOffsetX = -0.0015;
    final _iosOffsetY = 0.001;

    var showMap = false;

    GoogleMapController mapController;

    Future _onMapCreated(GoogleMapController controller) async {
        setState(() => mapController = controller);

        mapController.addMarker(
            MarkerOptions(
                position: LatLng(_latitudePrincipal, _longitudePrincipal)
            )
        );
    }

    void _close(BuildContext context) {
        setState(() => showMap = false);
        Future.delayed(Duration(milliseconds: 10), () => Navigator.of(context).pop());
    }

    Future _clickNavigate() async {
        var url = '';
        if (Platform.isIOS) {
            url = 'http://maps.apple.com/?daddr=$_latitudePrincipal,$_longitudePrincipal';
        } else if (Platform.isAndroid) {
            url = 'https://www.google.com/maps/search/?api=1&query=Hôtels+Gouverneur+Montréal';
        }
        if (await canLaunch(url)) {
            await launch(url);
        } else {
            print('Cannot open the map application.');
        }
    }

    Widget _buildMap(BuildContext context) {
        return Container(
            child: Hero(
                tag: 'guide-card-3',
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
                                                        Icons.hotel,
                                                        size: 38.0,
                                                        color: Constants.csBlue
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(left: 10.0),
                                                        child: Text(
                                                            LocalizationService
                                                                .of(context)
                                                                .eventInfo['hotel'].toUpperCase(),
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
                                        Center(
                                            child: SizedBox(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.75,
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.45,
                                                child: showMap ? GoogleMap(
                                                    onMapCreated: _onMapCreated,
                                                    options: GoogleMapOptions(
                                                        cameraPosition: CameraPosition(
                                                            target: LatLng(
                                                                _latitudePrincipal + (Platform.isIOS ? _iosOffsetY : 0),
                                                                _longitudePrincipal + (Platform.isIOS ? _iosOffsetX : 0)
                                                            ),
                                                            zoom: 17.0
                                                        ),
                                                    ),
                                                ) : Container()
                                            )
                                        ),
                                        Text(
                                            'Hôtels Gouverneur Montréal',
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 23.0
                                            )
                                        ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(left: 20.0),
                                                    child: Icon(
                                                        FontAwesomeIcons.mapMarkedAlt,
                                                        size: 40.0
                                                    )
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                                                        child: Text(
                                                            '1415 St Hubert St, Montreal, QC H2L 3Y9',
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
        if (mounted && !showMap) {
            Future.delayed(Duration(milliseconds: 5), () => setState(() => showMap = true));
        }
        return Container(
            margin: EdgeInsets.only(top: 70.0 + MediaQuery
                .of(context)
                .padding
                .top, bottom: 65.0 + MediaQuery
                .of(context)
                .padding
                .bottom),
            child:  _buildMap(context)
        );
    }
}