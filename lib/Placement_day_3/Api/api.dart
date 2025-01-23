import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:placement_daily_task/Placement_day_3/model/model.dart';


class ApiService {
  static const String apiUrl = "https://api.escuelajs.co/api/v1/users";

  Future<List<Usermodel>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return usermodelFromJson(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }
}
