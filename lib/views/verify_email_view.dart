import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                "We've sent you an email verification. Please open it to verify your account. "),
            const Text(
                "If you haven't received a verification email yet, please press the button below. "),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text(
                'Send email verification',
              ),
            ),
            TextButton(
              onPressed: () {
                AuthService.firebase().logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text(
                'Go back to Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
