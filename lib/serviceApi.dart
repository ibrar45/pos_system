// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://baraj.alfpos.com/api/dashboardApi';
  // final String token;

  // ApiService({required this.token});
  Future<Map<String, dynamic>> dashboard_api(
      String token, DateTime startDate, DateTime endDate) async {
    final String apiUrl = 'https://$token.alfpos.com/api/dashboardApi';
    String formattedStartDate = startDate.toIso8601String().substring(0, 10);
    String formattedEndDate = endDate.toIso8601String().substring(0, 10);
    final url =
        '$apiUrl?start_date=$formattedStartDate&end_date=$formattedEndDate';
    print("StoreID:$token");

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Auth-Token': token,
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> login(String name) async {
    final String loginUrl = '$apiUrl/login';
    print("object:$name");
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }

  Future<void> sale_api(
      DateTime startDate, DateTime endDate, List<dynamic> items) async {
    String apiUrl =
        'https://baraj.alfpos.com/api/sale?start_date=$startDate&end_date=$endDate&limit=5';

    // Create headers with authorization token
    Map<String, String> headers = {
      'Accept': 'application/json', // Assuming JSON content
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      items.clear(); // Clear existing items
      var data = jsonDecode(response.body);
      items.addAll(data['data']['sale']);
      print("---------------------------my-${response.body}");
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}

////////////////sale_Api

