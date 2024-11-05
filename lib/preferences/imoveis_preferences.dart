import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class ImoveisPreferences {
  static const String _keyImoveis = 'imoveis';

  // Carrega o JSON dos imóveis
  static Future<Map<String, dynamic>> carregarJsonImoveis() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_keyImoveis);

    if (jsonString != null) {
      return json.decode(jsonString);
    } else {
      // Se não houver nada salvo, carregue do arquivo de assets
      final String response = await rootBundle.loadString('assets/imoveis.json');
      return json.decode(response);
    }
  }

  // Salva o JSON atualizado em shared_preferences
  static Future<void> salvarJsonImoveis(Map<String, dynamic> jsonImoveis) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyImoveis, json.encode(jsonImoveis));
  }
}

class ImovelModel {
  final String titulo;
  final String imagem;
  final bool isConcluido;

  ImovelModel({
    required this.titulo,
    required this.imagem,
    required this.isConcluido,
  });

  // Método para converter um objeto JSON em uma instância de ImovelModel
  factory ImovelModel.fromJson(Map<String, dynamic> json) {
    return ImovelModel(
      titulo: json['titulo'] as String,
      imagem: json['imagem'] as String,
      isConcluido: json['isConcluido'] as bool,
    );
  }

  // Método para converter uma instância de ImovelModel em um objeto JSON
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'imagem': imagem,
      'isConcluido': isConcluido,
    };
  }
}
