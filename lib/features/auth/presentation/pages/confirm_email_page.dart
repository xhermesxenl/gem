import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmEmailPage extends StatelessWidget {
  final String email;
  const ConfirmEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmation requise")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "📩 Un email de confirmation a été envoyé à :\n$email",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/signin'),
              child: const Text("Retour à la connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
