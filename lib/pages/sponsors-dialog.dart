import 'package:PolyHxApp/components/pill-button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsDialog extends StatelessWidget {
  final Map<String, String> _values;
  final String website;

  SponsorsDialog(this._values, this.website);

  Widget _buildLogo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Image.asset(
        'assets/logo.png',
        width: MediaQuery.of(context).size.width * 0.4,
      )
    );
  }

  Widget _buildText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
      child: Text(
        _values['text'],
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 18.0
        )
      )
    );
  }

  Widget _buildHyperlink() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () => launch(this.website),
        child: Text(
          'polyhx.io',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18.0,
            decoration: TextDecoration.underline,
            color: Colors.blue
          )
        )
      )
    );
  }

  Widget _buildButton(BuildContext context) {
    return PillButton(
      onPressed: () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 12.5, 25.0, 12.5),
        child: Text(
          _values['done'],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          )
        )
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Opacity(
            opacity: 0.85,
            child: Material(
              elevation: 1.0,
              borderRadius: BorderRadius.circular(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildLogo(context),
                          _buildText(),
                          _buildHyperlink(),
                          _buildButton(context)
                        ]
                      )
                    )
                  )
                ]
              )
            )
          )
        )
      ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        child: _buildBody(context)
      )
    );
  }
}