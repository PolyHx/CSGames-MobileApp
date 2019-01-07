import 'dart:convert';

import 'package:PolyHxApp/domain/activity.dart';
import 'package:PolyHxApp/utils/environment.dart';
import 'package:PolyHxApp/utils/http-client.dart';

class ActivitiesService {
  HttpClient _httpClient;

  ActivitiesService(this._httpClient);

  Future<bool> addSubscriptionToActivity(String attendeeId, String activityId) async {
    try {
      final response = await _httpClient.put('${Environment.eventManagementUrl}/activity/$activityId/$attendeeId/subscription');
      return response.statusCode == 200;
    } catch(err) {
      print('AttendeesService.addSubscriptionToActivity(): $err');
      return false;
    }
  }

  Future<bool> verifyAttendeeSubscription(String attendeeId, String activityId) async {
    try {
      final response = await _httpClient.get('${Environment.eventManagementUrl}/activity/$activityId/$attendeeId/subscription');
      return response.statusCode == 200;
    } catch(err) {
      print('AttendeesService.addSubscriptionToActivity(): $err');
      return false;
    }
  }

  Future<Activity> addAttendeeToActivity(String attendeeId, String activityId) async {
    try {
      final response = await _httpClient.put('${Environment.eventManagementUrl}/activity/$activityId/$attendeeId/add');
      final responseMap = json.decode(response.body);
      return Activity.fromMap(responseMap);
    }
    catch (e) {
      print('AttendeesService.addAttendeeToActivity(): $e');
      return null;
    }
  }
}