import 'package:flutter/material.dart';

class PopupSucesso extends StatelessWidget {
  final String mensagem;

  const PopupSucesso({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 24),
          SizedBox(width: 10),
          Text('Sucesso'),
        ],
      ),
      content: Text(mensagem),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o popup
            Navigator.of(context).pop(); // Volta para a tela anterior
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
