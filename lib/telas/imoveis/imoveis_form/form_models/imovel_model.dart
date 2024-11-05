import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Imovel {
  // Dados básicos
  String titulo;
  String imagem;
  bool isConcluido;

  // Dados do imóvel
  String cep;
  String endereco;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  String tipo;
  String agrupamento;
  String utilizacao;

  // Dados do proprietário
  String nomeProp;
  String cepProp;
  String enderecoProp;
  String numeroProp;
  String complementoProp;
  String bairroProp;
  String cidadeProp;
  String estadoProp;

  // Fotos
  String? fotoSala;
  String? fotoCozinha;
  String? fotoBanheiroSocial;

  Imovel({
    required this.titulo,
    required this.imagem,
    required this.isConcluido,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.tipo,
    required this.agrupamento,
    required this.utilizacao,
    required this.nomeProp,
    required this.cepProp,
    required this.enderecoProp,
    required this.numeroProp,
    required this.complementoProp,
    required this.bairroProp,
    required this.cidadeProp,
    required this.estadoProp,
    this.fotoSala,
    this.fotoCozinha,
    this.fotoBanheiroSocial,
  });

  factory Imovel.fromJson(Map<String, dynamic> json) {
    return Imovel(
      titulo: json['titulo'],
      imagem: json['imagem'],
      isConcluido: json['isConcluido'],
      cep: json['cep'],
      endereco: json['endereco'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      tipo: json['tipo'],
      agrupamento: json['agrupamento'],
      utilizacao: json['utilizacao'],
      nomeProp: json['nomeProp'],
      cepProp: json['cepProp'],
      enderecoProp: json['enderecoProp'],
      numeroProp: json['numeroProp'],
      complementoProp: json['complementoProp'],
      bairroProp: json['bairroProp'],
      cidadeProp: json['cidadeProp'],
      estadoProp: json['estadoProp'],
      fotoSala: json['fotoSala'],
      fotoCozinha: json['fotoCozinha'],
      fotoBanheiroSocial: json['fotoBanheiroSocial'],
    );
  }

  @override
  String toString() {
    return '''
Imovel(
  titulo: $titulo,
  imagem: $imagem,
  isConcluido: $isConcluido,
  cep: $cep,
  endereco: $endereco,
  numero: $numero,
  complemento: $complemento,
  bairro: $bairro,
  cidade: $cidade,
  estado: $estado,
  tipo: $tipo,
  agrupamento: $agrupamento,
  utilizacao: $utilizacao,
  nomeProp: $nomeProp,
  cepProp: $cepProp,
  enderecoProp: $enderecoProp,
  numeroProp: $numeroProp, 
  complementoProp: $complementoProp,
  bairroProp: $bairroProp,
  cidadeProp: $cidadeProp,
  estadoProp: $estadoProp,
  fotoSala: $fotoSala,
  fotoCozinha: $fotoCozinha,
  fotoBanheiroSocial: $fotoBanheiroSocial
)''';
  }

  // Métodos para atualizar atributos
  void setTitulo(String value) => titulo = value;
  void setImagem(String value) => imagem = value;
  void setIsConcluido(bool value) => isConcluido = value;

  void setCep(String value) => cep = value;
  void setEndereco(String value) => endereco = value;
  void setNumero(String value) => numero = value;
  void setComplemento(String value) => complemento = value;
  void setBairro(String value) => bairro = value;
  void setCidade(String value) => cidade = value;
  void setEstado(String value) => estado = value;
  void setTipo(String value) => tipo = value;
  void setAgrupamento(String value) => agrupamento = value;
  void setUtilizacao(String value) => utilizacao = value;
  void setNomeProp(String value) => nomeProp = value;
  void setCepProp(String value) => cepProp = value;
  void setEnderecoProp(String value) => enderecoProp = value;
  void setNumeroProp(String value) => numeroProp = value;
  void setComplementoProp(String value) => complementoProp = value;
  void setBairroProp(String value) => bairroProp = value;
  void setCidadeProp(String value) => cidadeProp = value;
  void setEstadoProp(String value) => estadoProp = value;
  void setFotoSala(String? value) => fotoSala = value;
  void setFotoCozinha(String? value) => fotoCozinha = value;
  void setFotoBanheiroSocial(String? value) => fotoBanheiroSocial = value;
}

// StateNotifier para Imovel
class ImovelNotifier extends StateNotifier<Imovel> {
  ImovelNotifier()
      : super(
    Imovel(
      titulo: '',
      imagem: '',
      isConcluido: false,
      cep: '',
      endereco: '',
      numero: '',
      complemento: '',
      bairro: '',
      cidade: '',
      estado: '',
      tipo: '',
      agrupamento: '',
      utilizacao: '',
      nomeProp: '',
      cepProp: '',
      enderecoProp: '',
      numeroProp: '',
      complementoProp: '',
      bairroProp: '',
      cidadeProp: '',
      estadoProp: '',
    ),
  );

  // Métodos para atualizar o estado
  void setTitulo(String value) => state.setTitulo(value);
  void setImagem(String value) => state.setImagem(value);
  void setIsConcluido(bool value) => state.setIsConcluido(value);

  void setCep(String value) => state.setCep(value);
  void setEndereco(String value) => state.setEndereco(value);
  void setNumero(String value) => state.setNumero(value);
  void setComplemento(String value) => state.setComplemento(value);
  void setBairro(String value) => state.setBairro(value);
  void setCidade(String value) => state.setCidade(value);
  void setEstado(String value) => state.setEstado(value);
  void setTipo(String value) => state.setTipo(value);
  void setAgrupamento(String value) => state.setAgrupamento(value);
  void setUtilizacao(String value) => state.setUtilizacao(value);
  void setNomeProp(String value) => state.setNomeProp(value);
  void setCepProp(String value) => state.setCepProp(value);
  void setEnderecoProp(String value) => state.setEnderecoProp(value);
  void setNumeroProp(String value) => state.setNumeroProp(value);
  void setComplementoProp(String value) => state.setComplementoProp(value);
  void setBairroProp(String value) => state.setBairroProp(value);
  void setCidadeProp(String value) => state.setCidadeProp(value);
  void setEstadoProp(String value) => state.setEstadoProp(value);
  void setFotoSala(String? value) => state.setFotoSala(value);
  void setFotoCozinha(String? value) => state.setFotoCozinha(value);
  void setFotoBanheiroSocial(String? value) => state.setFotoBanheiroSocial(value);
}

// Provider para o ImovelNotifier
final imovelProvider = StateNotifierProvider<ImovelNotifier, Imovel>(
      (ref) => ImovelNotifier(),
);

/*
// Provider para carregar a lista de imóveis a partir de um JSON
final imoveisListProvider = FutureProvider<List<Imovel>>((ref) async {
  final String resposta = await rootBundle.loadString('assets/imoveis.json');
  final data = json.decode(resposta);
  return (data['imoveis'] as List).map((imovel) => Imovel.fromJson(imovel)).toList();
});
*/
