import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quanto_vale_APP/telas/imoveis/tela_detalhes_imovel.dart';

import '../../../../../modelos/imovel_model.dart';
import '../FormBarraInferior.dart';


class TelaListaDeVerificacao extends ConsumerStatefulWidget {
  final ImovelModel imovel;
  const TelaListaDeVerificacao({super.key, required this.imovel});

  @override
  _TelaListaDeVerificacaoState createState() => _TelaListaDeVerificacaoState();
}

class _TelaListaDeVerificacaoState extends ConsumerState<TelaListaDeVerificacao> {
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> _verificacoes = {
    'Verificação de vazamentos': false,
    'Ausência de rachaduras ou trincas': false,
    'Piso em perfeito estado': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Spacer(),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alterações foram salvas com sucesso.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => TelaDetalhesImovel(idImovel: widget.imovel.id)),
                  );
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
