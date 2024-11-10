import 'package:flutter_test/flutter_test.dart';
import '../lib/models/personagens.dart';

void main() {
  test('Deve criar um personagem válido', () {
    final character = Character(name: 'Leon S. Kennedy', profession: 'Super Soldier', groupIds: [], race: '', id: 0);
    
    expect(character.name, 'Leon S. Kennedy');
    expect(character.profession, 'Super Soldier');
  });
}
