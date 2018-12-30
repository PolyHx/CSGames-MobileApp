import 'dart:io';

import 'package:PolyHxApp/components/pill-button.dart';
import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingState extends StatefulWidget {
  @override
  State createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingState> {
  final _latitudePrincipal = 45.5054887;
  final _longitudePrincipal = -73.6132495;
  GoogleMapController mapController;

  _ParkingPageState();

  void _onMapCreated(GoogleMapController controller) {
    setState(() => mapController = controller);
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(_latitudePrincipal, _longitudePrincipal)
      )
    );
  }

  Widget _buildMap(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.72,
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.77,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    options: GoogleMapOptions(
                      cameraPosition: CameraPosition(
                        target: LatLng(45.5048297, -73.6138467),
                        zoom: 17.0
                      )
                    )
                  )
                )
              ),
              PillButton(
                color: Constants.polyhxRed,
                onPressed: () async {
                  var url = '';
                  if (Platform.isIOS) {
                    url = 'http://maps.apple.com/?ll=45.5043877,-73.6150716';
                  } else if (Platform.isAndroid) {
                    url = 'geo:45.5043877,-73.6150716';
                  }
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print('Cannot open the map application.');
                  }
                },
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
            ]
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationService.of(context).parking['title'],
          style: TextStyle(
            fontFamily: 'Raleway'
          )
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitle(
            LocalizationService.of(context).parking['guide'],
            MainAxisAlignment.spaceBetween,
            FontAwesomeIcons.parking
          ),
          _buildMap(context)
        ]
      ),
      resizeToAvoidBottomPadding: false
    );
  }
}