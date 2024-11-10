import 'package:flutter_test/flutter_test.dart';
import '../lib/models/grupo.dart';
import '../lib/models/eventos.dart';

void main() {
  test('Deve adicionar um evento ao grupo', () {
    final group = Group(id: 1, name: 'Grupo A', description: 'Descrição do grupo', messages: [], events: []);
    final event = Event(title: 'Encontro', description: 'Primeiro encontro do grupo', date: DateTime.now());

    group.events.add(event);
    
    expect(group.events.length, 1);
    expect(group.events[0].title, 'Encontro');
  });
}
