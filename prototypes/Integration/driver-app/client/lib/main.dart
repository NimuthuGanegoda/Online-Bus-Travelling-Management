import 'package:driver_app/screens/home_screen.dart';
import 'package:driver_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var supabaseReady = true;

  try {
    await Supabase.initialize(
      url: 'https://thfphwduxzyojnnbuwey.supabase.co',
      anonKey: 'sb_publishable_UtG5RfQWaq_3TSU8nFYe5g_ppp-LLUz',
    );
  } catch (_) {
    supabaseReady = false;
  }

  runApp(DriverApp(supabaseReady: supabaseReady));
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key, this.supabaseReady = true});

  final bool supabaseReady;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE76F51),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'SL BusTrack Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF140B09),
        cardTheme: const CardThemeData(
          color: Color(0xFF241714),
          margin: EdgeInsets.zero,
        ),
      ),
      routes: {
        DriverHomeScreen.routeName: (context) => const DriverHomeScreen(),
      },
      home: DriverLoginScreen(supabaseReady: supabaseReady),
    );
  }
}
