import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/guest/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _username = TextEditingController();

  final _password = TextEditingController();

  void _submit(username, password) async {
    await Firebase.initializeApp();

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);
      _username.clear();
      _password.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('password anda lemah seperti anda');
      } else if (e.code == 'email-already-in-use') {
        print('telat kau lah diambek wong');
      }
    } catch (e) {
      print(e);
    }
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
              'Register',
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
            Align(
              heightFactor: 1.5,
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => _submit(_username.text, _password.text),
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
