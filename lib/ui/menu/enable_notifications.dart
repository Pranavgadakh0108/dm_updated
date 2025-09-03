import 'package:flutter/material.dart';

class EnableNotifications extends StatefulWidget {
  const EnableNotifications({super.key});

  @override
  State<EnableNotifications> createState() => _EnableNotificationsState();
}

class _EnableNotificationsState extends State<EnableNotifications> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            elevation: 3,
            title: const Text(
              "Notification Settings",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               // Notification toggle
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enable / Disable Notifications",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5),
                    Switch(
                      value: false,
                      onChanged: null,
                      inactiveTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.white,
                      activeColor: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
  }
}