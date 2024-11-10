import 'mensagem.dart';
import 'eventos.dart';

class Group {
  final int id;
  final String name;
  final String description;
  final List<Message> messages;
  final List<Event> events; // Lista de eventos do grupo

  Group({
    required this.id,
    required this.name,
    required this.description,
    required this.messages,
    required this.events,
  });

  // Converter o Group para um formato JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'messages': messages.map((msg) => msg.toJson()).toList(),
      'events': events.map((event) => event.toJson()).toList(),
    };
  }

  // Criar um Group a partir de um JSON
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      description: json['description'],
      messages: (json['messages'] as List<dynamic>?)
          ?.map((msg) => Message.fromJson(msg))
          .toList() ??
          [],
      events: (json['events'] as List<dynamic>?)
          ?.map((event) => Event.fromJson(event))
          .toList() ??
          [], // Inicializa como lista vazia se 'events' for null
    );
  }
}
