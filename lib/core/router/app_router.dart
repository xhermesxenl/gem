import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/reset_password.dart';
import '../../features/auth/presentation/pages/new_password_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/confirm_email_page.dart';

import '../../features/items/presentation/pages/item_list_page.dart';



  // initialLocation: '/signin',
  // redirect: (context, state) {
  //   final session = Supabase.instance.client.auth.currentSession;
  //   final loggingIn = state.matchedLocation == '/signin' || state.matchedLocation == '/signup' || state.matchedLocation == '/reset' || state.matchedLocation == '/new-password';

  //   if (session == null && !loggingIn) return '/signin';
  //   if (session != null && loggingIn) return '/items';
  //   return null;
  // },
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',  // 🚀 on démarre sur le splash
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/reset',
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: '/new-password',
      builder: (context, state) => const NewPasswordPage(),
    ),
    GoRoute(
      path: '/items',
      builder: (context, state) => const ItemListPage(),
    ),
    GoRoute(
  path: '/confirm-email',
  builder: (context, state) {
    final email = state.extra as String? ?? "votre adresse email";
    return ConfirmEmailPage(email: email);
  },
),
  ],
);

