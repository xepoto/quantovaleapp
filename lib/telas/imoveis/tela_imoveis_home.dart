import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modelos/imovel_model.dart';
import 'imovel_tile.dart';
import 'tela_detalhes_imovel.dart';

class TelaImoveisHome extends ConsumerStatefulWidget {
  const TelaImoveisHome({super.key});

  @override
  _ImoveisHomeState createState() => _ImoveisHomeState();
}

class _ImoveisHomeState extends ConsumerState<TelaImoveisHome> {
  TextEditingController buscaController = TextEditingController();
  String searchQuery = '';
  late Future<List<ImovelModel>> futureImoveis;

  @override
  void initState() {
    super.initState();
    futureImoveis = _carregarJsonImoveis();
  }

  Future<List<ImovelModel>> _carregarJsonImoveis() async {
    final imoveisJson = await ImoveisPreferences.carregarJsonImoveis();
    final imoveisList = imoveisJson['imoveis'] as List<dynamic>;
    return imoveisList
        .map(
          (imovel) => ImovelModel(
            id: imovel['id'] ?? '',
            titulo: imovel['titulo'] ?? '',
            imagem: imovel['imagem'] ??
                '',
            isConcluido: imovel['isConcluido'] ?? false
          ),
        )
        .toList();
  }

  Future<void> _adicionarImovel() async {
    final String? novoTitulo = await _mostrarDialogoDeEntrada(context);

    if (novoTitulo != null && novoTitulo.isNotEmpty) {
      final novoImovel = ImovelModel(titulo: novoTitulo);

      await ImoveisPreferences.adicionarImovel(novoImovel);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Imóvel "$novoTitulo" adicionado com sucesso!'),
        ),
      );

      // Atualiza a lista de imóveis
      setState(() {
        futureImoveis = _carregarJsonImoveis();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações em andamento'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ImovelModel>>(
        future: futureImoveis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar imóveis'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum imóvel disponível.'));
          }

          final imoveis = snapshot.data!;
          final imoveisFiltrados = imoveis.where((imovel) {
            return imovel.titulo!
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: buscaController,
                  decoration: InputDecoration(
                    labelText: 'Pesquisar avaliações',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: imoveisFiltrados.length,
                  itemBuilder: (context, index) {
                    final imovel = imoveisFiltrados[index];
                    return ImovelTile(
                      imagem: imovel.imagem!,
                      titulo: imovel.titulo!,
                      isConcluido: imovel.isConcluido ?? false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TelaDetalhesImovel(idImovel: imovel.id),
                          ),
                        );
                      },
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarImovel,
        tooltip: 'Adicionar Imóvel',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<String?> _mostrarDialogoDeEntrada(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Novo Imóvel'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Digite o título do imóvel'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
