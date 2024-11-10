import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/personagens.dart';

class CharacterService {
  static const String baseUrl = 'http://localhost:3000';

  // Obter a lista de personagens
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/characters'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Character.fromJson(data)).toList();
    } else {
      throw Exception('Falha ao carregar personagens');
    }
  }

  // Adicionar um novo personagem
  Future<Character> addCharacter(Character character) async {
    final response = await http.post(
      Uri.parse('$baseUrl/characters'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(character.toJson()),
    );

    if (response.statusCode == 201) {
      return Character.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar personagem');
    }
  }

  // Atualizar um personagem existente
  Future<void> updateCharacter(Character character) async {
    final response = await http.put(
      Uri.parse('$baseUrl/characters/${character.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(character.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar personagem');
    }
  }

  // Excluir um personagem
  Future<void> deleteCharacter(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/characters/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir personagem');
    }
  }
}
