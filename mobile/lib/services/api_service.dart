import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/semijoia.dart';

class ApiService {
  // Troque para http://10.0.2.2:8080 no emulador Android
  static const String baseUrl = 'http://localhost:8080/api/semijoias';

  Future<List<SemiJoia>> listar() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;
      return data.map((e) => SemiJoia.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Erro ao listar: ${res.statusCode}');
  }

  Future<SemiJoia> criar(SemiJoia s) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(s.toJson()),
    );
    if (res.statusCode == 201) {
      return SemiJoia.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    }
    throw Exception('Erro ao criar: ${res.statusCode}');
  }

  Future<SemiJoia> atualizar(int id, SemiJoia s) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(s.toJson()),
    );
    if (res.statusCode == 200) {
      return SemiJoia.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    }
    throw Exception('Erro ao atualizar: ${res.statusCode}');
  }

  Future<void> deletar(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 204) {
      throw Exception('Erro ao deletar: ${res.statusCode}');
    }
  }
}