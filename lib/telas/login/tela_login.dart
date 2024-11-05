import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../imoveis/tela_imoveis_home.dart';

class TelaLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo do app
              Image.asset(
                'assets/logo.png',
                height: 150,
              ),
              SizedBox(height: 20),
              // Texto de boas-vindas
              Text(
                'Bem vindo ao Quanto Vale',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // Formulário
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    // campo de login
                    FormBuilderTextField(
                      name: 'login',
                      decoration: InputDecoration(
                        labelText: 'CPF ou e-mail',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Este campo é obrigatório.'),
                      ]),
                    ),
                    SizedBox(height: 20),
                    // Campo de senha
                    FormBuilderTextField(
                      name: 'senha',
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Este campo é obrigatório.'),
                      ]),
                    ),
                    SizedBox(height: 10),
                    // Esqueci minha senha
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          // ação de "esqueci minha senha" (vazia por enquanto)
                        },
                        child: Row(
                        children: [
                          Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Primeiro acesso',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Botão de login
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TelaImoveisHome()),
                          );
                        } else {
                          print("Erro na validação");
                        }
                      },
                      child: Text('Entrar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
