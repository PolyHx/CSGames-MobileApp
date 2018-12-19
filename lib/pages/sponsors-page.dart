import 'package:PolyHxApp/components/loading-spinner.dart';
import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/components/touchable-image.dart';
import 'package:PolyHxApp/domain/sponsors.dart';
import 'package:PolyHxApp/pages/sponsors-dialog.dart';
import 'package:PolyHxApp/redux/actions/sponsors-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SponsorsPage extends StatelessWidget {
  Map<String, dynamic> _values;
  final double widthFactorPeta = 0.6;
  final double widthFactorTera = 0.4;
  final double widthFactoreGiga = 0.3;

  String _getTranslation(BuildContext context, String element) {
    return _values == null ? LocalizationService.of(context).sponsors[element] : _values[element];
  }

  void _openDialog(BuildContext context, Sponsors sponsors) {
    showDialog(context: context, builder: (_) => SponsorsDialog(sponsors), barrierDismissible: false);
  }

  Widget _buildSubtitle(String value) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Flipbash',
        fontSize: 20.0
      )
    );
  }

  Widget _buildImage(BuildContext context, Sponsors sponsors) {
    return TouchableImage(
      sponsors.widthFactor,
      sponsors.heightFactor,
      EdgeInsets.fromLTRB(
        sponsors.padding[0].toDouble(),
        sponsors.padding[1].toDouble(),
        sponsors.padding[2].toDouble(),
        sponsors.padding[3].toDouble()
      ),
      sponsors.imageUrl,
      () => _openDialog(context, sponsors)
    );
  }

  Widget _buildLevel(BuildContext context, List<Sponsors> sponsors, int count) {
    int i = 0;
    List<Row> rows = List<Row>();
    while (i < sponsors.length) {
      List<Widget> widgets = List<Widget>();
      for (int j = 0; j < count; j++) {
        if (i + j < sponsors.length) {
          widgets.add(_buildImage(context, sponsors[i+j]));
        }
      }
      Row row = Row(
        mainAxisAlignment: count > 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: widgets
      );
      rows.add(row);
      i += count;
    }
    return Column(children: rows);
  }

  Widget _buildSponsors(BuildContext context, _SponsorsPageViewModel model) {
    List<String> keys = model.sponsors.isNotEmpty ? model.sponsors.keys.toList() : [];
    return model.hasErrors
      ? Text(_values['error'])
      : Column(
          children: <Widget>[
            AppTitle(_getTranslation(context, 'title'), MainAxisAlignment.start),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: model.sponsors.isEmpty ? [] : <Widget>[
                  _buildSubtitle(keys[0].toUpperCase()),
                  _buildLevel(context, model.sponsors[keys[0]], 1),
                  _buildSubtitle(keys[1].toUpperCase()),
                  _buildLevel(context, model.sponsors[keys[1]], 2),
                  _buildSubtitle(keys[2].toUpperCase()),
                  _buildLevel(context, model.sponsors[keys[2]], 2),
                  _buildSubtitle(keys[3].toUpperCase()),
                  _buildLevel(context, model.sponsors[keys[3]], 2)
                ]
              )
            )
          ]
        );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SponsorsPageViewModel>(
      onInit: (store) {
        _values = LocalizationService.of(context).sponsors;
        final sponsorsState = store.state.sponsorsState;
        if (sponsorsState.sponsors.isEmpty && !sponsorsState.hasErrors) {
          store.dispatch(LoadSponsorsAction(store.state.currentEvent.id));
        }
      },
      converter: (store) => _SponsorsPageViewModel.fromStore(store),
      builder: (BuildContext context, _SponsorsPageViewModel model) {
        return model.isLoading
          ? LoadingSpinner()
          : _buildSponsors(context, model);
      }
    );
  }
}

class _SponsorsPageViewModel {
  Map<String, List<Sponsors>> sponsors;
  bool isLoading;
  bool hasErrors;

  _SponsorsPageViewModel(
    this.sponsors,
    this.isLoading,
    this.hasErrors
  );

  _SponsorsPageViewModel.fromStore(Store<AppState> store) {
    sponsors = store.state.sponsorsState.sponsors;
    isLoading = store.state.sponsorsState.isLoading;
    hasErrors = store.state.sponsorsState.hasErrors;
  }
}