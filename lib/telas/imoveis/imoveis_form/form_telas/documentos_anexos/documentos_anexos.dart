import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Adicionei o Riverpod
import 'package:quanto_vale_APP/telas/imoveis/imoveis_form/form_telas/dados_imovel/dados_imovel.dart';
import '../../../../../modelos/imovel_model.dart';
import '../../../tela_detalhes_imovel.dart';
import '../FormBarraInferior.dart';

class TelaDocumentosAnexos extends ConsumerStatefulWidget {

  final ImovelModel imovel;
  const TelaDocumentosAnexos({super.key, required this.imovel});

  @override
  ConsumerState<TelaDocumentosAnexos> createState() => _TelaDocumentosAnexosState();
}

class _TelaDocumentosAnexosState extends ConsumerState<TelaDocumentosAnexos> {
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos Anexos'),
      ),
      bottomNavigationBar: FormBarraInferior(telaImovel: TelaDetalhesImovel(idImovel: widget.imovel.id,),
        proximaTela: TelaDadosImovel(imovel: widget.imovel), onSalvar: () {  }, onContinuar: () {  }, // Passa o imovel aqui
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 40),
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
            ],
          ),
        ),
      ),
    );
  }
}
