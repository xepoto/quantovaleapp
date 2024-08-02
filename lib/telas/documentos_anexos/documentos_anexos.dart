import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../fotos_videos/fotos_videos.dart';

import '/telas/widgets_compartilhados/popup_sucesso.dart';


class TelaDocumentosAnexos extends StatefulWidget {
  const TelaDocumentosAnexos({super.key});

  @override
  State<TelaDocumentosAnexos> createState() => _TelaDocumentosAnexosState();
}

class _TelaDocumentosAnexosState extends State<TelaDocumentosAnexos> {
  List<PlatformFile> arquivosEscritura = [];
  List<PlatformFile> arquivosRegistro = [];

  Future<void> selecionarArquivo(List<PlatformFile> listaArquivos) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        listaArquivos.add(result.files.single);
      });
    } else {
      // cancelou a seleção
    }
  }

  void removerArquivo(List<PlatformFile> listaArquivos, PlatformFile arquivo) {
    setState(() {
      listaArquivos.remove(arquivo);
    });
  }

  Future<void> enviarArquivos() async {
    // apenas simulação, sem upload real
    await Future.delayed(const Duration(seconds: 1));
    print('Arquivos enviados');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos Anexos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enviar Escritura:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => selecionarArquivo(arquivosEscritura),
              child: const Text('Selecionar Arquivo'),
            ),
            ...arquivosEscritura.map((arquivo) {
              return ListTile(
                title: Text(arquivo.name),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => removerArquivo(arquivosEscritura, arquivo),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text('Enviar Registro:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => selecionarArquivo(arquivosRegistro),
              child: const Text('Selecionar Arquivo'),
            ),
            ...arquivosRegistro.map((arquivo) {
              return ListTile(
                title: Text(arquivo.name),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => removerArquivo(arquivosRegistro, arquivo),
                ),
              );
            }),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (arquivosEscritura.isNotEmpty || arquivosRegistro.isNotEmpty) {
                    await enviarArquivos();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const PopupSucesso(
                          mensagem: 'Arquivos enviados com sucesso.',
                          proxTela: TelaFotosVideos(),
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const PopupSucesso(
                          mensagem: 'Nenhum arquivo foi selecionado.',
                        );
                      },
                    );
                  }
                },
                child: const Text('Enviar Arquivos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
