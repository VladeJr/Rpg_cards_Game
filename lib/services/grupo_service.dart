import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/grupo.dart';
import '../models/mensagem.dart';
import '../models/eventos.dart';

class GroupService {
  static const String baseUrl = 'http://localhost:3000';

  // Método para buscar todos os grupos
  Future<List<Group>> fetchGroups() async {
    final response = await http.get(Uri.parse('$baseUrl/groups'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Group.fromJson(data)).toList();
    } else {
      throw Exception('Falha ao carregar grupos');
    }
  }

  // Método para adicionar um novo grupo
  Future<Group> addGroup(Group group) async {
    final response = await http.post(
      Uri.parse('$baseUrl/groups'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(group.toJson()),
    );

    if (response.statusCode == 201) {
      return Group.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar grupo');
    }
  }

  // Método para enviar uma nova mensagem em um grupo
  Future<void> sendMessage(int groupId, Message message) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/groups/$groupId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'messages': [message.toJson()]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao enviar mensagem');
    }
  }

  // Método para adicionar um evento a um grupo
  Future<void> addEvent(int groupId, Event event) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/groups/$groupId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'events': [event.toJson()]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar evento');
    }
  }
}
