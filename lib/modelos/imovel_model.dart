import 'dart:convert';
import 'package:flutter/services.dart'; // carregar arquivos de assets
import 'package:shared_preferences/shared_preferences.dart';

class ImovelModel {
  String? id;
  String? titulo;
  String? imagem;
  bool? isConcluido;

  String? cep;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? tipo;
  String? agrupamento;
  String? utilizacao;

  String? nomeProp;
  String? cepProp;
  String? enderecoProp;
  String? numeroProp;
  String? complementoProp;
  String? bairroProp;
  String? cidadeProp;
  String? estadoProp;

  String? fotoSala;
  String? fotoCozinha;
  String? fotoBanheiroSocial;

  ImovelModel({
    this.id,
    this.titulo,
    this.imagem,
    this.isConcluido,
    this.cep,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.tipo,
    this.agrupamento,
    this.utilizacao,
    this.nomeProp,
    this.cepProp,
    this.enderecoProp,
    this.numeroProp,
    this.complementoProp,
    this.bairroProp,
    this.cidadeProp,
    this.estadoProp,
    this.fotoSala,
    this.fotoCozinha,
    this.fotoBanheiroSocial,
  });

  factory ImovelModel.fromJson(Map<String, dynamic> json) {
    return ImovelModel(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      imagem: json['imagem'] ?? '',
      isConcluido: json['isConcluido'] ?? false,
      cep: json['cep'] ?? '',
      endereco: json['endereco'] ?? '',
      numero: json['numero'] ?? '',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? '',
      cidade: json['cidade'] ?? '',
      estado: json['estado'] ?? '',
      tipo: json['tipo'] ?? '',
      agrupamento: json['agrupamento'] ?? '',
      utilizacao: json['utilizacao'] ?? '',
      nomeProp: json['nomeProp'] ?? '',
      cepProp: json['cepProp'] ?? '',
      enderecoProp: json['enderecoProp'] ?? '',
      numeroProp: json['numeroProp'] ?? '',
      complementoProp: json['complementoProp'] ?? '',
      bairroProp: json['bairroProp'] ?? '',
      cidadeProp: json['cidadeProp'] ?? '',
      estadoProp: json['estadoProp'] ?? '',
      fotoSala: json['fotoSala'] ?? '',
      fotoCozinha: json['fotoCozinha'] ?? '',
      fotoBanheiroSocial: json['fotoBanheiroSocial'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'imagem': imagem,
      'isConcluido': isConcluido,
      'cep': cep,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'tipo': tipo,
      'agrupamento': agrupamento,
      'utilizacao': utilizacao,
      'nomeProp': nomeProp,
      'cepProp': cepProp,
      'enderecoProp': enderecoProp,
      'numeroProp': numeroProp,
      'complementoProp': complementoProp,
      'bairroProp': bairroProp,
      'cidadeProp': cidadeProp,
      'estadoProp': estadoProp,
      'fotoSala': fotoSala,
      'fotoCozinha': fotoCozinha,
      'fotoBanheiroSocial': fotoBanheiroSocial,
    };
  }

  static List<ImovelModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ImovelModel.fromJson(json)).toList();
  }
}

class ImoveisPreferences {
  static const String _keyImoveis = 'imoveis';

  // Carregar o JSON de imóveis de SharedPreferences ou dos assets
  static Future<Map<String, dynamic>> carregarJsonImoveis() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_keyImoveis);

    if (jsonString != null) {
      return json.decode(jsonString);
    } else {
      // Se não existir em SharedPreferences, carregar dos assets
      final String response =
      await rootBundle.loadString('assets/imoveis.json');
      return json.decode(response);
    }
  }

  // Salvar o JSON de imóveis em SharedPreferences
  static Future<void> salvarJsonImoveis(
      Map<String, dynamic> jsonImoveis) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyImoveis, json.encode(jsonImoveis));
  }

  // Adicionar um imóvel ao JSON e salvar
  static Future<void> adicionarImovel(ImovelModel novoImovel) async {
    try {
      final imoveisJson = await carregarJsonImoveis();
      final List<dynamic> imoveisList = imoveisJson['imoveis'] ?? [];

      // Verifica se o imóvel já existe (pelo ID)
      bool existeImovelComMesmoID = imoveisList.any((item) {
        final imovel = ImovelModel.fromJson(item);
        return imovel.id == novoImovel.id;
      });

      if (existeImovelComMesmoID) {
        throw Exception('Já existe um imóvel com o ID ${novoImovel.id}');
      }

      // Gera um ID único para o novo imóvel, se necessário
      if (novoImovel.id == null || novoImovel.id!.isEmpty) {
        novoImovel.id = DateTime.now().millisecondsSinceEpoch.toString();
      }

      // Adiciona o novo imóvel à lista
      imoveisList.add(novoImovel.toJson());

      // Salva a lista atualizada
      await salvarJsonImoveis({'imoveis': imoveisList});
    } catch (e) {
      print('Erro ao adicionar imóvel: $e');
    }
  }

  // Atualizar um imóvel existente no JSON
  static Future<void> atualizarImovel(ImovelModel imovelAtualizado) async {
    final imoveisJson = await carregarJsonImoveis();
    final List<dynamic> imoveisList = imoveisJson['imoveis'] ?? [];

    // Procurar o imóvel pelo ID e atualizá-lo
    final updatedList = imoveisList.map((item) {
      final imovel = ImovelModel.fromJson(item);
      return imovel.id == imovelAtualizado.id
          ? imovelAtualizado.toJson() // Atualiza o imóvel
          : item; // Mantém o imóvel existente
    }).toList();

    // Salva a lista atualizada no JSON
    await salvarJsonImoveis({'imoveis': updatedList});
  }
}
