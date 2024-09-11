import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/guest/register.dart';
import 'package:myapp/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();

  final _password = TextEditingController();

  void _submit(username, password) async {
    await Firebase.initializeApp();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      _username.clear();
      _password.clear();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ));
    } on FirebaseAuthException catch (e) {
      print('Erronya adalah ${e.code}');
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User tidak ditemukan')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('password salah')));
      }
    }
  }

  void _pindahRegister(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _username,
              decoration: const InputDecoration(
                label: Text('username'),
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: _password,
              decoration: const InputDecoration(
                label: Text('password'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  onPressed: () => _pindahRegister(context),
                  child: const Text('Registrasi Sekarang')),
              TextButton(
                  onPressed: () => _submit(_username.text, _password.text),
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  )),
            ])
          ],
        ),
      ),
    );
  }
}
