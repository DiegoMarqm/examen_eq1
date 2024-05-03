import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '🐝 Colmena 🐝'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  List<String> _tablero = ['Reina','Zangano','Zangano','Zangano','Zangano','Zangano','Zangano','Zangano','Zangano',
    'Obrero','Obrero','Obrero','Obrero','Obrero','Obrero','Obrero','Obrero','Larva','Larva','Larva','Larva','Larva',
    'Larva','Larva','Larva'
  ];



  int _vidas = 7;
  List<bool> _revelarCartas = List.generate(25, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          const Text('Vidas Restantes : ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)
          ),
          Text('$_vidas ❤️‍🩹',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red)
          ),
        ],
      ),
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (rowIndex) {
              return Row(
                children: List.generate(5, (columnIndex) {
                  final index = rowIndex * 5 + columnIndex;
                  return GestureDetector(
                    onTap: () {
                      _handleTap(index);

                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(5),
                      color: _revelarCartas[index]? Colors.amber : Colors.black54,
                      child: Center(
                        child: _revelarCartas[index]
                            ? Text(_tablero[index])
                            : Text(''),

                      ),

                    ),
                  );
                }),
              );
            }),
          ),
        ),




    );
  }

  void _handleTap(int index) {
    if (_revelarCartas[index]) return;
    setState(() {
      _revelarCartas[index] = true;

    });
    _actualizarVidas(_tablero[index]);
  }

  void _actualizarVidas(String pieza) {
    switch (pieza) {
      case 'Larva':
        break;
      case 'Obrero':
        _vidas -= 1;
        break;
      case 'Zangano':
        _vidas -= 2;
        break;
      case 'Reina':
        //_showGameOverDialog();
        _mostrarMensajeGanador();
        break;
    }
    if (_vidas <= 0) {
      _mensajeDeDerrota();
    }
  }

  void _mostrarMensajeGanador() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Felicidades'),
          content: Text('Has encontrado a la Reina 🐝👑!'),
          actions: [
            TextButton(
              child: Text('Jugar de Nuevo'),
              onPressed: () {
                setState(() {
                  _vidas = 7;
                  _revelarCartas = List.generate(25, (index) => false);
                  _tablero.shuffle();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  void _mensajeDeDerrota() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Perdiste ☠️'),
          content: Text('Has perdido todas tus vidas 😔😭'),
          actions: [
            TextButton(
              child: Text('Jugar de nuevo'),
              onPressed: () {
                setState(() {
                  _vidas = 7;
                  _revelarCartas = List.generate(25, (index) => false);
                  _tablero.shuffle();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}