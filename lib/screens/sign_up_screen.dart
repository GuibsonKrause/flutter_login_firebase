import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailC  = TextEditingController();
  final _passC   = TextEditingController();
  final _confirmC= TextEditingController();
  final _auth    = AuthService();

  bool _loading = false;

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final user = await _auth.signUp(_emailC.text, _passC.text);
      if (!mounted) return;
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar conta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(label: 'E-mail', controller: _emailC),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Senha (≥6)',
                controller: _passC,
                obscure: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo obrigatório';
                  if (v.length < 6) return 'Mínimo de 6 caracteres';
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Confirmar senha',
                controller: _confirmC,
                obscure: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo obrigatório';
                  if (v != _passC.text) return 'Senhas diferentes';
                  return null;
                },
              ),
              SizedBox(height: 32),
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _register,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
