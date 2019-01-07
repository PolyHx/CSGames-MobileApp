import 'dart:convert';

import 'package:PolyHxApp/domain/notification.dart';
import 'package:PolyHxApp/utils/environment.dart';
import 'package:PolyHxApp/utils/http-client.dart';

class NotificationService {
  HttpClient _httpClient;

  NotificationService(this._httpClient);

  Future<List<AppNotification>> getNotificationsForEvent(String eventId) async {
    final response = await _httpClient.get(
      '${Environment.eventManagementUrl}/event/$eventId/notification'
    );
    final responseMap = json.decode(response.body);
    List<AppNotification> notifications = [];
    for (var n in responseMap) {
      notifications.add(AppNotification.fromMap(n));
    }
    return notifications;
  }

  Future<int> getUnseenNotification(String eventId) async {
    final response = await _httpClient.get(
      '${Environment.eventManagementUrl}/event/$eventId/notification?seen=false'
    );

    final responseMap = json.decode(response.body);
    List<AppNotification> unseen = [];
    for (var n in responseMap) {
      unseen.add(AppNotification.fromMap(n));
    }
    return unseen.length;
  }

  Future<bool> sendSms(String eventId, String message) async {
    final body = {'text': message};
    final response = await _httpClient.post(
      '${Environment.eventManagementUrl}/event/$eventId/sms',
      body: body
    );
    return response.statusCode == 201;
  }

  Future<bool> sendPushToEvent(String eventId, String title, String content) async {
    final body = {'title': title, 'body': content};
    final response = await _httpClient.post(
      '${Environment.eventManagementUrl}/event/$eventId/notification',
      body: body
    );
    return response.statusCode == 201;
  }

  Future<bool> sendPushToActivity(String activityId, String title, String content) async {
    final body = {'title': title, 'body': content};
    final response = await _httpClient.post(
      '${Environment.eventManagementUrl}/activity/$activityId/notification',
      body: body
    );
    return response.statusCode == 201;
  }

  Future<bool> markNotificationAsSeen(String id) async {
    final headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json'
    };
    final body = json.encode({'notification': id, 'seen': true});

    final response = await _httpClient.put(
      '${Environment.eventManagementUrl}/attendee/notification',
      body: body,
      headers: headers
    );
    return response.statusCode == 200;
  }
}