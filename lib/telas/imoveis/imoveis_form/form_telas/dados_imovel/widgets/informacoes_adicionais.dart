import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'campo_int_customizado.dart';

class InformacoesAdicionais extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;

  const InformacoesAdicionais({Key? key, required this.formKey})
      : super(key: key);

  @override
  _InformacoesAdicionaisState createState() => _InformacoesAdicionaisState();
}

class _InformacoesAdicionaisState extends State<InformacoesAdicionais> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações Adicionais',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FormBuilderRadioGroup<String>(
              initialValue: 'Não',
              name: 'usar_tabela',
              decoration: const InputDecoration(
                labelText: 'Usar tabela Ross Heidecke?',
                border: InputBorder.none,
              ),
              options: const [
                FormBuilderFieldOption(value: 'Sim', child: Text('Sim')),
                FormBuilderFieldOption(value: 'Não', child: Text('Não')),
              ],
              validator: FormBuilderValidators.required(
                errorText: 'Este campo é obrigatório',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (widget.formKey.currentState?.fields['usar_tabela']?.value ==
            'Sim') ...[
          const CampoIntCustomizado(
            name: 'idade_imovel',
            labelText: 'Idade do imóvel (aparente)',
          ),
          const SizedBox(height: 10),
          const CampoIntCustomizado(
            name: 'vida_util_imovel',
            labelText: 'Vida útil do imóvel',
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }
}
