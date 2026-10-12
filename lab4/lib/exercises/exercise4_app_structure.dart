import 'package:flutter/material.dart';

class AppStructureThemeDemo extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const AppStructureThemeDemo({
    super.key,
    required this.themeModeNotifier,
  });

  @override
  State<AppStructureThemeDemo> createState() => _AppStructureThemeDemoState();
}

class _AppStructureThemeDemoState extends State<AppStructureThemeDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.themeModeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure & Theme'),
        actions: [
          Row(
            children: [
              const Text(
                'Dark',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 4),
              Switch(
                value: isDark,
                onChanged: (bool value) {
                  setState(() {
                    widget.themeModeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  });
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is a simple screen with theme toggle.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              if (_counter > 0) ...[
                const SizedBox(height: 16),
                Text(
                  'FAB pressed: $_counter times',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment counter',
        onPressed: () {
          setState(() {
            _counter++;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('FAB pressed! (Count: $_counter)'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
