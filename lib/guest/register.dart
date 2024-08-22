import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final username = TextEditingController();
  final password = TextEditingController();
  void _submit() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: username.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('password anda lemah seperti anda');
      } else if(e.code == 'email-already-in-use') {
        print('telat kau lah diambek wong');
      }
    } catch (e) {
      print(e);
    }
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
              controller: username,
              decoration: const InputDecoration(
                label: Text('username'),
              ),
            ),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(
                label: Text('password'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              heightFactor: 1.5,
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => _submit,
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
