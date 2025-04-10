// Importa o pacote Flutter Material para acessar widgets padrão como Scaffold, AppBar, etc.
import 'package:flutter/material.dart';

// Função principal que inicia o app chamando MyApp
void main() {
  runApp(MyApp());
}

// Notificador que controla o modo do tema (claro ou escuro) de forma reativa
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

// Classe principal do app - Stateless pois não precisa gerenciar estado interno
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder reconstrói a UI quando o themeNotifier muda
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Remove a faixa de debug
          
          // Define o tema claro
          theme: ThemeData.light(),

          // Define o tema escuro personalizado
          darkTheme: ThemeData.dark().copyWith(
            cardColor: Colors.grey[850], // Cor dos containers/card escuros
            appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]), // AppBar escura
            scaffoldBackgroundColor: Colors.black, // Fundo da tela escura
          ),

          // Define qual tema usar com base no themeNotifier
          themeMode: currentMode,

          // Primeira tela exibida no app
          home: ReportScreen(),
        );
      },
    );
  }
}

// Tela de relatórios - Stateless porque não precisa controlar estado
class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Verifica se o tema atual é escuro
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Barra superior com título e estilo adaptável ao tema
      appBar: AppBar(
        title: Text(
          "Relatórios",
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge!.color, // Cor adaptada ao tema
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Cor da AppBar
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color, // Cor do ícone do menu
        ),
      ),

      // Menu lateral com cabeçalho e itens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cabeçalho do Drawer com estilo temático
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[300],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 24,
                ),
              ),
            ),

            // Lista de opções do menu
            ListTile(title: Text("Configurações")),
            ListTile(title: Text("Notificações")),
            ListTile(title: Text("Temas")),
            ListTile(title: Text("Perfil")),
            ListTile(title: Text("Ajuda")),
          ],
        ),
      ),

      // Corpo principal da tela com título e grid de relatórios
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento em volta
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da seção
            Text(
              "Relatórios Gerais",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            SizedBox(height: 20), // Espaço vertical

            // Grid com os blocos de relatório
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 colunas
                crossAxisSpacing: 10, // Espaço horizontal entre os cards
                mainAxisSpacing: 10, // Espaço vertical entre os cards
                children: [
                  _buildReportBox(context, Icons.assignment, "Tarefas Pendentes", "Total de 8 tarefas pendentes"),
                  _buildReportBox(context, Icons.check_circle, "Tarefas Concluídas", "Total de 12 tarefas concluídas"),
                  _buildReportBox(context, Icons.calendar_today, "Atividades do Mês", "24 atividades registradas neste mês"),
                  _buildReportBox(context, Icons.warning, "Atrasos", "3 tarefas estão atrasadas"),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barra inferior com botões de navegação
      bottomNavigationBar: BottomAppBar(
        // Cor muda conforme o tema
        color: isDark ? Colors.deepPurple[900] : Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaçamento uniforme
          children: [
            IconButton(icon: Icon(Icons.check), onPressed: () {}), // Ícone de tarefa
            IconButton(icon: Icon(Icons.home), onPressed: () {}), // Ícone de home

            // Botão flutuante central
            FloatingActionButton(
              onPressed: () {}, // Ação ao pressionar
              backgroundColor: Colors.purple[300],
              child: Icon(Icons.add),
            ),

            IconButton(icon: Icon(Icons.settings), onPressed: () {}), // Ícone de configurações

            // Botão para alternar o tema
            IconButton(
              icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: () {
                // Alterna entre tema claro e escuro
                themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
              },
              tooltip: "Alternar Tema",
            ),
          ],
        ),
      ),
    );
  }

  // Função reutilizável que constrói um card de relatório
  Widget _buildReportBox(BuildContext context, IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Cor do fundo do card conforme tema
        borderRadius: BorderRadius.circular(10), // Arredondamento dos cantos
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2), // Sombra suave
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 40), // Ícone principal
          SizedBox(height: 10), // Espaço
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
