import 'dart:convert';

import 'package:PolyHxApp/domain/sponsors.dart';
import 'package:PolyHxApp/utils/http-client.dart';
import 'package:PolyHxApp/utils/environment.dart';

class SponsorsService {
  HttpClient _httpClient;

  SponsorsService(this._httpClient);

  Future<Map<String, List<Sponsors>>> getAllSponsors(String eventId) async {
    final response = await this._httpClient.get('${Environment.eventManagementUrl}/event/$eventId/sponsor');
    final responseMap = json.decode(response.body);
    Map<String, List<Sponsors>> result = {};
    if (responseMap.containsKey('Petabytes')) {
      result['Petabytes'] = [];
      for (var s in responseMap['Petabytes']) {
        result['Petabytes'].add(Sponsors.fromMap(s));
      }
    }
    
    if(responseMap.containsKey('Terabytes')) {
      result['Terabytes'] = [];
      for (var s in responseMap['Terabytes']) {
        result['Terabytes'].add(Sponsors.fromMap(s));
      }
    }

    if(responseMap.containsKey('Gigabytes')) {
      result['Gigabytes'] = [];
      for (var s in responseMap['Gigabytes']) {
        result['Gigabytes'].add(Sponsors.fromMap(s));
      }
    }

    if (responseMap.containsKey('Megabytes')) {
      result['Megabytes'] = [];
      for (var s in responseMap['Megabytes']) {
        result['Megabytes'].add(Sponsors.fromMap(s));
      }
    }
    
    return result;
  }
}