import 'package:flutter/material.dart';
import '../../helpers/pdf_opener.dart';


class BotaoAbrirLaudo extends StatelessWidget {
  final String assetPath;

  const BotaoAbrirLaudo({Key? key, required this.assetPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => openPdf(context, assetPath),
      child: Text('Abrir laudo'),
    );
  }
}
