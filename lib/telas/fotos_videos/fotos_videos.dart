import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // Necessário para usar File

import '/telas/widgets_compartilhados/popup_sucesso.dart';
import '../lista_verificacoes/lista_verificacoes.dart';

class TelaFotosVideos extends StatefulWidget {
  const TelaFotosVideos({super.key});

  @override
  State<TelaFotosVideos> createState() => _TelaFotosVideosState();
}

class _TelaFotosVideosState extends State<TelaFotosVideos> {
  Map<String, List<PlatformFile>> arquivosPorSessao = {
    'Cozinha': [],
    'Banheiro social': [],
    'Sala': [],
  };

  Future<void> selecionarArquivo(String sessao) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        arquivosPorSessao[sessao]?.addAll(result.files);
      });
    } else {
      // cancelou a seleção
    }
  }

  void removerArquivo(String sessao, PlatformFile arquivo) {
    setState(() {
      arquivosPorSessao[sessao]?.remove(arquivo);
    });
  }

  Future<void> enviarArquivos() async {
    // apenas simulação, sem upload real
    await Future.delayed(const Duration(seconds: 1));
    print('Arquivos enviados');
  }

  void abrirFotoEmTelaCheia(String path) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Image.file(
                File(path),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSessao(String nomeSessao) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nomeSessao,
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => selecionarArquivo(nomeSessao),
            ),
          ],
        ),
        Wrap(
          children: arquivosPorSessao[nomeSessao]!
              .map((arquivo) => GestureDetector(
                    onTap: () => abrirFotoEmTelaCheia(arquivo.path!),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(arquivo.path!)),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () =>
                                removerArquivo(nomeSessao, arquivo),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotos e Vídeos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...arquivosPorSessao.keys
                .map((sessao) => buildSessao(sessao)),

            Center(child:
            ElevatedButton(
              onPressed: () async {
                if (arquivosPorSessao.isNotEmpty) {
                  await enviarArquivos();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopupSucesso(
                        mensagem: 'Arquivos enviados com sucesso.',
                        proxTela: ListaDeVerificacao(),
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
              child: const Text('Enviar mídias'),
            ),)
          ],
        ),
      ),
    );
  }
}
