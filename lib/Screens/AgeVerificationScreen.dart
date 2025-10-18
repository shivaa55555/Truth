// File: lib/screens/age_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboardingscreen.dart';

class AgeVerificationScreen extends StatefulWidget {
  const AgeVerificationScreen({super.key});

  @override
  State<AgeVerificationScreen> createState() => _AgeVerificationScreenState();
}

class _AgeVerificationScreenState extends State<AgeVerificationScreen> {
  final TextEditingController _ageController = TextEditingController();
  bool _isChecking = false;

  Future<void> _verifyAge() async {
    if (_ageController.text.isEmpty) return;

    setState(() => _isChecking = true);

    final age = int.tryParse(_ageController.text) ?? 0;

    if (age >= 18) {
      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAgeVerified', true);

      // Navigate to onboarding
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } else {
      // Show alert - 18+ only
      _showAgeAlert();
    }

    setState(() => _isChecking = false);
  }

  void _showAgeAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Age Verification'),
        content: const Text('This app is for users 18 years and older only.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Instruction text - English
            const Text(
              'You must be 18+ to play TruthSpice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Age input field
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter your age',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),

            // Verify button
            ElevatedButton(
              onPressed: _isChecking ? null : _verifyAge,
              child: _isChecking
                  ? const CircularProgressIndicator()
                  : const Text('Verify Age'),
            ),
          ],
        ),
      ),
    );
  }
}
