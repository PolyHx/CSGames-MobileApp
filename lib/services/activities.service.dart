import 'dart:convert';

import 'package:PolyHxApp/domain/activity.dart';
import 'package:PolyHxApp/services/token.service.dart';
import 'package:PolyHxApp/utils/environment.dart';
import 'package:http/http.dart';

class ActivitiesService {
  Client _http;
  TokenService _tokenService;

  ActivitiesService(this._http, this._tokenService);

  Future<bool> addSubscriptionToActivity(String attendeeId, String activityId) async {
    try {
      final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
      final response = await _http.put('${Environment.eventManagementUrl}/activity/$activityId/subscription/$attendeeId',
        headers: headers);
      return response.statusCode == 200;
    } catch(err) {
      print('AttendeesService.addSubscriptionToActivity(): $err');
      return false;
    }
  }

  Future<bool> verifyAttendeeSubscription(String attendeeId, String activityId) async {
    try {
      final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
      final response = await _http.get('${Environment.eventManagementUrl}/activity/$activityId/subscription/$attendeeId',
        headers: headers);
      final responseMap = json.decode(response.body);
      return responseMap['isSubscribed'] ?? false;
    } catch(err) {
      print('AttendeesService.addSubscriptionToActivity(): $err');
      return false;
    }
  }

  Future<Activity> addAttendeeToActivity(String attendeeId, String activityId) async {
    try {
      final headers = {'Authorization': 'Bearer ${_tokenService.accessToken}'};
      final response = await _http.put('${Environment.eventManagementUrl}/activity/$activityId/$attendeeId/add',
          headers: headers);
      final responseMap = json.decode(response.body);
      return Activity.fromMap(responseMap);
    }
    catch (e) {
      print('AttendeesService.addAttendeeToActivity(): $e');
      return null;
    }
  }
}