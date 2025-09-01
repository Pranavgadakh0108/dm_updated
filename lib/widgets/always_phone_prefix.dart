// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AlwaysPrefixPhoneFormatter extends TextInputFormatter {
//   final String prefix = '+91 ';

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // If user tries to delete the prefix, reset it
//     if (!newValue.text.startsWith(prefix)) {
//       return TextEditingValue(
//         text: prefix,
//         selection: TextSelection.collapsed(offset: prefix.length),
//       );
//     }
//     // Prevent cursor from going before prefix
//     if (newValue.selection.baseOffset < prefix.length) {
//       return TextEditingValue(
//         text: newValue.text,
//         selection: TextSelection.collapsed(offset: prefix.length),
//       );
//     }
//     return newValue;
//   }
// }

// // class CustomPhoneField extends StatelessWidget {
// //   final TextEditingController controller;
// //   final void Function(String)? onChanged;
// //   final String? Function(String?)? validator;

// //   const CustomPhoneField({super.key, required this.controller, this.onChanged, this.validator});

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextFormField(
// //       controller: controller..text = '+91 ',
// //       keyboardType: TextInputType.phone,
// //       cursorColor: Colors.pink,
// //       inputFormatters: [AlwaysPrefixPhoneFormatter()],
// //       decoration: InputDecoration(
// //         suffixIcon: const Icon(Icons.mobile_friendly),
// //         suffixIconColor: Colors.black,
// //         // contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
// //         contentPadding: EdgeInsets.symmetric(
// //           horizontal: MediaQuery.of(context).size.width * 0.04,
// //           vertical: MediaQuery.of(context).size.height * 0.015,
// //         ),
// //         filled: true,
// //         fillColor: const Color.fromARGB(255, 237, 237, 237),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           borderSide: BorderSide.none,
// //         ),
// //       ),
// //       onChanged: onChanged,
// //       validator: validator,
// //     );
// //   }
// // }

// class CustomPhoneField extends StatelessWidget {
//   final TextEditingController controller;
//   final void Function(String)? onChanged;
//   final String? Function(String?)? validator;

//   const CustomPhoneField({super.key, required this.controller, this.onChanged, this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.phone,
//       cursorColor: Colors.pink,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(10), // Only 10 digits after +91
//       ],
//       decoration: InputDecoration(
//         prefixText: '+91 ',
//         prefixStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         suffixIcon: const Icon(Icons.mobile_friendly),
//         suffixIconColor: Colors.black,
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.04,
//           vertical: MediaQuery.of(context).size.height * 0.015,
//         ),
//         filled: true,
//         fillColor: const Color.fromARGB(255, 237, 237, 237),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       onChanged: onChanged,
//       validator: validator,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlwaysPrefixPhoneFormatter extends TextInputFormatter {
  final String prefix = '+91';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the text is empty or doesn't start with prefix, add it
    if (newValue.text.isEmpty) {
      return TextEditingValue(
        text: prefix,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }
    
    // If user tries to delete the prefix, keep it
    if (!newValue.text.startsWith(prefix)) {
      // If user is pasting or entering text that includes the prefix
      if (newValue.text.contains(prefix)) {
        final text = newValue.text.replaceAll(prefix, '');
        return TextEditingValue(
          text: '$prefix$text',
          selection: TextSelection.collapsed(offset: newValue.text.length),
        );
      }
      
      return TextEditingValue(
        text: prefix + newValue.text.replaceAll(RegExp(r'[^0-9]'), ''),
        selection: TextSelection.collapsed(offset: (prefix + newValue.text.replaceAll(RegExp(r'[^0-9]'), '')).length),
      );
    }
    
    // Filter out non-digit characters after the prefix
    final String newText = prefix + newValue.text.substring(prefix.length).replaceAll(RegExp(r'[^0-9]'), '');
    
    // Prevent cursor from going before prefix
    if (newValue.selection.baseOffset < prefix.length) {
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }
    
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}

class CustomPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? enabled;

  const CustomPhoneField({super.key, required this.controller, this.onChanged, this.validator, this.enabled});

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  void initState() {
    super.initState();
    // Set initial value only once
    if (widget.controller.text.isEmpty) {
      widget.controller.text = '+91';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      cursorColor: Colors.pink,
      enabled: widget.enabled,
      inputFormatters: [AlwaysPrefixPhoneFormatter()],
      decoration: InputDecoration(
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