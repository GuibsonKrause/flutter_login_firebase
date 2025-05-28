import 'package:flutter/material.dart';

/// Campo de texto reutilizável com:
/// • Validação customizável (ou padrão)
/// • Teclado apropriado para e-mail e senha
/// • Ícone para mostrar/ocultar senha quando [obscure] = true
class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _hide;

  @override
  void initState() {
    super.initState();
    _hide = widget.obscure; // começa oculto somente se for campo de senha
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _hide,
      keyboardType: widget.keyboardType ??
          (widget.obscure
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress),
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: widget.obscure
            ? IconButton(
          icon: Icon(_hide ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _hide = !_hide),
        )
            : null,
      ),
      validator: widget.validator ??
              (v) {
            if (v == null || v.isEmpty) return 'Campo obrigatório';
            if (!widget.obscure && !v.contains('@')) return 'E-mail inválido';
            if (widget.obscure && v.length < 6) return 'Mínimo 6 caracteres';
            return null;
          },
    );
  }
}
