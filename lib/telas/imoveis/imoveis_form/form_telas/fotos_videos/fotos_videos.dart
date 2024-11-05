import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quanto_vale_APP/telas/imoveis/imoveis_form/form_telas/lista_verificacoes/lista_verificacoes.dart';
import 'package:quanto_vale_APP/telas/imoveis/tela_detalhes_imovel.dart';

import '../../../../../modelos/imovel_model.dart';
import '../../form_models/imovel_model.dart';
import '../FormBarraInferior.dart';

class TelaFotosVideos extends ConsumerStatefulWidget {
  final ImovelModel imovel;

  const TelaFotosVideos({Key? key, required this.imovel}) : super(key: key);

  @override
  _TelaFotosVideosState createState() => _TelaFotosVideosState();
}

class _TelaFotosVideosState extends ConsumerState<TelaFotosVideos> {
  Map<String, List<PlatformFile>> arquivosPorSessao = {
    'Imagem do Imóvel': [],
    'Cozinha': [],
    'Banheiro social': [],
    'Sala': [],
  };

  Future<void> selecionarArquivo(String sessao) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        arquivosPorSessao[sessao] = [result.files.first];
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
      bottomNavigationBar: FormBarraInferior(
        telaImovel: TelaDetalhesImovel(
          idImovel: widget.imovel.id,
        ),
        proximaTela: TelaListaDeVerificacao(imovel: widget.imovel),
        onSalvar: () async {
          print(widget.imovel.id);
          print(widget.imovel.imagem);

          if (widget.imovel.imagem == null || widget.imovel.imagem == '') {
            final primeiraImagem = arquivosPorSessao['Imagem do Imóvel']?.first;
            final caminhoImagem = primeiraImagem?.path;
            final ImovelModel updatedImovel = ImovelModel(
              id: widget.imovel.id,
              titulo: widget.imovel.titulo,
              imagem: caminhoImagem,
              isConcluido: widget.imovel.isConcluido,
              cep: widget.imovel.cep,
              endereco: widget.imovel.endereco,
              numero: widget.imovel.numero,
              complemento: widget.imovel.complemento,
              bairro: widget.imovel.bairro,
              cidade: widget.imovel.cidade,
              estado: widget.imovel.estado,
              tipo: widget.imovel.tipo,
              agrupamento: widget.imovel.agrupamento,
              utilizacao: widget.imovel.utilizacao,
              nomeProp: widget.imovel.nomeProp,
              cepProp: widget.imovel.cepProp,
              enderecoProp: widget.imovel.enderecoProp,
              numeroProp: widget.imovel.numeroProp,
              complementoProp: widget.imovel.complementoProp,
              bairroProp: widget.imovel.bairroProp,
              cidadeProp: widget.imovel.cidadeProp,
              estadoProp: widget.imovel.estadoProp,
              fotoSala: widget.imovel.fotoSala,
              fotoCozinha: widget.imovel.fotoCozinha,
              fotoBanheiroSocial: widget.imovel.fotoBanheiroSocial,
            );


            await ImoveisPreferences.atualizarImovel(updatedImovel);
          }
        },
        onContinuar: () async {
          if (widget.imovel.imagem == null || widget.imovel.imagem == '') {
            final primeiraImagem = arquivosPorSessao['Imagem do Imóvel']?.first;
            final caminhoImagem = primeiraImagem?.path;
            final ImovelModel updatedImovel = ImovelModel(
              id: widget.imovel.id,
              titulo: widget.imovel.titulo,
              imagem: caminhoImagem,
              isConcluido: widget.imovel.isConcluido,
              cep: widget.imovel.cep,
              endereco: widget.imovel.endereco,
              numero: widget.imovel.numero,
              complemento: widget.imovel.complemento,
              bairro: widget.imovel.bairro,
              cidade: widget.imovel.cidade,
              estado: widget.imovel.estado,
              tipo: widget.imovel.tipo,
              agrupamento: widget.imovel.agrupamento,
              utilizacao: widget.imovel.utilizacao,
              nomeProp: widget.imovel.nomeProp,
              cepProp: widget.imovel.cepProp,
              enderecoProp: widget.imovel.enderecoProp,
              numeroProp: widget.imovel.numeroProp,
              complementoProp: widget.imovel.complementoProp,
              bairroProp: widget.imovel.bairroProp,
              cidadeProp: widget.imovel.cidadeProp,
              estadoProp: widget.imovel.estadoProp,
              fotoSala: widget.imovel.fotoSala,
              fotoCozinha: widget.imovel.fotoCozinha,
              fotoBanheiroSocial: widget.imovel.fotoBanheiroSocial,
            );

            await ImoveisPreferences.atualizarImovel(updatedImovel);
          }
        },
      ),
      appBar: AppBar(
        title: const Text('Fotos e Vídeos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...arquivosPorSessao.keys.map((sessao) => buildSessao(sessao)),
            SizedBox(height: 40),
/*            Center(
              child: Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (arquivosPorSessao.isNotEmpty) {
                        final imovelNotifier =
                            ref.read(imovelProvider.notifier);

                        // Atualizando as fotos no imóvel
                        if (arquivosPorSessao['Sala']!.isNotEmpty) {
                          imovelNotifier.setFotoSala(
                              arquivosPorSessao['Sala']!.first.path);
                        }
                        if (arquivosPorSessao['Cozinha']!.isNotEmpty) {
                          imovelNotifier.setFotoCozinha(
                              arquivosPorSessao['Cozinha']!.first.path);
                        }
                        if (arquivosPorSessao['Banheiro social']!.isNotEmpty) {
                          imovelNotifier.setFotoBanheiroSocial(
                              arquivosPorSessao['Banheiro social']!.first.path);
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmação'),
                              content: Text(
                                  'As alterações foram salvas com sucesso.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmação'),
                              content: Text(
                                  'Nenhum arquivo foi selecionado.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Próximo'),
                  );
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
