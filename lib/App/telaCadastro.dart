import 'package:flutter/material.dart';
import 'formatters.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  int _etapa = 1;
  bool _obscureSenha = true;
  bool _obscureConfirmarSenha = true;

  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  String? _sexoSelecionado;
  String? _estadoCivilSelecionado;

  final List<String> _opcoesSexo = ['Masculino', 'Feminino'];
  final List<String> _opcoesEstadoCivil = [
    'Solteiro',
    'Namorando',
    'União estável',
    'Casado',
    'Viúvo',
    'Separado',
    'Divorciado',
    'Segunda união',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dataNascimentoController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  bool _isDateValid(String dateString) {
    if (dateString.length != 10) return false;
    
    final parts = dateString.split('/');
    if (parts.length != 3) return false;
    
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    
    if (day == null || month == null || year == null) return false;
    
    // O Dart lida nativamente com datas incorretas fazendo um "overflow"
    // Ex: DateTime(2023, 2, 29) vira 1º de Março de 2023.
    // Portanto, basta criar a data e verificar se o ano, mês e dia 
    // gerados são EXATAMENTE iguais aos digitados.
    final parsedDate = DateTime(year, month, day);
    
    if (parsedDate.year != year || 
        parsedDate.month != month || 
        parsedDate.day != day) {
      return false; 
    }
    
    if (year < 1900 || parsedDate.isAfter(DateTime.now())) return false;
    
    return true;
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF56D4A8)),
      ),
      filled: true,
      fillColor: const Color(0xFFFAFAFA),
      suffixIcon: suffixIcon,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabel("Nome Completo"),
          TextFormField(
            controller: _nomeController,
            textCapitalization: TextCapitalization.words,
            decoration: _inputDecoration("Digite seu nome completo"),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Campo obrigatório';
              final parts = value.trim().split(RegExp(r'\s+'));
              if (parts.length < 2) return 'Digite pelo menos nome e sobrenome';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildLabel("CPF"),
          TextFormField(
            controller: _cpfController,
            keyboardType: TextInputType.number,
            inputFormatters: [CpfInputFormatter()],
            decoration: _inputDecoration("000.000.000-00"),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (value.length < 14) return 'CPF inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildLabel("Data de Nascimento"),
          TextFormField(
            controller: _dataNascimentoController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [DataInputFormatter()],
            decoration: _inputDecoration(
              "dd/mm/aaaa",
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
                onPressed: () => _selecionarData(context),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (!_isDateValid(value)) return 'Data inválida';
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLabel("Sexo"),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: _inputDecoration("Selecione").copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      value: _sexoSelecionado,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                      items: _opcoesSexo.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _sexoSelecionado = newValue;
                        });
                      },
                      validator: (value) => value == null ? 'Obrigatório' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLabel("Estado Civil"),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: _inputDecoration("Selecione").copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      value: _estadoCivilSelecionado,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                      items: _opcoesEstadoCivil.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _estadoCivilSelecionado = newValue;
                        });
                      },
                      validator: (value) => value == null ? 'Obrigatório' : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_formKeyStep1.currentState!.validate()) {
                setState(() {
                  _etapa = 2;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6CE0B7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Próximo",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabel("E-mail"),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration("seu@email.com"),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'E-mail inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildLabel("Telefone"),
          TextFormField(
            controller: _telefoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [TelefoneInputFormatter()],
            decoration: _inputDecoration("(00) 00000-0000"),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (value.length < 14) return 'Telefone inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildLabel("Senha"),
          TextFormField(
            controller: _senhaController,
            obscureText: _obscureSenha,
            decoration: _inputDecoration(
              "Crie uma senha",
              suffixIcon: TextButton(
                onPressed: () {
                  setState(() {
                    _obscureSenha = !_obscureSenha;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  _obscureSenha ? "Mostrar" : "Ocultar",
                  style: const TextStyle(
                    color: Color(0xFF56D4A8),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (value.contains(' ')) return 'A senha não pode conter espaços';
              if (value.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildLabel("Confirmar Senha"),
          TextFormField(
            controller: _confirmarSenhaController,
            obscureText: _obscureConfirmarSenha,
            decoration: _inputDecoration(
              "Confirme sua senha",
              suffixIcon: TextButton(
                onPressed: () {
                  setState(() {
                    _obscureConfirmarSenha = !_obscureConfirmarSenha;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  _obscureConfirmarSenha ? "Mostrar" : "Ocultar",
                  style: const TextStyle(
                    color: Color(0xFF56D4A8),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (value.contains(' ')) return 'A senha não pode conter espaços';
              if (value != _senhaController.text) return 'As senhas não coincidem';
              return null;
            },
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _etapa = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEEEEEE),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Voltar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKeyStep2.currentState!.validate()) {
                      // Lógica para finalizar o cadastro
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cadastro finalizado com sucesso!')),
                      );
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6CE0B7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Finalizar Cadastro",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Criar Conta",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _etapa == 1
                      ? "Etapa 1: Seus dados básicos"
                      : "Etapa 2: Contato e segurança",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _etapa == 1 ? _buildStep1() : _buildStep2(),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: "Já tem uma conta? ",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Faça login",
                          style: TextStyle(
                            color: Color(0xFFB79A59),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
