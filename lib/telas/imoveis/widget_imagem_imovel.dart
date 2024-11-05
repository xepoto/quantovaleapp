import 'dart:io';

import 'package:flutter/material.dart';


Widget exibirImagemDoImovel(String? imagem) {
  String placeholderPath = 'assets/imagens_exemplos/placeholder_imovel.png';
  // Se a imagem está nos assets
  if (imagem != null && imagem.startsWith('assets/')) {
    return Image.asset(
      imagem,
      fit: BoxFit.cover, // Ajuste conforme necessário
      width: 200, // Ajuste conforme necessário
      height: 150, // Ajuste conforme necessário
    );
  }
  // Se a imagem é um arquivo local
  else if (imagem != null) {
    final imageFile = File(imagem);
    if (imageFile.existsSync()) {
      return Image.file(
        imageFile,
        fit: BoxFit.cover, // Ajuste conforme necessário
        width: 200, // Ajuste conforme necessário
        height: 150, // Ajuste conforme necessário
      );
    } else {
      return Image.asset(
          placeholderPath,
          fit: BoxFit.cover, // Ajuste conforme necessário
          width: 200, // Ajuste conforme necessário
          height: 150); // Arquivo não encontrado
    }
  }
  // Caso não tenha imagem
  else {
    return Image.asset(
        placeholderPath,
        fit: BoxFit.cover, // Ajuste conforme necessário
        width: 200, // Ajuste conforme necessário
        height: 150); // Ou qualquer outro widget padrão
  }
}