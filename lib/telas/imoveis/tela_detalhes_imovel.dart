import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quanto_vale_app/modelos/imovel_model.dart';
import 'package:quanto_vale_app/telas/imoveis/botao_abrir_laudo.dart';
import 'package:quanto_vale_app/telas/imoveis/botao_download_laudo.dart';
import 'package:quanto_vale_app/telas/imoveis/imoveis_form/form_telas/documentos_anexos/documentos_anexos.dart';
import 'package:quanto_vale_app/telas/imoveis/imoveis_form/form_telas/dados_imovel/dados_imovel.dart';
import 'package:quanto_vale_app/telas/imoveis/imoveis_form/form_telas/fotos_videos/fotos_videos.dart';
import 'package:quanto_vale_app/telas/imoveis/imoveis_form/form_telas/lista_verificacoes/lista_verificacoes.dart';
import 'package:quanto_vale_app/telas/imoveis/tela_imoveis_home.dart';
import 'package:quanto_vale_app/telas/imoveis/widget_imagem_imovel.dart';

class TelaDetalhesImovel extends ConsumerStatefulWidget {
  final String? idImovel;

  const TelaDetalhesImovel({Key? key, required this.idImovel})
      : super(key: key);

  @override
  _DetalhesImovelState createState() => _DetalhesImovelState();
}

class _DetalhesImovelState extends ConsumerState<TelaDetalhesImovel> {
  late Future<ImovelModel> _imovelFuture;

  @override
  void initState() {
    super.initState();
    _imovelFuture = _carregarImovel(widget.idImovel);
  }

  Future<ImovelModel> _carregarImovel(String? imovelId) async {
    final imoveisJson = await ImoveisPreferences.carregarJsonImoveis();
    final imoveisList = imoveisJson['imoveis'] as List<dynamic>;
    final matchedImovel = imoveisList.firstWhere(
      (imovel) => imovel['id'] == imovelId,
      orElse: () => throw Exception('Imóvel não encontrado'),
    );
    return ImovelModel(
      id: matchedImovel['id'] ?? '',
      titulo: matchedImovel['titulo'] ?? '',
      imagem: matchedImovel['imagem'] ?? '',
      isConcluido: matchedImovel['isConcluido'] ?? false,
      cep: matchedImovel['cep'] ?? '',
      endereco: matchedImovel['endereco'] ?? '',
      numero: matchedImovel['numero'] ?? '',
      complemento: matchedImovel['complemento'] ?? '',
      bairro: matchedImovel['bairro'] ?? '',
      cidade: matchedImovel['cidade'] ?? '',
      estado: matchedImovel['estado'] ?? '',
      tipo: matchedImovel['tipo'] ?? '',
      agrupamento: matchedImovel['agrupamento'] ?? '',
      utilizacao: matchedImovel['utilizacao'] ?? '',
      nomeProp: matchedImovel['nomeProp'] ?? '',
      cepProp: matchedImovel['cepProp'] ?? '',
      enderecoProp: matchedImovel['enderecoProp'] ?? '',
      numeroProp: matchedImovel['numeroProp'] ?? '',
      complementoProp: matchedImovel['complementoProp'] ?? '',
      bairroProp: matchedImovel['bairroProp'] ?? '',
      cidadeProp: matchedImovel['cidadeProp'] ?? '',
      estadoProp: matchedImovel['estadoProp'] ?? '',
      fotoSala: matchedImovel['fotoSala'] ?? '',
      fotoCozinha: matchedImovel['fotoCozinha'] ?? '',
      fotoBanheiroSocial: matchedImovel['fotoBanheiroSocial'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImovelModel>(
      future: _imovelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Erro ao carregar os dados do imóvel.'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Imóvel não encontrado.'));
        } else {
          final imovel = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading:
                  false, // Remove o botão padrão de voltar
              title: Text(imovel.titulo!),
            ),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // DADOS
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          exibirImagemDoImovel(imovel.imagem),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TelaDocumentosAnexos(imovel: imovel),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                              ),
                              child: const Text('Documentos'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TelaDadosImovel(imovel: imovel),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                              ),
                              child: const Text('Dados'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TelaFotosVideos(imovel: imovel),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                              ),
                              child: const Text('Fotos'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TelaListaDeVerificacao(imovel: imovel),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                              ),
                              child: const Text('Verificações'),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 200,
                            child: !imovel.isConcluido!
                                ? ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirmação'),
                                            content: Text(
                                                'Enviar informações do imóvel para análise e avaliação?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child:
                                                    Text('Continuar editando'),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TelaImoveisHome()),
                                                  );
                                                  ScaffoldMessenger.of(
                                                    Navigator.of(context)
                                                        .overlay!
                                                        .context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Enviado com sucesso!'),
                                                      backgroundColor:
                                                          Colors.green,
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.check,
                                                    color: Colors.green),
                                                label: Text('Confirmar'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(200, 50),
                                    ),
                                    child: const Text('Enviar'),
                                  )
                                : Center(
                                    child: Text(
                                    'Avaliação concluída.',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                          ),
                          SizedBox(height: 20),
                          imovel.isConcluido!
                              ? SizedBox(
                                  child: BotaoAbrirLaudo(
                                  assetPath:
                                      'assets/LAUDO DE AVALIAÇÃO SIMPLIFICADO.pdf',
                                ))
                              : SizedBox()
                        ],
                      ),
                    ],
                  ),
                ),
                // Botão de Voltar no canto inferior esquerdo
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => TelaImoveisHome()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text('Voltar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
