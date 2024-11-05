import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../preferences/imoveis_preferences.dart';
import '../../form_models/imovel_model.dart';


class TelaFinalizacao extends ConsumerWidget {
  const TelaFinalizacao({super.key});
// Função para carregar o JSON existente
  Future<Map<String, dynamic>> carregarJsonImoveis() async {
    final String response = await rootBundle.loadString('assets/imoveis.json');
    return json.decode(response);
  }

// Função para adicionar um novo imóvel ao JSON
  Future<void> adicionarNovoImovel(WidgetRef ref) async {
// Carrega o JSON atual
    final jsonImoveis = await ImoveisPreferences.carregarJsonImoveis();
    final imovel = ref.watch(imovelProvider);

    // Adiciona um novo imóvel
    final novoImovel = {
      "titulo": imovel.endereco,
      "imagem": imovel.fotoSala,
      "isConcluido": false
    };

    jsonImoveis['imoveis'].add(novoImovel);

    // Salva o JSON atualizado
    await ImoveisPreferences.salvarJsonImoveis(jsonImoveis);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                print(ref.watch(imovelProvider).toString);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmação'),
                      content: Text('As alterações foram salvas com sucesso.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
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
