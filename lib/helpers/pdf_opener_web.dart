import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<void> openPdf(BuildContext context, String assetPath) async {
  try {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "documento.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Download do PDF iniciado no navegador.")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erro ao baixar o laudo: $e")),
    );
  }
}
