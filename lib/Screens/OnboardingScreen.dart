// File: lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'permissionsscreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Play Truth or Dare with Friends!',
      'description':
          'Experience fun questions and challenges with your friends in real-time.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'AI Generated Prompts (Coming Soon)',
      'description':
          'Get creative and unexpected prompts powered by artificial intelligence.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Easy Room Creation & Joining',
      'description':
          'Create rooms instantly or join existing ones with a simple code.',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _goToPermissions();
    }
  }

  void _goToPermissions() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PermissionsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button - top right
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToPermissions,
                child: const Text('Skip'),
              ),
            ),

            // PageView for slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image - placeholder
                        Image.asset(
                          data['image']!,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 40),

                        // Title
                        Text(
                          data['title']!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // Description
                        Text(
                          data['description']!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom section - dots and button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Page indicators
                  ...List.generate(
                    _onboardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.deepPurple
                            : Colors.grey,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Continue button
                  ElevatedButton(
                    onPressed: _nextPage,
                    child: Text(
                      _currentPage == _onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
