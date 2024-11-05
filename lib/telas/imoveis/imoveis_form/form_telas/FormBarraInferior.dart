import 'package:flutter/material.dart';

class FormBarraInferior extends StatelessWidget {
  final Widget proximaTela;
  final Widget telaImovel;
  final VoidCallback onSalvar;
  final VoidCallback onContinuar;

  const FormBarraInferior({
    Key? key,
    required this.proximaTela,
    required this.telaImovel,
    required this.onSalvar,
    required this.onContinuar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                onSalvar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Alterações foram salvas com sucesso.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => telaImovel),
                );
              },
              child: const Text('Salvar'),
            ),
            ElevatedButton(
              onPressed: () {
                onContinuar();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => proximaTela),
                );
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
