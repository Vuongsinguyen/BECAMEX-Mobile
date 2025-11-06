import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (only for non-web platforms)
  String supabaseUrl;
  String supabaseAnonKey;

  try {
    await dotenv.load(fileName: ".env");
    supabaseUrl = dotenv.env['SUPABASE_URL']!;
    supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  } catch (e) {
    // On web, .env might not be available, use fallback values
    // In production, these should be set via build environment variables
    supabaseUrl = 'https://rvxbzlgnojnaejcjegyz.supabase.co';
    supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ2eGJ6bGdub2puYWVqY2plZ3l6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE5Mjk5NTMsImV4cCI6MjA3NzUwNTk1M30.zpcHyaqUwCK4MHw_q7bC4F2C5vG8q9WlMFGHf6zlE2Y';
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  Widget? _homeWidget;

  @override
  void initState() {
    super.initState();
    _checkAuthAndRole();
  }

  Future<void> _checkAuthAndRole() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      setState(() {
        _isLoading = false;
        _homeWidget = const LoginPage();
      });
      return;
    }

    try {
      // Kiểm tra role của user
      final userData = await Supabase.instance.client
          .from('users')
          .select('role')
          .eq('id', user.id)
          .single();

      final role = userData['role'] as String;

      if (role == 'resident') {
        setState(() {
          _isLoading = false;
          _homeWidget = const HomePage();
        });
      } else {
        // Role không hợp lệ, đăng xuất
        await Supabase.instance.client.auth.signOut();
        setState(() {
          _isLoading = false;
          _homeWidget = const LoginPage();
        });
      }
    } catch (e) {
      // Lỗi khi query, fallback về login
      await Supabase.instance.client.auth.signOut();
      setState(() {
        _isLoading = false;
        _homeWidget = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'BECAMEX Mobile',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: _homeWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}
