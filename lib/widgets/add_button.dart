import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final void Function()? onPressed;
  final String data;

  const AddButton({super.key, this.onPressed, required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13,
          vertical: MediaQuery.of(context).size.height * 0.013,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        data,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
