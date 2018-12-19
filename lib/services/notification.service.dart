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
    return [
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      ),
      AppNotification(
        id: '123',
        title: 'test',
        date: DateTime.now()
      )
    ];
    // final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
    // final response = await _http.get('${Environment.eventManagementUrl}/notification/$eventId',
    //   headers: headers);
    // final responseMap = json.decode(response.body);
    // return List.castFrom<dynamic, AppNotification>(responseMap.map((n) => AppNotification.fromMap(n))).toList();
  }
}