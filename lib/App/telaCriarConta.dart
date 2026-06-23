import 'package:flutter/material.dart';

class TelaCriarConta extends StatefulWidget {
  const TelaCriarConta({super.key});

  @override
  State<TelaCriarConta> createState() => _TelaCriarContaState();
}

class _TelaCriarContaState extends State<TelaCriarConta> {
  int _etapa = 1;

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
    'Segunda união'
  ];

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
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel("Nome Completo"),
        TextField(
          decoration: _inputDecoration("Digite seu nome completo"),
        ),
        const SizedBox(height: 20),
        _buildLabel("CPF"),
        TextField(
          keyboardType: TextInputType.number,
          decoration: _inputDecoration("000.000.000-00"),
        ),
        const SizedBox(height: 20),
        _buildLabel("Data de Nascimento"),
        TextField(
          keyboardType: TextInputType.datetime,
          decoration: _inputDecoration(
            "dd / mm / aaaa",
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
          ),
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
                    decoration: _inputDecoration("Selecione").copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    value: _sexoSelecionado,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                    items: _opcoesSexo.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _sexoSelecionado = newValue;
                      });
                    },
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
                    decoration: _inputDecoration("Selecione").copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    value: _estadoCivilSelecionado,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                    items: _opcoesEstadoCivil.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _estadoCivilSelecionado = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _etapa = 2;
            });
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
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel("E-mail"),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration("seu@email.com"),
        ),
        const SizedBox(height: 20),
        _buildLabel("Telefone"),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration("(00) 00000-0000"),
        ),
        const SizedBox(height: 20),
        _buildLabel("Senha"),
        TextField(
          obscureText: true,
          decoration: _inputDecoration("Crie uma senha"),
        ),
        const SizedBox(height: 20),
        _buildLabel("Confirmar Senha"),
        TextField(
          obscureText: true,
          decoration: _inputDecoration("Confirme sua senha"),
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
                  // Lógica para finalizar o cadastro
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    'lib/App/img/logo.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
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
                    // Retornar para a tela de login
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
