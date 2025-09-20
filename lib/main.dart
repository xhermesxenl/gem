import 'package:flutter/material.dart';
import 'app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://ritnhaazxumjjnpzsuox.supabase.co",
    anonKey: "sb_publishable_D1bvL9fEIoAkmb7uZtgeyg_d1sNeg71",
  );

  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter CRUD',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}