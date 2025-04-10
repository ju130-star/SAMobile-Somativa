import 'package:flutter/material.dart';  // Importa os widgets visuais 
 

void main() {
  runApp(MyApp()); // Função principal que inicia o app e chama o widget MyApp
}
 

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remove a faixa de debug 
      home: TelaAdd(),  // Define a tela inicial como TelaAdd.
    );
  }
}
 

// Classe que representa a tela de adicionar tarefa
class TelaAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estrutura básica de tela.

      appBar: AppBar(
        title: Text("IAJ Planner - Adicionar Tarefa",
        style: TextStyle(fontSize: 25, color: const Color(0xFF5C75FF)),
        ),
        backgroundColor: Color.fromARGB(255, 196, 206, 255),
      ),


      body: Padding( // Corpo da tela com espaçamento interno.
        padding: const EdgeInsets.all(16.0),  // Define espaçamento de 16 pixels em todos os lados.


        child: Column( // Organiza os widgets na vertical.
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda.


          children: [
            TextField( // Campo de texto para digitar o título da tarefa.
              decoration: InputDecoration(
                labelText: "Título da Tarefa", // Nome do campo.
                border: OutlineInputBorder(),  // Borda ao redor do campo.
              ),
            ),

            SizedBox(height: 10), // Espaçamento vertical entre os campos.


            TextField( // Campo de texto para a descrição da tarefa.
              decoration: InputDecoration(
                labelText: "Descrição",  // Nome do campo.
                border: OutlineInputBorder(),  // Borda ao redor.
              ),
              
              maxLines: 3, // Permite escrever em até 3 linhas.

            ),


            SizedBox(height: 20), // Espaço antes do botão.
            ElevatedButton( // Botão para adicionar a tarefa.
              onPressed: () {}, // Ação ao clicar (ainda vazia).
              child: Text("Adicionar"), // Texto dentro do botão.
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5C75FF),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Espaçamento interno do botão.
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar: BottomAppBar( // Barra inferior com ícones de navegação.
        color: Colors.grey[300],
        child: Row( // Linha de ícones.


          mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaça igualmente os ícones.


          children: [
            IconButton(icon: Icon(Icons.check), color: const Color(0xFF5C75FF), onPressed: () => Navigator.pushNamed(context, "/tarefas")),  // Ícone de tarefas.

            IconButton(icon: Icon(Icons.home), color: const Color(0xFF5C75FF), onPressed: () => Navigator.pushNamed(context, "/")),  // Ícone de home.

            FloatingActionButton(  // Botão flutuante central para adicionar tarefa.
              onPressed: () => Navigator.pushNamed(context, "/add"),
              backgroundColor: Color(0xFF5C75FF),
              child: Icon(Icons.add),
            ),

            IconButton(icon: Icon(Icons.settings), color: const Color(0xFF5C75FF), onPressed: () {}),  // Ícone de configurações.

            IconButton(icon: Icon(Icons.dark_mode), color: const Color(0xFF5C75FF), onPressed: () {}),  // Ícone de modo escuro.
          ],
        ),
      ),
    );
  }
}
 
 