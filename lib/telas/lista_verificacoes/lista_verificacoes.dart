import 'package:dev/telas/finalizacao/finalizacao.dart';
import 'package:flutter/material.dart';

import '/telas/widgets_compartilhados/popup_sucesso.dart';

class ListaDeVerificacao extends StatefulWidget {
  const ListaDeVerificacao({super.key});

  @override
  State<ListaDeVerificacao> createState() => _ListaDeVerificacaoState();
}

class _ListaDeVerificacaoState extends State<ListaDeVerificacao> {
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> _verificacoes = {
    'Verificação de vazamentos': false,
    'Ausência de rachaduras ou trincas': false,
    'Piso em perfeito estado': false,
  };

  void _incluirNoImovel() {
    // adicionar à classe imovel futuramente
    Navigator.pop(context); // voltar para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Verificação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ..._verificacoes.keys.map((item) {
                return CheckboxListTile(
                  title: Text(item),
                  value: _verificacoes[item],
                  onChanged: (bool? value) {
                    setState(() {
                      _verificacoes[item] = value ?? false;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){_incluirNoImovel();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PopupSucesso(
                      mensagem: 'Informações adicionais enviadas.',
                      proxTela: TelaFinalizacao(),
                    );
                  },
                );
                  },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
