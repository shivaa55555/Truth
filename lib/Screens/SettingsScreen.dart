import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool hapticFeedback = true;
  bool animationsEnabled = true;
  double hueValue = 280.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Appearance'),
          SettingsCard(
            children: [
              SettingsRow(
                icon: Icons.color_lens,
                title: 'Theme Color',
                trailing: SizedBox(
                  width: 100,
                  child: Slider(
                    value: hueValue,
                    min: 0,
                    max: 360,
                    divisions: 12,
                    onChanged: (value) {
                      setState(() => hueValue = value);
                    },
                    activeColor:
                        HSLColor.fromAHSL(1, hueValue, 1, 0.5).toColor(),
                  ),
                ),
              ),
              SettingsRow(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) => setState(() => isDarkMode = value),
                ),
              ),
            ],
          ),
          const SectionHeader(title: 'Preferences'),
          SettingsCard(
            children: [
              SettingsRow(
                icon: Icons.vibration,
                title: 'Haptic Feedback',
                trailing: Switch(
                  value: hapticFeedback,
                  onChanged: (value) => setState(() => hapticFeedback = value),
                ),
              ),
              SettingsRow(
                icon: Icons.animation,
                title: 'Animations',
                trailing: Switch(
                  value: animationsEnabled,
                  onChanged: (value) =>
                      setState(() => animationsEnabled = value),
                ),
              ),
            ],
          ),
          const SectionHeader(title: 'Account'),
          SettingsCard(
            children: [
              SettingsRow(
                icon: Icons.delete,
                title: 'Reset Game Data',
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    showResetDialog();
                  },
                ),
              ),
              SettingsRow(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SectionHeader(title: 'About'),
          SettingsCard(
            children: [
              SettingsRow(
                icon: Icons.info,
                title: 'Version',
                trailing: Text(
                  '1.0.0',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              SettingsRow(
                icon: Icons.update,
                title: 'Check for Updates',
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checking for updates...')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Game Data?'),
        content: const Text(
          'This will clear all your game history, stats, and preferences. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Game data reset successfully')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(children: children),
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
