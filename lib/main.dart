import 'package:flutter/material.dart';
import 'telas/dados_imovel/dados_imovel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quanto vale APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quanto vale APP'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Inserir Detalhes do Imóvel'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormDadosImovel()),
            );
          },
        ),
      ),
    );
  }
}
