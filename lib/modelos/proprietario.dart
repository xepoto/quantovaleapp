import 'package:dev/modelos/imovel.dart';

class Proprietario {
  String nome;
  String cep;
  String endereco;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  List<Imovel>? imoveis;

  Proprietario({
    required this.nome,
    required this.cep,
    required this.endereco,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.imoveis,
  });
}
