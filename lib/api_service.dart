// lib/api_service.dart
import 'dart:convert'; // Untuk fungsi jsonDecode
import 'package:http/http.dart' as http; // Import package http
import 'user_model.dart'; // Import model User

class ApiService {
  final String baseUrl = "https://reqres.in/api";

  // READ (GET): Mengambil daftar pengguna dari API
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=2'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan status code 200 OK, parse JSON.
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> userListJson = data['data'];

      // Ubah setiap item JSON menjadi objek User
      return userListJson.map((json) => User.fromJson(json)).toList();
    } else {
      // Jika respon bukan 200 OK, lempar exception.
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  // Method lain (create, update, delete) akan ditambahkan di sini
  // CREATE (POST): Membuat user baru
  Future<Map<String, dynamic>> createUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': name, 'job': job}),
    );

    if (response.statusCode == 201) {
      // 201 Created
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  // UPDATE (PUT): Memperbarui user berdasarkan ID
  Future<Map<String, dynamic>> updateUser(
    String id,
    String name,
    String job,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'name': name, 'job': job}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  // DELETE: Menghapus user berdasarkan ID
  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }
}
