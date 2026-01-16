import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/app/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppSecret.supbaseUrl,
    anonKey: AppSecret.supbaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      routerConfig: AppRouter.router,
    );
  }
}
