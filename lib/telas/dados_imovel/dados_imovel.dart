import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dev/modelos/proprietario.dart';
import 'package:dev/modelos/imovel.dart';

import '../documentos_anexos/documentos_anexos.dart';

import 'widgets/dropdown_customizado.dart';
import 'widgets/campo_texto_customizado.dart';
import 'widgets/informacoes_adicionais.dart';
import '../widgets_compartilhados/popup_sucesso.dart';


class TelaDadosImovel extends StatefulWidget {
  const TelaDadosImovel({super.key});

  @override
  State<TelaDadosImovel> createState() => _TelaDadosImovelState();
}

class _TelaDadosImovelState extends State<TelaDadosImovel> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const CampoStringCustomizado(name: 'nome', labelText: 'Nome'),
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
                const Text(
                  'Dados do Imóvel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'cep_imovel', labelText: 'CEP'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'endereco_imovel', labelText: 'Endereço'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'numero_imovel', labelText: 'Número'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'complemento_imovel', labelText: 'Complemento'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'bairro_imovel', labelText: 'Bairro'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'cidade_imovel', labelText: 'Cidade'),
                const SizedBox(height: 10),
                const CampoStringCustomizado(
                    name: 'estado_imovel', labelText: 'Estado'),
                const SizedBox(height: 20),
                const Text(
                  'Especificação do imóvel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const DropdownCustomizado(
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
                const DropdownCustomizado(
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
                const DropdownCustomizado(
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
                Center( child:
                ElevatedButton(

                  child: const Text('Enviar informações'),
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final formDataValue = _formKey.currentState!.value;

                      // verificar se há valor "Outro" e inclui-lo se sim
                      String tipoImovel = '';
                      String agrupamentoImovel = '';
                      String utilizacaoImovel = '';

                      if (formDataValue['tipo_imovel'] == 'Outro') {
                        tipoImovel = formDataValue['tipo_imovel_outro'];
                      } else {
                        tipoImovel = formDataValue['tipo_imovel'];
                      }
                      if (formDataValue['agrupamento_imovel'] == 'Outro') {
                        agrupamentoImovel =
                            formDataValue['agrupamento_imovel_outro'];
                      } else {
                        agrupamentoImovel = formDataValue['agrupamento_imovel'];
                      }
                      if (formDataValue['utilizacao_imovel'] == 'Outro') {
                        utilizacaoImovel =
                            formDataValue['utilizacao_imovel_outro'];
                      } else {
                        utilizacaoImovel = formDataValue['utilizacao_imovel'];
                      }

                      Proprietario proprietario = Proprietario(
                        nome: formDataValue['nome'],
                        cep: formDataValue['cep'],
                        endereco: formDataValue['endereco'],
                        numero: formDataValue['numero'],
                        complemento: formDataValue['complemento'],
                        bairro: formDataValue['bairro'],
                        cidade: formDataValue['cidade'],
                        estado: formDataValue['estado'],
                        //imoveis: [],
                      );

                      Imovel imovel = Imovel(
                          cep: formDataValue['cep_imovel'],
                          endereco: formDataValue['endereco_imovel'],
                          numero: formDataValue['numero_imovel'],
                          complemento: formDataValue['complemento_imovel'],
                          bairro: formDataValue['bairro_imovel'],
                          cidade: formDataValue['cidade_imovel'],
                          estado: formDataValue['estado_imovel'],
                          tipo: tipoImovel,
                          agrupamento: agrupamentoImovel,
                          utilizacao: utilizacaoImovel);

                      // adiciona o imóvel ao proprietário
                      //proprietario.imoveis?.add(imovel);

                      print(imovel.bairro);
                      print(imovel.tipo);
                      print(imovel.agrupamento);
                      print(imovel.utilizacao);
                      print(proprietario.estado);
                      print(formDataValue['tipo_imovel']);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const PopupSucesso(
                            mensagem: 'Informações enviadas com sucesso.',
                            proxTela: TelaDocumentosAnexos(),
                          );
                        },
                      );
                    }
                  },
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
