import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  String _language = 'English';
  String _theme = 'Light';

  final List<String> _languages = ['English', 'Vietnamese'];
  final List<String> _themes = ['Light', 'Dark', 'System'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Customize your app experience',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingOption(
                    title: 'Dark Mode',
                    subtitle: 'Enable dark theme',
                    trailing: Switch(
                      value: _darkMode,
                      onChanged: (value) {
                        setState(() {
                          _darkMode = value;
                        });
                      },
                      activeColor: const Color(0xFF2BA84A),
                    ),
                  ),
                  _buildDivider(),
                  _buildSettingOption(
                    title: 'Notifications',
                    subtitle: 'Enable push notifications',
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: const Color(0xFF2BA84A),
                    ),
                  ),
                  _buildDivider(),
                  _buildSettingOption(
                    title: 'Language',
                    subtitle: 'Select your preferred language',
                    trailing: DropdownButton<String>(
                      value: _language,
                      onChanged: (value) {
                        setState(() {
                          _language = value!;
                        });
                      },
                      items: _languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                      underline: const SizedBox(),
                    ),
                  ),
                  _buildDivider(),
                  _buildSettingOption(
                    title: 'Theme',
                    subtitle: 'Choose app theme',
                    trailing: DropdownButton<String>(
                      value: _theme,
                      onChanged: (value) {
                        setState(() {
                          _theme = value!;
                        });
                      },
                      items: _themes.map((theme) {
                        return DropdownMenuItem(
                          value: theme,
                          child: Text(theme),
                        );
                      }).toList(),
                      underline: const SizedBox(),
                    ),
                  ),
                  _buildDivider(),
                  _buildSettingOption(
                    title: 'Account Settings',
                    subtitle: 'Manage your account information',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account Settings tapped')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildSettingOption(
                    title: 'Privacy Policy',
                    subtitle: 'Read our privacy policy',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy Policy tapped')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildSettingOption(
                    title: 'Terms of Service',
                    subtitle: 'Read our terms of service',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Terms of Service tapped')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2BA84A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }

  void _saveSettings() {
    // Here you would save the settings to backend or local storage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved successfully')),
    );
    Navigator.pop(context);
  }
}