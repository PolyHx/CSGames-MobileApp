import 'dart:convert';

import 'package:PolyHxApp/domain/notification.dart';
import 'package:PolyHxApp/services/token.service.dart';
import 'package:PolyHxApp/utils/environment.dart';
import 'package:http/http.dart';

class NotificationService {
  final Client _http;
  final TokenService _tokenService;

  NotificationService(this._http, this._tokenService);

  Future<List<AppNotification>> getNotificationsForEvent(String eventId) async {
    final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
    final response = await _http.get(
      '${Environment.eventManagementUrl}/event/$eventId/notification',
      headers: headers
    );
    final responseMap = json.decode(response.body);
    List<AppNotification> notifications = [];
    for (var n in responseMap) {
      notifications.add(AppNotification.fromMap(n));
      notifications.add(AppNotification.fromMap(n));
      notifications.add(AppNotification.fromMap(n));
      notifications.add(AppNotification.fromMap(n));
    }
    return notifications;
  }

  Future<int> getUnseenNotification(String eventId) async {
    final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
    final response = await _http.get(
      '${Environment.eventManagementUrl}/event/$eventId/notification?seen=false',
      headers: headers
    );

    final responseMap = json.decode(response.body);
    List<AppNotification> unseen = [];
    for (var n in responseMap) {
      unseen.add(AppNotification.fromMap(n));
    }
    return unseen.length;
  }

  Future<bool> sendSms(String eventId, String message) async {
    final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
    final body = {'text': message};
    final response = await _http.post(
      '${Environment.eventManagementUrl}/event/$eventId/sms',
      body: body,
      headers: headers
    );
    return response.statusCode == 200;
  }

  Future<bool> markNotificationAsSeen(String id) async {
    final headers = {
      'Authorization': 'Bearer ${_tokenService.accessToken}',
      'Content-type' : 'application/json',
      'Accept': 'application/json'
    };
    final body = json.encode({'notification': id, 'seen': true});

    final response = await _http.put(
      '${Environment.eventManagementUrl}/attendee/notification',
      body: body,
      headers: headers
    );
    return response.statusCode == 200;
  }
}