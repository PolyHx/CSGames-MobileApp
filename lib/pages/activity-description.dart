import 'package:PolyHxApp/components/loading-spinner.dart';
import 'package:PolyHxApp/components/pill-button.dart';
import 'package:PolyHxApp/domain/activity.dart';
import 'package:PolyHxApp/redux/actions/activity-description-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class ActivityDescriptionPage extends StatelessWidget {
  final Activity _activity;
  final Map<String, dynamic> _values;

  ActivityDescriptionPage(this._activity, this._values);

  Widget _buildTitle(BuildContext context) {
    String code = LocalizationService.of(context).code;
    var formatter = DateFormat.Hm(code);
    var beginHour = formatter.format(_activity.beginDate);
    var endHour = formatter.format(_activity.endDate);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                child: Icon(
                  FontAwesomeIcons.utensils,
                  size: 45.0
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _activity.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Raleway'
                      )
                    ),
                    Text(
                      "$beginHour - $endHour",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Raleway'
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      ]
    );
  }

  Widget _buildText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 10.0),
          children: <Widget>[
            Text(
              _activity.description[LocalizationService.of(context).language] ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20.0,
                height: 1.15
              )
            )
          ]
        )
      )
    );
  }

  Widget _buildButton(BuildContext context, _ActivityDescriptionViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: PillButton(
        color: model.isSubscribed ? Colors.grey: Constants.polyhxRed,
        onPressed: () {
          if (!model.isSubscribed) model.subscribe(_activity.id);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 12.5, 16.0, 12.5),
          child: Text(
            model.isSubscribed ? _values['subscribed'] : _values['subscribe'],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            )
          )
        )
      )
    );
  }

  Widget _buildBody(BuildContext context, _ActivityDescriptionViewModel model) {
    return Center(
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          _buildText(context),
          _buildButton(context, model)
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ActivityDescriptionViewModel>(
      onInit: (store) => store.dispatch(VerifySubscriptionAction(_activity.id, store.state.currentAttendee?.id ?? '')),
      converter: (store) => _ActivityDescriptionViewModel.fromStore(store),
      builder: (BuildContext context, _ActivityDescriptionViewModel model) {
        return Scaffold(
          appBar: AppBar(title: Text('')),
          body: model.isLoading ? LoadingSpinner() : _buildBody(context, model),
          resizeToAvoidBottomPadding: false
        );
      }
    );
  }
}

class _ActivityDescriptionViewModel {
  bool hasErrors;
  bool isLoading;
  bool isSubscribed;
  Function subscribe;

  _ActivityDescriptionViewModel(
    this.hasErrors,
    this.isLoading,
    this.isSubscribed,
    this.subscribe,
  );

  _ActivityDescriptionViewModel.fromStore(Store<AppState> store) {
    hasErrors = store.state.activityDescriptionState.hasErrors;
    isLoading = store.state.activityDescriptionState.isLoading;
    isSubscribed = store.state.activityDescriptionState.isSubscribed;
    subscribe = (activityId) => store.dispatch(SubscribeAction(activityId, store.state.currentAttendee?.id ?? ''));
  }
}