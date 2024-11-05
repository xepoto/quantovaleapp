import 'package:flutter/material.dart';
import 'package:quanto_vale_APP/telas/imoveis/widget_imagem_imovel.dart';

class ImovelTile extends StatelessWidget {
  final String imagem;
  final String titulo;
  final bool isConcluido;
  final VoidCallback onTap;

  const ImovelTile({
    Key? key,
    required this.imagem,
    required this.titulo,
    required this.isConcluido,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            exibirImagemDoImovel(imagem),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      titulo,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    isConcluido ? Icons.check_circle : Icons.circle_outlined,
                    color: isConcluido ? Colors.green : Colors.red,
                    size: 24.0, // Tamanho fixo para o ícone
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
