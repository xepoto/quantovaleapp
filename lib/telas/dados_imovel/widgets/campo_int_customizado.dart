import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CampoIntCustomizado extends StatelessWidget {
  final String name;
  final String labelText;

  const CampoIntCustomizado({
    super.key,
    required this.name,
    required this.labelText,
  });

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
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.integer(
              errorText: 'Digite um número inteiro válido',
            ),
            FormBuilderValidators.required(
              errorText: 'Este campo é obrigatório',
            ),
          ]),
        ),
      ),
    );
  }
}
