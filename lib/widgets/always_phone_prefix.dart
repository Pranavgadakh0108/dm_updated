import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? enabled;

  const CustomPhoneField({
    super.key,
    required this.controller,
    this.onChanged,
    this.validator,
    this.enabled,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      cursorColor: Colors.pink,
      enabled: widget.enabled,

      style: TextStyle(color: Colors.black),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, top: 14, bottom: 15),
          child: Text(
            "+91",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: const Icon(Icons.mobile_friendly),
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
