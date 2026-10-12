// Lab 6.1 – Responsive Hero & Heading Section
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 3: Responsive Hero & Heading Section
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find a Movie',
            style: TextStyle(
              fontSize: isWideScreen ? 32 : 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Explore movies by genre, title, and year',
            style: TextStyle(
              fontSize: isWideScreen ? 16 : 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
