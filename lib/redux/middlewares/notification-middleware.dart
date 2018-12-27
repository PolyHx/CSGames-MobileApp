import 'dart:io';

import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/attendees.service.dart';
import 'package:PolyHxApp/services/notification.service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class NotificationMiddleware implements EpicClass<AppState> {
  final NotificationService _notificationService;
  final FirebaseMessaging _firebaseMessaging;
  final AttendeesService _attendeesService;

  NotificationMiddleware(this._notificationService, this._firebaseMessaging, this._attendeesService);

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable.merge([
      Observable(actions)
        .ofType(TypeToken<LoadNotificationsAction>())
        .switchMap((action) => _fetchNotifications(action.eventId)),
      Observable(actions)
        .ofType(TypeToken<SendSms>())
        .switchMap((action) => _sendSms(action.eventId, action.message)),
      Observable(actions)
        .ofType(TypeToken<SetupNotificationAction>())
        .switchMap((action) => _setupNotifications())
    ]);
  }

  Stream<dynamic> _fetchNotifications(String eventId) async* {
    try {
      yield NotificationsLoadedAction(await _notificationService.getNotificationsForEvent(eventId));
    } catch(err) {
      print('An error occured while getting the notifications: $err');
      yield NotificationsNotLoadedAction();
    }
  }

  Stream<dynamic> _sendSms(String eventId, String message) async* {
    try {
      await _notificationService.sendSms(eventId, message);
      yield SmsSentAction();
    } catch(err) {
      print('An error occured while sending the sms : $err');
      yield SmsNotSentAction();
    }
  }

  Stream<dynamic> _setupNotifications() async* {
    try {
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
        _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) => print('Settings registered: $settings'));
      }

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          showToast(message['notification']['title'], message['notification']['body']);
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          showToast(message['notification']['title'], message['notification']['body']);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          showToast(message['notification']['title'], message['notification']['body']);
        }
      );

      String token = await _firebaseMessaging.getToken();
      await _attendeesService.setFcmToken(token);
    } catch(err) {
      print('An error occured while doing the setup of the notifications $err');
    }
  }

  void showToast(String title, String message) {
    Fluttertoast.showToast(
      msg: '$title : $message',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 5
    );
  }
}