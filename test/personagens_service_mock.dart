import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('CharacterService', () {
    test('Deve retornar uma lista de personagens filtrada por profissão', () async {
      final client = MockClient();

      // Simulação de resposta da API com personagens
      when(client.get(Uri.parse('https://exemplo.com/characters')))
          .thenAnswer((_) async => http.Response(jsonEncode([
                {'name': 'Archer', 'profession': 'Arqueiro'},
                {'name': 'Mage', 'profession': 'Mago'}
              ]), 200));

      var service;
      final characters = await service.fetchCharacters();

      // Filtrando por profissão
      final filtered = characters.where((c) => c.profession == 'Arqueiro').toList();

      expect(filtered.length, 1);
      expect(filtered[0].name, 'Archer');
    });
  });
}
