import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  //IconData icon, String title, void Function()? onTap
  final IconData icon;
  final String title;
  final void Function()? onTap;
  
  const DrawerItem({super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.orange,
        child: Icon(icon, color: Colors.white, size: 25),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: onTap,
    );
  }
}