import 'package:flutter/material.dart';
import 'package:myapp/guest/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final username = TextEditingController();
  final password = TextEditingController();
  void _submit() {}
  
  void _pindahRegister(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ));
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  onPressed: () => _pindahRegister(context),
                  child: const Text('Registrasi Sekarang')),
              TextButton(
                  onPressed: _submit,
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
