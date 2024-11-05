import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helpers/download_helper.dart';

class BotaoDownloadLaudo extends StatelessWidget {
  const BotaoDownloadLaudo({Key? key}) : super(key: key);

  Future<void> _downloadLaudo(BuildContext context) async {
    try {
      final ByteData data = await rootBundle.load('assets/LAUDO DE AVALIAÇÃO SIMPLIFICADO.pdf');
      final List<int> bytes = data.buffer.asUint8List();
      await downloadFile(context, bytes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao baixar o laudo: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _downloadLaudo(context),
      child: Text('Baixar laudo'),
    );
  }
}
