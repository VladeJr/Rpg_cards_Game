import 'package:flutter/material.dart';
import '../models/personagens.dart';
import '../services/personagem_service.dart';

class FormScreen extends StatefulWidget {
  final Character? character;

  FormScreen({this.character});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _raceController = TextEditingController();
  final _professionController = TextEditingController();
  final List<int> _selectedGroupIds = [];

  @override
  void initState() {
    super.initState();
    if (widget.character != null) {
      _nameController.text = widget.character!.name;
      _raceController.text = widget.character!.race;
      _professionController.text = widget.character!.profession;
      _selectedGroupIds.addAll(widget.character!.groupIds);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final character = Character(
        id: widget.character?.id ?? 0,
        name: _nameController.text,
        race: _raceController.text,
        profession: _professionController.text,
        groupIds: _selectedGroupIds,
      );

      try {
        if (widget.character == null) {
          await CharacterService().addCharacter(character);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Personagem adicionado com sucesso!')),
          );
        } else {
          await CharacterService().updateCharacter(character);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Personagem atualizado com sucesso!')),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar personagem: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character == null ? 'Adicionar Personagem' : 'Editar Personagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome do Personagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _raceController,
                decoration: InputDecoration(labelText: 'Raça'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma raça';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _professionController,
                decoration: InputDecoration(labelText: 'Profissão'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma profissão';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.character == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
