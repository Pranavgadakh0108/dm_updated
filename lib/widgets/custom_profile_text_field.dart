import 'package:flutter/material.dart';

class CustomProfileTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final bool readOnly;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomProfileTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.readOnly = false,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  @override
  State<CustomProfileTextFormField> createState() =>
      _CustomProfileTextFormFieldState();
}

class _CustomProfileTextFormFieldState
    extends State<CustomProfileTextFormField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      cursorColor: Colors.pink,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: _toggleObscureText,
              )
            : widget.icon != null
            ? Icon(widget.icon)
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
    );
  }
}
