import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quanto_vale_APP/telas/imoveis/imoveis_form/form_telas/FormBarraInferior.dart';
import 'package:quanto_vale_APP/telas/imoveis/imoveis_form/form_telas/fotos_videos/fotos_videos.dart';

import '../../../../../modelos/imovel_model.dart';
import '../../../tela_detalhes_imovel.dart';
import '../../form_models/imovel_model.dart';

import 'widgets/dropdown_customizado.dart';
import 'widgets/campo_texto_customizado.dart';
import 'widgets/informacoes_adicionais.dart';

class TelaDadosImovel extends ConsumerStatefulWidget {
  final ImovelModel imovel;

  const TelaDadosImovel({Key? key, required this.imovel}) : super(key: key);

  @override
  _TelaDadosImovelState createState() => _TelaDadosImovelState();
}

class _TelaDadosImovelState extends ConsumerState<TelaDadosImovel> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _carregarDados());
  }

  // atualiza os campos do formulário com os valores atuais do imovel
  Future<void> _carregarDados() async {
    if (_formKey.currentState != null) {
      _formKey.currentState!.patchValue({
        'nomeProp': widget.imovel.nomeProp,
        'cepProp': widget.imovel.cepProp,
        'enderecoProp': widget.imovel.enderecoProp,
        'numeroProp': widget.imovel.numeroProp,
        'complementoProp': widget.imovel.complementoProp,
        'bairroProp': widget.imovel.bairroProp,
        'cidadeProp': widget.imovel.cidadeProp,
        'estadoProp': widget.imovel.estadoProp,
        'cep': widget.imovel.cep,
        'endereco': widget.imovel.endereco,
        'numero': widget.imovel.numero,
        'complemento': widget.imovel.complemento,
        'bairro': widget.imovel.bairro,
        'cidade': widget.imovel.cidade,
        'estado': widget.imovel.estado,
        'tipo_imovel': widget.imovel.tipo,
        'agrupamento_imovel': widget.imovel.agrupamento,
        'utilizacao_imovel': widget.imovel.utilizacao,
      });
    } else {
      print('deu ruim');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imovelNotifier = ref.read(imovelProvider.notifier);
    return Scaffold(
      bottomNavigationBar: FormBarraInferior(
        telaImovel: TelaDetalhesImovel(
          idImovel: widget.imovel.id,
        ),
        proximaTela: TelaFotosVideos(imovel: widget.imovel),
        onSalvar: () async {
          print(_formKey.currentState!.saveAndValidate());
          //if (_formKey.currentState!.saveAndValidate()) {
            final formDataValue = _formKey.currentState!.value;

            // setando infos de campos que possuem "outro"
            // talvez melhorar...
            String tipoImovel = formDataValue['tipo_imovel'] == 'Outro'
                ? formDataValue['tipo_imovel_outro']
                : formDataValue['tipo_imovel'];
            String agrupamentoImovel =
                formDataValue['agrupamento_imovel'] == 'Outro'
                    ? formDataValue['agrupamento_imovel_outro']
                    : formDataValue['agrupamento_imovel'];
            String utilizacaoImovel =
                formDataValue['utilizacao_imovel'] == 'Outro'
                    ? formDataValue['utilizacao_imovel_outro']
                    : formDataValue['utilizacao_imovel'];

            final ImovelModel updatedImovel = ImovelModel(
                id: widget.imovel.id,
                titulo: widget.imovel.titulo,
                imagem: widget.imovel.imagem,
                isConcluido: widget.imovel.isConcluido,
                nomeProp: formDataValue['nomeProp'],
                cepProp: formDataValue['cepProp'],
                enderecoProp: formDataValue['enderecoProp'],
                numeroProp: formDataValue['numeroProp'],
                complementoProp: formDataValue['complementoProp'],
                bairroProp: formDataValue['bairroProp'],
                cidadeProp: formDataValue['cidadeProp'],
                estadoProp: formDataValue['estadoProp'],
                cep: formDataValue['cep'],
                endereco: formDataValue['endereco'],
                numero: formDataValue['numero'],
                complemento: formDataValue['complemento'],
                bairro: formDataValue['bairro'],
                cidade: formDataValue['cidade'],
                estado: formDataValue['estado'],
                tipo: tipoImovel,
                agrupamento: agrupamentoImovel,
                utilizacao: utilizacaoImovel,
                fotoBanheiroSocial: widget.imovel.fotoBanheiroSocial,
                fotoCozinha: widget.imovel.fotoCozinha,
                fotoSala: widget.imovel.fotoSala);

            print('ID DO IMOVEL ATUALIZADO: ${updatedImovel.id}');

            await ImoveisPreferences.atualizarImovel(updatedImovel);

            // SnackBar de sucesso
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('As alterações foram salvas com sucesso.'),
                duration: Duration(seconds: 2),
              ),
            );
          //}
        },
        onContinuar: () async {
          print(_formKey.currentState!.saveAndValidate());
          //if (_formKey.currentState!.saveAndValidate()) {
            final formDataValue = _formKey.currentState!.value;

            // setando infos de campos que possuem "outro"
            // talvez melhorar...
            String tipoImovel = formDataValue['tipo_imovel'] == 'Outro'
                ? formDataValue['tipo_imovel_outro']
                : formDataValue['tipo_imovel'];
            String agrupamentoImovel =
                formDataValue['agrupamento_imovel'] == 'Outro'
                    ? formDataValue['agrupamento_imovel_outro']
                    : formDataValue['agrupamento_imovel'];
            String utilizacaoImovel =
                formDataValue['utilizacao_imovel'] == 'Outro'
                    ? formDataValue['utilizacao_imovel_outro']
                    : formDataValue['utilizacao_imovel'];

            final ImovelModel updatedImovel = ImovelModel(
                id: widget.imovel.id,
                titulo: widget.imovel.titulo,
                imagem: widget.imovel.imagem,
                isConcluido: widget.imovel.isConcluido,
                nomeProp: formDataValue['nomeProp'],
                cepProp: formDataValue['cepProp'],
                enderecoProp: formDataValue['enderecoProp'],
                numeroProp: formDataValue['numeroProp'],
                complementoProp: formDataValue['complementoProp'],
                bairroProp: formDataValue['bairroProp'],
                cidadeProp: formDataValue['cidadeProp'],
                estadoProp: formDataValue['estadoProp'],
                cep: formDataValue['cep'],
                endereco: formDataValue['endereco'],
                numero: formDataValue['numero'],
                complemento: formDataValue['complemento'],
                bairro: formDataValue['bairro'],
                cidade: formDataValue['cidade'],
                estado: formDataValue['estado'],
                tipo: tipoImovel,
                agrupamento: agrupamentoImovel,
                utilizacao: utilizacaoImovel,
                fotoBanheiroSocial: widget.imovel.fotoBanheiroSocial,
                fotoCozinha: widget.imovel.fotoCozinha,
                fotoSala: widget.imovel.fotoSala);

            print(updatedImovel.id);

            await ImoveisPreferences.atualizarImovel(updatedImovel);

            print(widget.imovel.titulo);
          //}
        },
      ),
      appBar: AppBar(
        title: const Text('Dados do Imóvel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Dados do Proprietário',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CampoStringCustomizado(name: 'nomeProp', labelText: 'Nome'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(name: 'cepProp', labelText: 'CEP'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'enderecoProp', labelText: 'Endereço'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'numeroProp', labelText: 'Número'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'complementoProp', labelText: 'Complemento'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'bairroProp', labelText: 'Bairro'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'cidadeProp', labelText: 'Cidade'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'estadoProp', labelText: 'Estado'),
                const SizedBox(height: 20),
                const Text(
                  'Dados do Imóvel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const CampoStringCustomizado(name: 'cep', labelText: 'CEP'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'endereco', labelText: 'Endereço'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'numero', labelText: 'Número'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'complemento', labelText: 'Complemento'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'bairro', labelText: 'Bairro'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'cidade', labelText: 'Cidade'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'estado', labelText: 'Estado'),
                const SizedBox(height: 20),
                DropdownCustomizado(
                  name: 'tipo_imovel',
                  labelText: 'Tipo',
                  options: [
                    'Apartamento',
                    'Banco',
                    'Barracão',
                    'Casa de Alvenaria',
                    'Cobertura Comercial',
                    'Constr. Rural',
                    'Escritório',
                    'Fábrica',
                    'Galpão (depósito)',
                    'Garagem',
                    'Hotel',
                    'Loja',
                    'Silo',
                    'Terreno',
                    'Outro'
                  ],
                ),
                const SizedBox(height: 10),
                DropdownCustomizado(
                  name: 'agrupamento_imovel',
                  labelText: 'Agrupamento',
                  options: [
                    'Complexo Industrial',
                    'Condomínio de Casas',
                    'Conjunto de Prédios Comerciais',
                    'Conjunto de Salas Comerciais',
                    'Conjunto de Unidades Comerciais',
                    'Conjunto Habitacional (Casas)',
                    'Conjunto Habitacional (Casas e Prédios)',
                    'Conjunto Habitacional (Prédios)',
                    'Loteamento',
                    'Prédio Comercial',
                    'Prédio de Apartamentos',
                    'Outro'
                  ],
                ),
                const SizedBox(height: 10),
                DropdownCustomizado(
                  name: 'utilizacao_imovel',
                  labelText: 'Utilização',
                  options: [
                    'Residencial',
                    'Comercial',
                    'Industrial',
                    'Institucional',
                    'Outro'
                  ],
                ),
                const SizedBox(height: 20),
                InformacoesAdicionais(formKey: _formKey),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
