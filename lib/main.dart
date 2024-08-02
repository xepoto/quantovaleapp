import 'package:flutter/material.dart';

import 'telas/dados_imovel/dados_imovel.dart';
import 'telas/documentos_anexos/documentos_anexos.dart';
import 'telas/fotos_videos/fotos_videos.dart';
import 'telas/lista_verificacoes/lista_verificacoes.dart';
import 'telas/finalizacao/finalizacao.dart';

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(200,82, 102, 117),
              ),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Inserir Detalhes do Imóvel'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaDadosImovel()),
                );
              },
            ),
            ListTile(
              title: const Text('Documentos Anexos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaDocumentosAnexos()),
                );
              },
            ),
            ListTile(
              title: const Text('Fotos e vídeos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaFotosVideos()),
                );
              },
            ),
            ListTile(
              title: const Text('Lista de Verificações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListaDeVerificacao()),
                );
              },
            ),
            ListTile(
              title: const Text('Finalização'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaFinalizacao()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 250, child: Image.asset('assets/logo.png')),
            const Text(
              'Bem-vindo ao Quanto vale APP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Text(
                'Acesse o menu lateral para iniciar o cadastro.',
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
