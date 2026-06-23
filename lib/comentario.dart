import 'package:flutter/material.dart';

void main (List<String> arguments) {
  runApp(const Tarefa());
}

class Tarefa extends StatelessWidget {
  const Tarefa({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tarefa",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tarefa2",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(child: Row(
              children: [
                Expanded(flex: 2, child: Container(color: Colors.amber,)),
                Expanded(flex: 8, child: Column(
                  children: [
                    Expanded(flex: 2, child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(" Silvie", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                        Expanded(flex: 5, child: Text(" @machadocomida", style: TextStyle(color: Colors.grey))),
                        Expanded(flex: 1, child: Text(".", style: TextStyle(color: Colors.grey))),
                        Expanded(flex: 4, child: Text(" 10m", style: TextStyle(color: Colors.grey))),
                      ],
                    )),
                    Expanded(flex: 8, child: Row(
                      children: [
                        Expanded(flex: 8, child: Text(" omg have you heard about that thing?", style: TextStyle(color: Colors.black))),
                      ],
                    )),
                    Expanded(flex: 3, child:Row(
                      children: [
                        Expanded(child: Container(color: Colors.blue,)),
                        Expanded(child: Container(color: Colors.green,)),
                        Expanded(child: Container(color: Colors.red,)),
                        Expanded(child: Container(color: Colors.purple,)),        
                      ],
                    )),
                  ],
                )),
                Expanded(child: Container(color: Colors.pinkAccent,))
              ],
            ),),      
          ],
        ),
      ),
    );
  }
}