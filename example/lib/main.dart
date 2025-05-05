import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/stat_card_screen.dart';
import 'screens/pie_summary_screen.dart';
import 'screens/activity_bar_screen.dart';

void main() {
  runApp(const DashboardExampleApp());
}

class DashboardExampleApp extends StatefulWidget {
  const DashboardExampleApp({Key? key}) : super(key: key);

  @override
  State<DashboardExampleApp> createState() => _DashboardExampleAppState();
}

class _DashboardExampleAppState extends State<DashboardExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light 
          ? ThemeMode.dark 
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Dashboard Widgets Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: HomeScreen(toggleTheme: _toggleThemeMode),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const StatCardScreen(),
    const PieSummaryScreen(),
    const ActivityBarScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Stat Cards',
    'Pie Summary',
    'Activity Bar',
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart),
            label: 'Pie',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Bars',
          ),
        ],
      ),
    );
  }
}
