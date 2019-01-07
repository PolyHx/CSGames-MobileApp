import 'dart:async';
import 'dart:convert';
import 'package:PolyHxApp/utils/http-client.dart';
import 'package:PolyHxApp/domain/attendee.dart';
import 'package:PolyHxApp/utils//environment.dart';

class AttendeesService {
  HttpClient _httpClient;

  AttendeesService(this._httpClient);

  Future<Attendee> getAttendeeByUserId(String userId) async {
    try {
      final response = await _httpClient.get("${Environment.eventManagementUrl}/attendee/user/$userId");
      var responseMap = json.decode(response.body);
      var attendee = Attendee.fromMap(responseMap["attendee"]);
      return attendee;
    }
    catch (e) {
      print('AttendeesService.getAttendeeByUserId(): $e');
      return null;
    }
  }

  Future<Attendee> getAttendeeByPublicId(String publicId) async {
    try {
      final response = await _httpClient.get("${Environment.eventManagementUrl}/attendee/$publicId");
      var responseMap = json.decode(response.body);
      var attendee = Attendee.fromMap(responseMap["attendee"]);
      return attendee;
    }
    catch (e) {
      print('AttendeesService.getAttendeeByPublicId(): $e');
      return null;
    }
  }

  Future<bool> updateAttendeePublicId(Attendee attendee) async {
    try {
      final response = await _httpClient.put(
          "${Environment.eventManagementUrl}/attendee/${attendee.id}/public_id/${attendee.publicId}");
      return response.statusCode == 200;
    }
    catch (e) {
      print('AttendeesService.updateAttendeePublicId(): $e');
      return false;
    }
  }

  Future<bool> setFcmToken(String token) async {
    final body = {'token': token};
    final response = await _httpClient.put('${Environment.eventManagementUrl}/attendee/token',
      body: body);
    return response.statusCode == 200;
  }

  Future<bool> removeFcmToken(String token) async {
    final response = await _httpClient.delete('${Environment.eventManagementUrl}/attendee/token/$token');
    return response.statusCode == 200;
  }
}