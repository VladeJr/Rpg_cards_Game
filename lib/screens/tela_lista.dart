import 'package:flutter/material.dart';
import '../models/personagens.dart';
import '../services/personagem_service.dart';
import 'tela_personagens.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Character>> futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = CharacterService().fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade400,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Personagens',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Character>>(
                    future: futureCharacters,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}', style: TextStyle(color: Colors.white)));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final character = snapshot.data![index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 4,
                              child: ListTile(
                                title: Text(character.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('Profissão: ${character.profession}'),
                                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CharacterDetailScreen(character: character),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('Nenhum personagem encontrado', style: TextStyle(color: Colors.white)));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}