import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/theme_controller.dart';
import 'package:recipeapp/themes/themes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor =
        theme.brightness == Brightness.light ? Colors.black : Colors.white;
    final Color dividerColor = theme.brightness == Brightness.light
        ? Colors.grey.shade900
        : Colors.grey.shade400;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: theme.colorScheme.background,
          ),
          ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            children: [
              _buildSettingItem(
                title: 'Dark Mode',
                icon: Icons.dark_mode,
                toggle: true,
                textColor: textColor,
                onChanged: (value) {
                  Provider.of<ThemeController>(context, listen: false)
                      .toggleTheme();
                },
                switchValue:
                    Provider.of<ThemeController>(context).themeData == darkMode,
              ),
              Divider(color: dividerColor),
              _buildSettingItem(
                title: 'General Settings',
                isHeader: true,
                textColor: textColor,
              ),
              _buildSettingItem(
                title: 'Notifications',
                icon: Icons.notifications,
                toggle: true,
                textColor: textColor,
                onChanged: (value) {
                  // Handle notifications toggle
                },
                switchValue: false, // Initial value for notifications toggle
              ),
              _buildSettingItem(
                title: 'Language',
                icon: Icons.language,
                textColor: textColor,
              ),
              Divider(color: dividerColor),
              _buildSettingItem(
                title: 'Account Settings',
                isHeader: true,
                textColor: textColor,
              ),
              _buildSettingItem(
                title: 'Change Password',
                icon: Icons.lock,
                textColor: textColor,
              ),
              _buildSettingItem(
                title: 'Logout',
                icon: Icons.logout,
                onTap: () {
                  // Handle logout
                },
                textColor: textColor,
              ),
              _buildSettingItem(
                title: 'Delete Account',
                icon: Icons.delete,
                onTap: () {
                  // Handle delete account
                },
                textColor: textColor,
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
    required Color textColor,
    bool switchValue = true,
    ValueChanged<bool>? onChanged,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(color: textColor)),
      leading: icon != null ? Icon(icon, color: textColor) : null,
      trailing: isHeader
          ? null
          : toggle
              ? Switch(
                  value: switchValue,
                  onChanged: onChanged,
                )
              : Icon(Icons.arrow_forward_ios, color: textColor),
      onTap: onTap,
    );
  }
}
