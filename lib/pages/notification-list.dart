import 'package:PolyHxApp/components/loading-spinner.dart';
import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/domain/notification.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationListPage extends StatelessWidget {
  Widget _buildTile(BuildContext context, AppNotification notification) {
    String date = timeago.format(notification.date, locale: LocalizationService.of(context).code);
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 3.0, 15.0, 3.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          elevation: 1.0,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    notification.type == 'event' ? FontAwesomeIcons.calendar : FontAwesomeIcons.calendarCheck,
                    color: notification.type == 'event' ? Constants.polyhxRed : Colors.blue,
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  notification.body,
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 11.0
                                  )
                                )
                              )
                            ),
                          ]
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            date,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 10.0
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
        )
      )
    );
  }

  Widget _buildNotifications(BuildContext context, _NotificationsListViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: model.notifications.map((n) => _buildTile(context, n)).toList()
      )
    );
  }

  Widget _buildBody(BuildContext context, _NotificationsListViewModel model) {
    model.notifications.sort((AppNotification a, AppNotification b) => b.date.compareTo(a.date));
    return model.hasErrors
      ? Text(LocalizationService.of(context).notification['error'])
      : _buildNotifications(context, model);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _NotificationsListViewModel>(
      onInit: (store) {
        final state = store.state.notificationState;
        if (state.notifications.isEmpty && !state.isLoading && !state.hasErrors) {
          store.dispatch(LoadNotificationsAction(store.state.currentEvent.id));
        }
      },
      converter: (store) => _NotificationsListViewModel.fromtStore(store),
      builder: (BuildContext context, _NotificationsListViewModel model) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
                model.reset();
              }
            ),
            title: Text(
              LocalizationService.of(context).notification['title'],
              style: TextStyle(
                fontFamily: 'Raleway'
              )
            )
          ),
          body: model.isLoading
            ? Center(child: LoadingSpinner())
            : _buildBody(context, model)
        );
      }
    );
  }
}

class _NotificationsListViewModel {
  List<AppNotification> notifications;
  bool isLoading;
  bool hasErrors;
  Function reset;

  _NotificationsListViewModel(
    this.notifications,
    this.isLoading,
    this.hasErrors,
    this.reset
  );

  _NotificationsListViewModel.fromtStore(Store<AppState> store) {
    notifications = store.state.notificationState.notifications;
    isLoading = store.state.notificationState.isLoading;
    hasErrors = store.state.notificationState.hasErrors;
    reset = () => store.dispatch(ResetNotificationsAction());
  }
}