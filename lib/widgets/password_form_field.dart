import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final void Function()? onTap;
  final String inputLabel;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? passwordValidator;

  const PasswordFormField({
    super.key,
    required this.inputLabel,
    required this.passwordValidator,
    required this.onChanged,
    required this.onTap,
    required this.focusNode,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: widget.inputLabel,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.passwordValidator,
    );
  }
}
