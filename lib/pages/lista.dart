import 'package:flutter/material.dart';
import 'package:teste_sqlite/models/cachorro.dart';
import 'package:teste_sqlite/pages/cadastro.dart';
import 'package:teste_sqlite/services/cachorro.service.dart';

class Lista extends StatefulWidget {
  var items = new List<Cachorro>();

  Lista() {
    items = [];
  }

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  var service = new CachorroService();

  _ListaState() {
    load();
  }

  Future load() async {
    var lista = await service.listar();

    setState(() {
      widget.items = lista;
    });
  }

  apagar(int id) async {
    service.apagar(id);

    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de cachorros"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (ctxt, index) {
              final item = widget.items[index];

              return Dismissible( 
                child: ListTile(
                  title: Text("Nome: " + item.name),
                  subtitle: Text("Idade: " + item.age.toString()),
                ),
                background: Container(color: Colors.red.withOpacity(0.2),),
                key: Key(item.id.toString()),
                onDismissed: (direction) {
                  apagar(item.id);
                },
              );
            },
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cadastro()),
          );
        },
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
      ),
    );
  }
}