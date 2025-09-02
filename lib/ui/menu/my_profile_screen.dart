import 'package:dmboss/provider/update_user_provider.dart';
import 'package:dmboss/widgets/custom_profile_text_field.dart';
import 'package:dmboss/widgets/orange_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String phoneNumber;
  const ProfilePage({
    super.key,
    required this.username,
    required this.phoneNumber,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.text = widget.username;

      final provider = Provider.of<ProfileUpdateProvider>(
        context,
        listen: false,
      );
      provider.setName(widget.username);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    Provider.of<ProfileUpdateProvider>(context, listen: false);
    return _nameController.text != widget.username ||
        _newPasswordController.text.isNotEmpty ||
        _confirmPasswordController.text.isNotEmpty;
  }

  void _resetForm() {
    _nameController.text = widget.username;
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    final provider = Provider.of<ProfileUpdateProvider>(context, listen: false);
    provider.setName(_nameController.text);
    provider.setNewPassword('');
    provider.setConfirmPassword('');
    provider.clearMessages();
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProfileUpdateProvider>(
        context,
        listen: false,
      );

      // Update provider values from controllers
      provider.setName(_nameController.text);
      provider.setNewPassword(_newPasswordController.text);
      provider.setConfirmPassword(_confirmPasswordController.text);

      await provider.updateProfile(context);

      // Clear password fields on success if provider indicates success
      if (provider.successMessage != null && mounted) {
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileUpdateProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            elevation: 3,
            title: const Text(
              "My Profile",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              if (_hasChanges)
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: _resetForm,
                  tooltip: 'Reset changes',
                ),
            ],
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

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Manage profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),

                      CustomProfileTextFormField(
                        controller: _nameController,
                        hintText: "Name",
                        icon: Icons.person,
                        onChanged: (value) => provider.setName(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      CustomProfileTextFormField(
                        controller: TextEditingController(
                          text: widget.phoneNumber,
                        ),
                        hintText: "Phone",
                        icon: Icons.phone,
                        readOnly: true,
                      ),

                      const SizedBox(height: 30),
                      const Text(
                        "Change Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),

                      CustomProfileTextFormField(
                        controller: _newPasswordController,
                        hintText: "New Password",
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (value) => provider.setNewPassword(value),
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      CustomProfileTextFormField(
                        controller: _confirmPasswordController,
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (value) =>
                            provider.setConfirmPassword(value),
                        validator: (value) {
                          final newPassword = _newPasswordController.text;
                          if (newPassword.isNotEmpty) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != newPassword) {
                              return "Passwords do not match";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      if (_hasChanges) ...[
                        provider.isLoading
                            ? const CircularProgressIndicator()
                            : OrangeButton(
                                text: "Update Profile",
                                onPressed: _updateProfile,
                              ),
                        const SizedBox(height: 15),

                        OutlinedButton(
                          onPressed: _resetForm,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            side: const BorderSide(color: Colors.grey),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ] else
                        Text(
                          "No changes to update",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
