import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '';
import '../../helpers/download_helper_mobile.dart';

class BotaoDownloadLaudo extends StatelessWidget {
  final String assetPath;

  const BotaoDownloadLaudo({Key? key, required this.assetPath})
      : super(key: key);

  Future<File> _savePdfLocally(BuildContext context) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final List<int> bytes = data.buffer.asUint8List();

      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = '${directory.path}/temp_pdf.pdf';
      final File file = File(path);

      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar o laudo: $e")),
      );
      rethrow;
    }
  }

  Future<void> _downloadLaudo(BuildContext context) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final List<int> bytes = data.buffer.asUint8List();
      await downloadFile(context, bytes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao baixar o laudo: $e")),
      );
    }
  }

  Future<void> _openPdf(BuildContext context) async {
    try {
      final File file = await _savePdfLocally(context);
      final result = await OpenFilex.open(file.path);

      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao abrir o PDF: ${result.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao abrir o laudo: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
/*        ElevatedButton(
          onPressed: () => _downloadLaudo(context),
          child: Text('Baixar laudo'),
        ),*/
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            //_downloadLaudo(context);
            _openPdf(context);
          },
          child: Text('Abrir laudo'),
        ),
      ],
    );
  }
}
