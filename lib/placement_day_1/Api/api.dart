import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:placement_daily_task/placement_day_1/Model/model.dart';



class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}