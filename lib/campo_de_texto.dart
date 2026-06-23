import 'package:flutter/material.dart';

void main(List<String> arguments) {
  runApp(const Formulario());
}

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Campo de texto", home: Pensando());
  }
}

class Pensando extends StatefulWidget {
  const Pensando({super.key});

  @override
  State<Pensando> createState() => _PensandoState();
}

class _PensandoState extends State<Pensando> {
  @override
  // tela simples para testar
  // label, campo de texto e botão
  // ao apertar no botão, coloca o conteúdo
  // do cmapo de texto na label
  String conteudo = "";
  TextEditingController controlador = TextEditingController();

  void windows() {
    // atualizar tela
    setState(() {
      // coloca o conteúdo do campo de texto na variável
      conteudo = controlador.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Testando campo de texto")),
      body: Column(
        children: [
          Expanded(
            child: Card(
              margin: EdgeInsets.all(10),
              child: TextField(
                // objeto para controle de entrada
                controller: controlador,
                // tipo do teclado virtual
                keyboardType: TextInputType.text,
                // estilo do campo
                decoration: InputDecoration(
                  // tipo de borda
                  border: OutlineInputBorder(),
                  labelText: "Testando... ",
                  icon: Icon(
                    Icons.account_tree_sharp,
                    color: Colors.greenAccent,
                  ),
                ),
                // estilo do texto
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: windows,
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                textStyle: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text("Clique Aqui"),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Text(conteudo, style: TextStyle(fontSize: 40)),
            ),
          ),
        ],
      ),
    );
  }
}
