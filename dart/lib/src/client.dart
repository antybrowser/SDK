import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'exceptions.dart';

class AntybrowserClient {
  final String apiKey;
  final String baseUrl;
  final http.Client _httpClient;

  AntybrowserClient({
    required this.apiKey,
    this.baseUrl = 'http://127.0.0.1:5173',
  }) : _httpClient = http.Client();

  Map<String, String> get _headers => {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      };

  // System

  Future<Map<String, dynamic>> getStatus() async {
    return _get('/api/status');
  }

  Future<Map<String, dynamic>> getSettings() async {
    return _get('/api/settings');
  }

  Future<Map<String, dynamic>> getSyncStatus() async {
    return _get('/api/sync/status');
  }

  Future<Map<String, dynamic>> refreshSync({String? profileId}) async {
    return _post('/api/sync/refresh', profileId != null ? {'profileId': profileId} : null);
  }

  // Profiles

  Future<List<Profile>> getProfiles() async {
    final data = await _get('/api/profiles');
    return (data['data'] as List).map((p) => Profile.fromJson(p)).toList();
  }

  Future<Profile> createProfile(CreateProfileRequest request) async {
    final data = await _post('/api/profiles', request.toJson());
    return Profile.fromJson(data['data']);
  }

  Future<Profile> updateProfile(int id, Map<String, dynamic> fields) async {
    final data = await _put('/api/profiles/$id', fields);
    return Profile.fromJson(data['data']);
  }

  Future<void> deleteProfile(int id) async {
    await _delete('/api/profiles/$id');
  }

  Future<Map<String, dynamic>> startProfile(int id) async {
    return _post('/api/profiles/$id/start', null);
  }

  Future<Map<String, dynamic>> stopProfile(int id) async {
    return _post('/api/profiles/$id/stop', null);
  }

  Future<Profile> duplicateProfile(int id, {String? name}) async {
    final data = await _post('/api/profiles/$id/duplicate', name != null ? {'name': name} : null);
    return Profile.fromJson(data['data']);
  }

  // Automations

  Future<List<Automation>> getAutomations() async {
    final data = await _get('/api/automations');
    return (data['data'] as List).map((a) => Automation.fromJson(a)).toList();
  }

  Future<Map<String, dynamic>> runAutomation(int automationId, int profileId) async {
    return _post('/api/automations/$automationId/run', {'profileId': profileId});
  }

  // Groups

  Future<List<Group>> getGroups() async {
    final data = await _get('/api/groups');
    return (data['data'] as List).map((g) => Group.fromJson(g)).toList();
  }

  Future<Group> createGroup(CreateGroupRequest request) async {
    final data = await _post('/api/groups', request.toJson());
    return Group.fromJson(data['data']);
  }

  Future<Group> updateGroup(int id, Map<String, dynamic> fields) async {
    final data = await _put('/api/groups/$id', fields);
    return Group.fromJson(data['data']);
  }

  Future<void> deleteGroup(int id) async {
    await _delete('/api/groups/$id');
  }

  // Proxies

  Future<List<Proxy>> getProxies() async {
    final data = await _get('/api/proxies');
    return (data['data'] as List).map((p) => Proxy.fromJson(p)).toList();
  }

  Future<Proxy> createProxy(CreateProxyRequest request) async {
    final data = await _post('/api/proxies', request.toJson());
    return Proxy.fromJson(data['data']);
  }

  Future<Map<String, dynamic>> checkProxy(Map<String, dynamic> proxyData) async {
    return _post('/api/proxies/check', proxyData);
  }

  Future<void> deleteProxy(int id) async {
    await _delete('/api/proxies/$id');
  }

  // Extensions

  Future<List<Extension>> getExtensions() async {
    final data = await _get('/api/extensions');
    return (data['data'] as List).map((e) => Extension.fromJson(e)).toList();
  }

  Future<void> deleteExtension(int id) async {
    await _delete('/api/extensions/$id');
  }

  Future<List<Extension>> getProfileExtensions(int profileId) async {
    final data = await _get('/api/profiles/$profileId/extensions');
    return (data['data'] as List).map((e) => Extension.fromJson(e)).toList();
  }

  Future<void> setProfileExtensions(int profileId, List<int> extensionIds) async {
    await _post('/api/profiles/$profileId/extensions', {'extensionIds': extensionIds});
  }

  // HTTP helpers

  Future<Map<String, dynamic>> _get(String path) async {
    final response = await _httpClient.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _post(String path, dynamic body) async {
    final response = await _httpClient.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _put(String path, dynamic body) async {
    final response = await _httpClient.put(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> _delete(String path) async {
    final response = await _httpClient.delete(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 400) {
      throw AntybrowserException(
        'API request failed with status ${response.statusCode}',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
    return jsonDecode(response.body);
  }

  void dispose() {
    _httpClient.close();
  }
}
