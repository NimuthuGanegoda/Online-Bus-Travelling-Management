import 'package:flutter/material.dart';
import 'package:passenger_app/screens/login_screen.dart';
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

  runApp(PassengerApp(supabaseReady: supabaseReady));
}

class PassengerApp extends StatelessWidget {
  const PassengerApp({super.key, this.supabaseReady = true});

  final bool supabaseReady;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF006D77),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'SL BusTrack Passenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF08131A),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF13232D),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFF214150)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
          ),
        ),
      ),
      home: PassengerLoginScreen(supabaseReady: supabaseReady),
    );
  }
}
