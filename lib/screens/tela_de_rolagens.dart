import 'package:flutter/material.dart';
import 'dart:math';

class DiceRollScreen extends StatefulWidget {
  @override
  _DiceRollScreenState createState() => _DiceRollScreenState();
}

class _DiceRollScreenState extends State<DiceRollScreen> {
  final Random _random = Random();
  int _currentRoll = 0;
  int _diceSides = 6;

  void _rollDice() {
    setState(() {
      _currentRoll = _random.nextInt(_diceSides) + 1;
    });
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rolagem de Dados',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<int>(
                          value: _diceSides,
                          items: <int>[4, 6, 8, 10, 12, 20].map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('D$value'),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _diceSides = newValue!;
                              _currentRoll = 0;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Resultado: $_currentRoll',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _rollDice,
                          child: Text('Rolar Dado'),
                        ),
                      ],
                    ),
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