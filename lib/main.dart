import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/portfolio_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NazarulPortfolioApp());
}

class NazarulPortfolioApp extends StatelessWidget {
  const NazarulPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nazarul Qudri • Flutter Specialist & Solutions Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const PortfolioScreen(),
    );
  }
}
