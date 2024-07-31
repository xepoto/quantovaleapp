import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CampoStringCustomizado extends StatelessWidget {
  final String name;
  final String labelText;

  const CampoStringCustomizado({
    Key? key,
    required this.name,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FormBuilderTextField(
          name: name,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: 'Este campo é obrigatório',
            ),
            // Adicionar outras validações aqui se necessário
          ]),
        ),
      ),
    );
  }
}
