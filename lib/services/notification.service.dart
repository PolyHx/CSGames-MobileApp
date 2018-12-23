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
    final response = await _http.get('${Environment.eventManagementUrl}/event/$eventId/notification',
      headers: headers);
    final responseMap = json.decode(response.body);
    return List.castFrom<dynamic, AppNotification>(responseMap.map((n) => AppNotification.fromMap(n))).toList();
  }

  Future<bool> sendSms(String eventId, String message) async {
    final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
    final body = {'text': message};
    final response = await _http.post('${Environment.eventManagementUrl}/event/$eventId/sms',
      body: body,
      headers: headers);
    return response.statusCode == 200;
  }
}