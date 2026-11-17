import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/umkm_model.dart';

class UmkmService {
  // Chrome (web)      : http://localhost:8080/api/
  // Emulator Android  : http://10.0.2.2:8080/api/
  // HP fisik          : http://IP-LAPTOP:8080/api/
  final String baseUrl = "http://localhost:8080/api/";

  // GET: ambil semua data
  Future<List<Umkm>> getUmkmList() async {
    final response = await http.get(Uri.parse('${baseUrl}umkm'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((e) => Umkm.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data UMKM");
    }
  }

  // POST: tambah data
  Future<Map<String, dynamic>> createUmkm(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('${baseUrl}umkm'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal menambah data: ${response.body}');
    }
  }

  // PUT: ubah data
  Future<Map<String, dynamic>> updateUmkm(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('${baseUrl}umkm/$id'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengubah data: ${response.body}');
    }
  }

  // DELETE: hapus data
  Future<Map<String, dynamic>> deleteUmkm(int id) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}umkm/$id'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal menghapus data: ${response.body}');
    }
  }
}
