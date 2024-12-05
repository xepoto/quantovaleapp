import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter/material.dart';

Future<void> openPdf(BuildContext context, String assetPath) async {
  try {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/temp_pdf.pdf';
    final File file = File(path);

    await file.writeAsBytes(bytes);
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
