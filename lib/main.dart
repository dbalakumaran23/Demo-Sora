import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/my_id_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/profile_screen.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const CampusConnectApp());
}

/// Global theme notifier — shared across the whole app.
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;
  String? _profileImagePath;

  bool get isDarkMode => _isDarkMode;
  String? get profileImagePath => _profileImagePath;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setProfileImage(String path) {
    _profileImagePath = path;
    notifyListeners();
  }
}

/// Provides the ThemeNotifier down the widget tree.
class ThemeProvider extends InheritedNotifier<ThemeNotifier> {
  const ThemeProvider({
    super.key,
    required ThemeNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  static ThemeNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>()!
        .notifier!;
  }
}

class CampusConnectApp extends StatefulWidget {
  const CampusConnectApp({super.key});

  @override
  State<CampusConnectApp> createState() => _CampusConnectAppState();
}

class _CampusConnectAppState extends State<CampusConnectApp> {
  final _themeNotifier = ThemeNotifier();

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      notifier: _themeNotifier,
      child: AnimatedBuilder(
        animation: _themeNotifier,
        builder: (context, _) {
          return MaterialApp(
            title: 'PUnova',
            debugShowCheckedModeBanner: false,
            theme: _themeNotifier.isDarkMode
                ? AppTheme.darkTheme
                : AppTheme.lightTheme,
            home: const AppEntry(),
          );
        },
      ),
    );
  }
}

/// Entry point: shows Welcome screen first, then navigates to Dashboard.
class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  bool _showWelcome = true;

  @override
  Widget build(BuildContext context) {
    if (_showWelcome) {
      return WelcomeScreen(
        onGetStarted: () => setState(() => _showWelcome = false),
      );
    }
    return const DashboardShell();
  }
}

/// Main dashboard with bottom navigation bar + IndexedStack for tab persistence.
class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const MyIdScreen()),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeProvider.of(context).isDarkMode;
    final bgColor = isDark ? AppColors.bgDark : LightColors.bgLight;
    final bgGrad = isDark ? AppColors.bgGradient : LightColors.bgGradient;
    final borderColor =
        isDark ? AppColors.glassBorder : LightColors.glassBorder;

    // Only build the active tab — avoids keeping all 4 screens alive
    final activeTab = _currentIndex > 2 ? _currentIndex - 1 : _currentIndex;
    const tabs = <Widget>[
      HomeScreen(),
      MapScreen(),
      AlertsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(gradient: bgGrad),
        child: SafeArea(
          child: tabs[activeTab],
        ),
      ),
      bottomNavigationBar: _buildGlassNavBar(isDark, bgColor, borderColor),
    );
  }

  Widget _buildGlassNavBar(bool isDark, Color bgColor, Color borderColor) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.95),
        border: Border(top: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_rounded, 'Home', 0, isDark),
          _navItem(Icons.map_rounded, 'Map', 1, isDark),
          _navCenterItem(),
          _navItem(Icons.notifications_rounded, 'Alerts', 3, isDark),
          _navItem(Icons.person_rounded, 'Profile', 4, isDark),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index, bool isDark) {
    final isSelected = _currentIndex == index;
    final mutedColor = isDark ? AppColors.textMuted : LightColors.textMuted;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.accentTeal : mutedColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.accentTeal : mutedColor,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.accentTeal),
              ),
          ],
        ),
      ),
    );
  }

  Widget _navCenterItem() {
    return GestureDetector(
      onTap: () => _onTabTapped(2),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.badge_rounded, color: Colors.white, size: 26),
      ),
    );
  }
}
