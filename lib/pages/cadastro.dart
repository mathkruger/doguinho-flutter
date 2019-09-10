import 'package:flutter/material.dart';
import 'package:teste_sqlite/models/cachorro.dart';
import 'package:teste_sqlite/pages/lista.dart';
import 'package:teste_sqlite/services/cachorro.service.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _service = new CachorroService();
  final _formKey = GlobalKey<FormState>();

  var nomeDog = new TextEditingController();
  var idadeDog = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo cachorro"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: nomeDog,
              decoration: InputDecoration(
                labelText: "Nome do dog",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Digite um nome válido';
                }

                return null;
              },
            ),
            TextFormField(
              controller: idadeDog,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Idade do dog",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Digite uma idade válida';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var dog = new Cachorro(name: nomeDog.text, age: int.parse(idadeDog.text));
                    await _service.inserir(dog);

                    Navigator.pop(
                      context
                    );
                  }
                },
                child: Text('Cadastrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}