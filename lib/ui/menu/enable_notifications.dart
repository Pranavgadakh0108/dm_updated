// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnableNotifications extends StatefulWidget {
  const EnableNotifications({super.key});

  @override
  State<EnableNotifications> createState() => _EnableNotificationsState();
}

class _EnableNotificationsState extends State<EnableNotifications> {
  bool _notificationsEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
  }

  // Load notification status from shared preferences
  Future<void> _loadNotificationStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading notification status: $e');
      setState(() {
        _notificationsEnabled = false;
        _isLoading = false;
      });
    }
  }

  // Save notification status to shared preferences
  Future<void> _saveNotificationStatus(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications_enabled', enabled);
    } catch (e) {
      print('Error saving notification status: $e');
    }
  }

  // Enable notifications
  Future<void> _enableNotifications() async {
    try {
      // Request permission
      final bool isAllowed = await AwesomeNotifications()
          .requestPermissionToSendNotifications();

      if (isAllowed) {
        setState(() {
          _notificationsEnabled = true;
        });
        await _saveNotificationStatus(true);

        // Start your notification polling service if you have one
        // NotificationPollingService.startPolling();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notifications enabled'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Permission denied. Please enable notifications in app settings.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error enabling notifications: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error enabling notifications'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Disable notifications
  Future<void> _disableNotifications() async {
    try {
      // Cancel all pending notifications
      await AwesomeNotifications().cancelAll();

      setState(() {
        _notificationsEnabled = false;
      });
      await _saveNotificationStatus(false);

      // Stop your notification polling service if you have one
      // NotificationPollingService.stopPolling();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notifications disabled'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      print('Error disabling notifications: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error disabling notifications'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Toggle notifications
  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      await _enableNotifications();
    } else {
      await _disableNotifications();
    }
  }

  // Check current notification status
  Future<void> _checkNotificationStatus() async {
    try {
      final bool isAllowed = await AwesomeNotifications()
          .isNotificationAllowed();
      setState(() {
        _notificationsEnabled = isAllowed;
      });
      await _saveNotificationStatus(isAllowed);
    } catch (e) {
      print('Error checking notification status: $e');
    }
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Notification toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Enable / Disable Notifications",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Switch(
                        value: _notificationsEnabled,
                        onChanged: _toggleNotifications,
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.white,
                        activeColor: Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Additional information
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notification Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _notificationsEnabled
                              ? '✓ Notifications are enabled\n✓ You will receive alerts for new entries\n✓ Sound and vibration enabled'
                              : '✗ Notifications are disabled\n✗ You will not receive any alerts\n✗ Enable to stay updated',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Refresh status button
                  ElevatedButton.icon(
                    onPressed: _checkNotificationStatus,
                    icon: Icon(Icons.refresh),
                    label: Text('Refresh Notification Status'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // App notification settings redirect (optional)
                  TextButton(
                    onPressed: () {
                      // This will open the app's notification settings in system
                      AwesomeNotifications().showNotificationConfigPage();
                    },
                    child: Text(
                      'Open System Notification Settings',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
