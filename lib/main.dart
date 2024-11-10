import 'package:flutter/material.dart';
import 'screens/pag_inicial.dart';
import 'screens/tela_lista.dart';
import 'screens/tela_forms.dart';
import 'screens/tela_de_rolagens.dart';
import 'screens/tela_de_grupo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App RPG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Correção aqui
            foregroundColor: Colors.white, // Correção aqui
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Correção aqui
          bodyMedium: TextStyle(fontSize: 16), // Correção aqui
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/list': (context) => ListScreen(),
        '/form': (context) => FormScreen(),
        '/dice_roll': (context) => DiceRollScreen(),
        '/groups': (context) => GroupListScreen(),
      },
    );
  }
}