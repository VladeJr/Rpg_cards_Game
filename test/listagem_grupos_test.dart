import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/screens/tela_de_grupo.dart';
import '../lib/models/grupo.dart';

void main() {
  testWidgets('Deve exibir a lista de grupos com nomes', (WidgetTester tester) async {
    final groups = [
      Group(id: 1, name: 'Grupo A', description: 'Primeiro grupo', messages: [], events: []),
      Group(id: 2, name: 'Grupo B', description: 'Segundo grupo', messages: [], events: []),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: GroupListScreen(groups: groups),
      ),
    );

    // Verifica se os nomes dos grupos estão sendo exibidos
    expect(find.text('Grupo A'), findsOneWidget);
    expect(find.text('Grupo B'), findsOneWidget);
  });
}
