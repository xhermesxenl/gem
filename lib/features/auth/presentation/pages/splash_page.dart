import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/logger.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2)); // petit délai pour UX
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      AppLogger.i("Session trouvée", {"user": session.user.id});
      if (mounted) context.go('/items');
    } else {
      AppLogger.i("Aucune session trouvée → go signin");
      if (mounted) context.go('/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
