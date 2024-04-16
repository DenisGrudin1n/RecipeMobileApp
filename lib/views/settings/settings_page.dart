import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: kWhite),
        ),
        backgroundColor: kPrimary,
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: kPrimary,
          ),
          ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            children: [
              _buildSettingItem(
                title: 'Dark Mode',
                icon: Icons.dark_mode,
                toggle: true,
              ),
              const Divider(),
              _buildSettingItem(
                title: 'General Settings',
                isHeader: true,
              ),
              _buildSettingItem(
                title: 'Notifications',
                icon: Icons.notifications,
                toggle: true,
              ),
              _buildSettingItem(
                title: 'Logout',
                icon: Icons.logout,
                onTap: () {
                  // Handle logout
                },
              ),
              _buildSettingItem(
                title: 'Delete Account',
                icon: Icons.delete,
                onTap: () {
                  // Handle delete account
                },
              ),
              const Divider(),
              _buildSettingItem(
                title: 'Account Settings',
                isHeader: true,
              ),
              _buildSettingItem(
                title: 'Language',
                icon: Icons.language,
              ),
              _buildSettingItem(
                title: 'Change Password',
                icon: Icons.lock,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    IconData? icon,
    bool toggle = false,
    bool isHeader = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: kWhite)),
      leading: icon != null ? Icon(icon, color: kWhite) : null,
      trailing: isHeader
          ? null
          : toggle
              ? Switch(
                  value: true, // Change this to control the toggle
                  onChanged: (value) {
                    // Handle toggle change
                  },
                )
              : const Icon(Icons.arrow_forward_ios, color: kWhite),
      onTap: onTap,
    );
  }
}
