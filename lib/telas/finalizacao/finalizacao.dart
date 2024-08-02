import 'package:dev/main.dart';
import 'package:flutter/material.dart';

import '/telas/widgets_compartilhados/popup_sucesso.dart';

class TelaFinalizacao extends StatelessWidget {
  const TelaFinalizacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalização'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Confirmo que todas as informações prestadas são verdadeiras.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PopupSucesso(
                      mensagem: 'O imóvel foi registrado com sucesso.',
                      proxTela: HomeScreen(),
                    );
                  },
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
