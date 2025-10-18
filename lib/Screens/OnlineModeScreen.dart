import 'package:flutter/material.dart';
import 'roomscreen.dart';

class OnlineModeScreen extends StatelessWidget {
  const OnlineModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Multiplayer'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Play with Friends',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose how you want to play',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  GameOptionCard(
                    icon: Icons.add_circle,
                    title: 'Host Game',
                    subtitle: 'Create a new room and invite friends',
                    buttonText: 'Create Room',
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomScreen(isHost: true),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GameOptionCard(
                    icon: Icons.search,
                    title: 'Find Room',
                    subtitle: 'Join public rooms with active players',
                    buttonText: 'Browse Rooms',
                    color: Colors.blue,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Room browser coming soon!'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GameOptionCard(
                    icon: Icons.code,
                    title: 'Join by Code',
                    subtitle: 'Enter a room code to join private game',
                    buttonText: 'Enter Code',
                    color: Colors.orange,
                    onTap: () {
                      showJoinCodeDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showJoinCodeDialog(BuildContext context) {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Room by Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the 6-digit room code provided by the host'),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Room Code',
                border: OutlineInputBorder(),
                hintText: 'e.g., A1B2C3',
              ),
              maxLength: 6,
              textCapitalization: TextCapitalization.characters,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (codeController.text.length == 6) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoomScreen(isHost: false),
                  ),
                );
              }
            },
            child: const Text('Join Room'),
          ),
        ],
      ),
    );
  }
}

class GameOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color color;
  final VoidCallback onTap;

  const GameOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withAlpha(40),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
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
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
