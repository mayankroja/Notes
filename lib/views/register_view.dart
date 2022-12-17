import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import '../utility/utilities.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
                // ignore: avoid_print
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                // ignore: avoid_print
                showSnackBar(e.toString(), context);
              } catch (e) {
                showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text(
              "Register",
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text(
              "Already registered? Login here",
            ),
          ),
        ],
      ),
    );
  }
}
