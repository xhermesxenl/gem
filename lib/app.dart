import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_page.dart.ko';
import 'features/items/presentation/pages/item_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boilerplate App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      initialRoute: "/",
      routes: {
        "/": (_) => const LoginPage(),
        "/items": (_) => const ItemListPage(),
      },
    );
  }
}
