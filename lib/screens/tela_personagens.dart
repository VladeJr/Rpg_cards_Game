import 'package:flutter/material.dart';
import '../models/personagens.dart';
import '../services/personagem_service.dart';
import 'tela_forms.dart'; // Import para o formulário

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  CharacterDetailScreen({required this.character});

  void _deleteCharacter(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir este personagem?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirm) {
      try {
        await CharacterService().deleteCharacter(character.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Personagem excluído com sucesso')),
        );
        Navigator.pop(context); // Voltar para a tela de listagem
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir personagem: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormScreen(character: character),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteCharacter(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Raça: ${character.race}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Profissão: ${character.profession}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Grupos:', style: TextStyle(fontSize: 18)),
            for (var groupId in character.groupIds)
              Text('- Grupo ID: $groupId', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
