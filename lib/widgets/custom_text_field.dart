import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final bool? enabled;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.hintText,
    this.icon,
    this.keyboardType,
    this.prefixText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
      enabled: widget.enabled,
      cursorColor: Colors.pink,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.black),
        prefixText: widget.prefixText,
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
        suffixIconColor: Colors.black,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 237, 237, 237),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
