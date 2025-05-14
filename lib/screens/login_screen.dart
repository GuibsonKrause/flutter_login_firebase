import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC  = TextEditingController();
  final _auth   = AuthService();

  bool _loading = false;

  void _login() async {
    // 1) Valida o formulário
    if (!_formKey.currentState!.validate()) {
      print('Validação falhou'); // debug
      return;
    }

    // 2) Mostra o indicador de loading
    setState(() => _loading = true);
    print('Iniciando login para ${_emailC.text}'); // debug

    try {
      final user = await _auth.signIn(_emailC.text, _passC.text);
      print('Firebase retornou: $user'); // debug

      // 3) Garante que o widget ainda exista antes de navegar
      if (!mounted) {
        print('⚠Widget desmontado antes da navegação');
        return;
      }

      if (user != null) {
        print('➡Navegando para /home'); // debug
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        print('user == null, não navega');
      }
    } catch (e) {
      print('Erro no login: $e'); // debug
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(label: 'E-mail', controller: _emailC),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Senha',
                controller: _passC,
                obscure: true,
              ),
              SizedBox(height: 32),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
