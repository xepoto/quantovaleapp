import 'dart:html' as html;
import 'package:flutter/material.dart';

Future<void> downloadFile(BuildContext context, List<int> bytes) async {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "LAUDO DE AVALIAÇÃO SIMPLIFICADO.pdf")
    ..click();
  html.Url.revokeObjectUrl(url);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Download iniciado no navegador.")),
  );
}
