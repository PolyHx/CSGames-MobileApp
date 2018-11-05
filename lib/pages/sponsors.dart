import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/components/touchable-image.dart';
import 'package:PolyHxApp/pages/sponsors-dialog.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:flutter/material.dart';

class SponsorsPage extends StatelessWidget {
  Map<String, dynamic> _values;
  final double widthFactorPeta = 0.6;
  final double widthFactorTera = 0.4;
  final double widthFactoreGiga = 0.3;

  String _getTranslation(BuildContext context, String element) {
    return _values == null ? LocalizationService.of(context).sponsors[element] : _values[element];
  }

  void _openDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => SponsorsDialog(LocalizationService.of(context).sponsors, 'https://polyhx.io'), barrierDismissible: false);
  }

  Widget _buildSubtitle(String value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'Flipbash',
        fontSize: 20.0
      )
    );
  }

  Widget _buildPeta(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSubtitle('PETABYTES'),
        TouchableImage(
          widthFactorPeta,
          EdgeInsets.only(top: 10.0),
          'assets/logo.png',
          () => _openDialog(context)
        )
      ]
    );
  }

  Widget _buildTera(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSubtitle('TERABYTES'),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TouchableImage(
                widthFactorTera,
                EdgeInsets.only(left: 20.0),
                'assets/logo.png',
                () => _openDialog(context)
              ),
              TouchableImage(
                widthFactorTera,
                EdgeInsets.only(right: 20.0),
                'assets/logo.png',
                () => _openDialog(context)
              )
            ]
          )
        ),
        TouchableImage(
          widthFactorTera,
          EdgeInsets.all(0.0),
          'assets/logo.png',
          () => _openDialog(context)
        )
      ]
    );
  }

  Widget _buildGiga(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSubtitle('GIGABYTES'),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TouchableImage(
                widthFactoreGiga,
                EdgeInsets.only(left: 55.0),
                'assets/logo.png',
                () => _openDialog(context)
              ),
              TouchableImage(
                widthFactoreGiga,
                EdgeInsets.only(right: 55.0),
                'assets/logo.png',
                () => _openDialog(context)
              )
            ]
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TouchableImage(
                widthFactoreGiga,
                EdgeInsets.only(left: 10.0),
                'assets/logo.png',
                () => _openDialog(context)
              )
            ]
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TouchableImage(
                widthFactoreGiga,
                EdgeInsets.only(left: 55.0),
                'assets/logo.png',
                () => _openDialog(context)
              ),
              TouchableImage(
                widthFactoreGiga,
                EdgeInsets.only(right: 55.0),
                'assets/logo.png',
                () => _openDialog(context)
              )
            ]
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppTitle(_getTranslation(context, 'title'), MainAxisAlignment.start),
        _buildPeta(context),
        _buildTera(context),
        _buildGiga(context)
      ]
    );
  }
}