import 'package:PolyHxApp/components/title.dart';
import 'package:flutter/material.dart';

class HotelPage extends StatelessWidget {
  final Map<String, dynamic> _values;

  HotelPage(this._values);

  Widget _buildMap(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.72,
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(15.0)
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _values['title'],
          style: TextStyle(
            fontFamily: 'Raleway'
          )
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitle(
            _values['guide'],
            MainAxisAlignment.spaceBetween,
            Icon(
              Icons.hotel,
              size: 45.0
            )
          ),
          _buildMap(context)
        ]
      ),
      resizeToAvoidBottomPadding: false
    );
  }
}