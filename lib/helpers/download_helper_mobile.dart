import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadFile(BuildContext context, List<int> bytes) async {
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Permissão de armazenamento negada.")),
    );
    return;
  }

  final Directory? downloadsDir = Directory('/storage/emulated/0/Download');
  if (downloadsDir == null || !await downloadsDir.exists()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Falha ao acessar diretório de downloads.")),
    );
    return;
  }

  final String path = '${downloadsDir.path}/LAUDO DE AVALIAÇÃO SIMPLIFICADO.pdf';
  final File file = File(path);

  await file.writeAsBytes(bytes);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Arquivo baixado em $path")),
  );
}
