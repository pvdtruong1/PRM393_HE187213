import 'package:flutter/material.dart';
import 'exercises/exercise1_core_widgets.dart';
import 'exercises/exercise2_input_controls.dart';
import 'exercises/exercise3_layout_demo.dart';
import 'exercises/exercise4_app_structure.dart';
import 'exercises/exercise5_common_fixes.dart';

final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Lab 4 – Flutter UI Fundamentals',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF9F9FB),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black87,
              centerTitle: false,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121214),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              centerTitle: false,
            ),
          ),
          home: const MainMenuScreen(),
        );
      },
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_MenuItem> menuItems = [
      _MenuItem(
        title: 'Exercise 1 – Core Widgets Demo',
        builder: (_) => const CoreWidgetsDemo(),
      ),
      _MenuItem(
        title: 'Exercise 2 – Input Controls Demo',
        builder: (_) => const InputControlsDemo(),
      ),
      _MenuItem(
        title: 'Exercise 3 – Layout Demo',
        builder: (_) => const LayoutDemo(),
      ),
      _MenuItem(
        title: 'Exercise 4 – App Structure & Theme',
        builder: (_) => AppStructureThemeDemo(themeModeNotifier: themeModeNotifier),
      ),
      _MenuItem(
        title: 'Exercise 5 – Common UI Fixes',
        builder: (_) => const CommonUiFixesDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab 4 – Flutter UI Fundamentals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          itemCount: menuItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Material(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF23232A)
                  : const Color(0xFFF1F0F5),
              borderRadius: BorderRadius.circular(16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: item.builder),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 18.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xFF222222),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final WidgetBuilder builder;

  const _MenuItem({
    required this.title,
    required this.builder,
  });
}
