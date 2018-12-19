import 'package:PolyHxApp/components/loading-spinner.dart';
import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/domain/notification.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class NotificationListPage extends StatelessWidget {
  Widget _buildTile(BuildContext context, AppNotification notification) {
    String code = LocalizationService.of(context).code;
    DateFormat formatter = DateFormat('MMMM d H:mm', code);
    String date = formatter.format(notification.date);
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.15,
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          elevation: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  notification.title,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 30.0
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 15.0
                  )
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget _buildNotifications(BuildContext context, _NotificationsListViewModel model) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: model.notifications.map((n) => _buildTile(context, n)).toList()
    );
  }

  Widget _buildBody(BuildContext context, _NotificationsListViewModel model) {
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
          body: Center(
            child: model.isLoading
              ? LoadingSpinner()
              : _buildBody(context, model)
          )
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