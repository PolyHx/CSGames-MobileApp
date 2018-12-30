import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/domain/event.dart';
import 'package:PolyHxApp/pages/bring.dart';
import 'package:PolyHxApp/pages/parking.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tile {
    IconData icon;
    String title;
    String id;

    Tile(this.icon, this.title, this.id);
}

class EventInfoPage extends StatelessWidget {
  final double _widthFactor = 0.41;
  final double _heightFactor = 0.39;

  void _showTileInfo(BuildContext context, String id) {
    var widget;
    switch (id) {
        case '1':
            widget = BringPage(LocalizationService.of(context).bring);
            break;
        case '2':
            widget = ParkingState();
            break;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget,
          fullscreenDialog: true
        )
    );
  }

    Widget _buildTile(BuildContext context, Tile tile) {
        return GestureDetector(
            onTap: () => _showTileInfo(context, tile.id),
            child: Padding(
                padding: EdgeInsets.all(12.5),
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * _widthFactor,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * _heightFactor,
                    child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 2.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 7.0),
                                    child: Icon(
                                        tile.icon,
                                        size: 85.0,
                                        color: Constants.polyhxRed
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.03),
                                    child: Text(
                                        tile.title,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Raleway'
                                        )
                                    )
                                )

                            ]
                        )
                    )
                )
            )
        );
    }

  Widget _buildTiles(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: [
          Tile(
            FontAwesomeIcons.clipboardCheck,
            LocalizationService.of(context).eventInfo['bring'],
            '1'
          ),
          Tile(
            FontAwesomeIcons.parking,
            LocalizationService.of(context).eventInfo['parking'],
            '2'
          )
        ].map((Tile tile) => _buildTile(context, tile)).toList()
      )
    );
  }

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, Event>(
            converter: (store) => store.state.currentEvent,
            builder: (BuildContext context, Event event) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        AppTitle(
                            LocalizationService.of(context).eventInfo['title'],
                            MainAxisAlignment.spaceBetween,
                            FontAwesomeIcons.thLarge
                        ),
                        _buildTiles(context)
                    ]
                );
            }
        );
    }
}
