import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DropdownCustomizado extends StatefulWidget {
  final String name;
  final String labelText;
  final List<String> options;

  const DropdownCustomizado({
    super.key,
    required this.name,
    required this.labelText,
    required this.options,
  });

  @override
  _DropdownCustomizadoState createState() => _DropdownCustomizadoState();
}

class _DropdownCustomizadoState extends State<DropdownCustomizado> {
  late String selectedValue;
  late TextEditingController otherController;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.options.isNotEmpty ? widget.options[0] : '';
    otherController = TextEditingController();
  }

  @override
  void dispose() {
    otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FormBuilderDropdown<String>(
              name: widget.name,
              decoration: InputDecoration(
                labelText: widget.labelText,
                border: InputBorder.none,
              ),
              items: widget.options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value ?? '';
                });
              },
              validator: FormBuilderValidators.required(
                errorText: 'Este campo é obrigatório',
              ),
            ),
          ),
        ),
        if (selectedValue == 'Outro') ...[
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FormBuilderTextField(
                name: '${widget.name}_outro',
                controller: otherController,
                decoration: const InputDecoration(
                  labelText: 'Digite aqui',
                  border: InputBorder.none,
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'Este campo é obrigatório',
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
