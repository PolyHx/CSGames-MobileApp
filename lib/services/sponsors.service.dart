import 'dart:convert';

import 'package:PolyHxApp/domain/sponsors.dart';
import 'package:PolyHxApp/services/token.service.dart';
import 'package:http/http.dart';
import 'package:PolyHxApp/utils/environment.dart';

class SponsorsService {
  Client _http;
  TokenService _tokenService;

  SponsorsService(this._http, this._tokenService);

  Future<Map<String, List<Sponsors>>> getAllSponsors(String eventId) async {
    final response = await this._http.get('${Environment.eventManagementUrl}/event/$eventId/sponsor',
          headers: {'Authorization' : 'Bearer ${_tokenService.accessToken}'});
    final responseMap = json.decode(response.body);
    Map<String, List<Sponsors>> result = {};
    result['Petabytes'] = [];
    for (var s in responseMap['Petabytes']) {
      result['Petabytes'].add(Sponsors.fromMap(s));
    }
    result['Terabytes'] = [];
    for (var s in responseMap['Terabytes']) {
      result['Terabytes'].add(Sponsors.fromMap(s));
    }
    result['Gigabytes'] = [];
    for (var s in responseMap['Gigabytes']) {
      result['Gigabytes'].add(Sponsors.fromMap(s));
    }
    result['Megabytes'] = [];
    for (var s in responseMap['Megabytes']) {
      result['Megabytes'].add(Sponsors.fromMap(s));
    }
    return result;
  }
}