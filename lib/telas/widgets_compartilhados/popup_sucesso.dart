import 'package:flutter/material.dart';

class PopupSucesso extends StatelessWidget {
  final Widget? proxTela;
  final String mensagem;

  const PopupSucesso({super.key, required this.mensagem, this.proxTela});

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
            Navigator.of(context).pop(); // fecha o popup
            if (proxTela != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => proxTela!),
              ); // vai para a próxima tela se proxTela não for nulo
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
