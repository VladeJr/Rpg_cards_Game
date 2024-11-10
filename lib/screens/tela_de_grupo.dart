import 'package:flutter/material.dart';
import '../models/grupo.dart';
import '../services/grupo_service.dart';
import 'tela_det_grupo.dart';

class GroupListScreen extends StatefulWidget {
  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  late Future<List<Group>> futureGroups;

  @override
  void initState() {
    super.initState();
    futureGroups = GroupService().fetchGroups();
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
                    'Comunidade de Grupos',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Group>>(
                    future: futureGroups,
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
                            final group = snapshot.data![index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 4,
                              child: ListTile(
                                title: Text(group.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(group.description),
                                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GroupDetailScreen(group: group),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('Nenhum grupo encontrado', style: TextStyle(color: Colors.white)));
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