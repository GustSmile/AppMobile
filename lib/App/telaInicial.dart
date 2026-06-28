import 'package:flutter/material.dart';
import 'api_service.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  // Índice da aba atualmente selecionada
  int _abaSelecionada = 0;

  String _nomeUsuario = 'Carregando...';
  String _emailUsuario = 'Aguarde...';

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }

  Future<void> _carregarUsuario() async {
    final response = await ApiService.getUser();
    if (response['success']) {
      setState(() {
        _nomeUsuario = response['data']['name'] ?? 'Usuário';
        _emailUsuario = response['data']['email'] ?? '';
      });
    } else {
      setState(() {
        _nomeUsuario = 'Convidado';
        _emailUsuario = 'Faça login novamente';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTituloAppBar()),
        backgroundColor: const Color(0xFF6CE0B7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // O Drawer automaticamente coloca o ícone de três barrinhas (Hamburger) no canto esquerdo da AppBar
      drawer: _buildDrawer(),
      backgroundColor: const Color(0xFFFAFAFA),
      body: _buildCorpo(),
    );
  }

  String _getTituloAppBar() {
    switch (_abaSelecionada) {
      case 0:
        return 'Eventos e Acampamentos';
      case 1:
        return 'Minhas Inscrições';
      default:
        return 'Comunidade São Miguel';
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Cabeçalho do Menu com informações do usuário
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF6CE0B7),
            ),
            accountName: Text(
              _nomeUsuario,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(_emailUsuario),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Color(0xFF6CE0B7)),
            ),
          ),
          
          // Opções do Menu
          _buildItemMenu(
            icone: Icons.event,
            texto: 'Eventos e Acampamentos',
            indice: 0,
          ),
          _buildItemMenu(
            icone: Icons.assignment_turned_in,
            texto: 'Minhas inscrições',
            indice: 1,
          ),
          
          const Spacer(), // Empurra o botão de Sair para a parte inferior da tela
          const Divider(),
          
          // Botão de Sair
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
            title: const Text(
              'Sair',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              // Chama o logout na API e limpa o token local
              await ApiService.logout();
              
              if (!mounted) return;
              
              // Volta para a tela inicial limpando a pilha de rotas
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildItemMenu({required IconData icone, required String texto, required int indice}) {
    final isSelecionado = _abaSelecionada == indice;
    return ListTile(
      leading: Icon(
        icone,
        color: isSelecionado ? const Color(0xFF56D4A8) : Colors.grey[700],
      ),
      title: Text(
        texto,
        style: TextStyle(
          color: isSelecionado ? const Color(0xFF56D4A8) : Colors.black87,
          fontWeight: isSelecionado ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      selected: isSelecionado,
      selectedTileColor: const Color(0xFF6CE0B7).withOpacity(0.1), // Leve fundo verde quando selecionado
      onTap: () {
        setState(() {
          _abaSelecionada = indice;
        });
        Navigator.pop(context); // Fecha o menu lateral automaticamente
      },
    );
  }

  Widget _buildCorpo() {
    // Alterna o conteúdo principal da tela baseado na escolha do menu
    switch (_abaSelecionada) {
      case 0:
        return _telaEventos();
      case 1:
        return _telaInscricoes();
      default:
        return _telaEventos();
    }
  }

  // --- Telas temporárias vazias (Placeholders) ---

  Widget _telaEventos() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.event_available, size: 80, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Eventos e Acampamentos',
            style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Nenhum evento disponível no momento.',
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Widget _telaInscricoes() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.assignment, size: 80, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            'Minhas Inscrições',
            style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Você não possui inscrições ativas.',
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
