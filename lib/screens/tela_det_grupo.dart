import 'package:flutter/material.dart';
import '../models/grupo.dart';
import '../models/mensagem.dart';
import '../models/eventos.dart';
import '../services/grupo_service.dart';

class GroupDetailScreen extends StatefulWidget {
  final Group group;

  GroupDetailScreen({required this.group});

  @override
  _GroupDetailScreenState createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final GroupService _groupService = GroupService();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final message = Message(
        content: _messageController.text,
        sender: 'Usuário', // Pode ser ajustado para o nome real do usuário
        timestamp: DateTime.now(),
      );

      try {
        await _groupService.sendMessage(widget.group.id, message);
        setState(() {
          widget.group.messages.add(message);
        });
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mensagem enviada com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar mensagem: $e')),
        );
      }
    }
  }

  void _addEvent() async {
    if (_eventTitleController.text.isNotEmpty && _selectedDate != null) {
      final event = Event(
        title: _eventTitleController.text,
        description: _eventDescriptionController.text,
        date: _selectedDate!,
      );

      try {
        await _groupService.addEvent(widget.group.id, event);
        setState(() {
          widget.group.events.add(event);
        });
        _eventTitleController.clear();
        _eventDescriptionController.clear();
        _selectedDate = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Evento adicionado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar evento: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                // Exibir mensagens
                Text('Mensagens', style: Theme.of(context).textTheme.titleLarge), // Correção aplicada
                ...widget.group.messages.map((message) => Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(message.content),
                        subtitle: Text(
                          '${message.sender} - ${message.timestamp.hour}:${message.timestamp.minute}',
                        ),
                      ),
                    )),

                // Exibir eventos
                Divider(),
                Text('Eventos', style: Theme.of(context).textTheme.titleLarge), // Correção aplicada
                ...widget.group.events.map((event) => Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(event.title),
                        subtitle: Text(
                          '${event.description} - ${event.date.toLocal()}',
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Divider(),

          // Entrada para mensagem
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          Divider(),

          // Formulário para adicionar eventos
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _eventTitleController,
                  decoration: InputDecoration(
                    labelText: 'Título do Evento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _eventDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrição do Evento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    _selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    setState(() {}); // Atualiza o estado para mostrar a data selecionada
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null
                      ? 'Selecionar Data'
                      : 'Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _addEvent,
                  icon: Icon(Icons.event),
                  label: Text('Adicionar Evento'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}