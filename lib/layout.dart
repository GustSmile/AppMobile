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
          title: Text("Tarefa",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(flex:4,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Column(
                    children: [
                      Expanded(flex: 2,child: Container(color: Colors.green,),),
                      Expanded(flex: 2,child: Container(color: Colors.deepOrange,)),
                    ],
                  ),),
                  Expanded(flex:2, child: Column(
                    children: [
                      Expanded(child: Container(color: Colors.blue,),),
                      Expanded(flex:3, child: Row(
                        children: [
                          Expanded(child: Column(
                            children: [
                              Expanded(child: Container(color: Colors.brown,)),
                              Expanded(flex:2, child: Container(color: Colors.indigo,)),
                            ],
                          ),
                          ),
                          Expanded(child: Column(
                            children: [
                              Expanded(flex:2, child: Container(color: Colors.amber,)),
                              Expanded(child: Container(color: Colors.red,)),
                            ],
                          ),
                          ),
                        ],
                      ))
                    ],
                  
                  ))
                ],
              ),
            ),
            Expanded(child: Row(
              children: [
                Expanded(flex: 3, child: Container(color: Colors.pink,),),
                Expanded(child: Container(color: Colors.purple,))
              ],
            ),),
          ],
        ),
      ),
    );
  }
}