import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 2,
        title:const Text('Whatsapp',style: TextStyle(
          color: Colors.green,
          fontSize: 28.0,
          fontWeight: FontWeight.bold),), 
        actions:const [
          Icon(Icons.more_vert)
        ],),
        body: HalamanPertama(),
    );
  }
}

class HalamanPertama extends StatelessWidget {
  const HalamanPertama({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        const Text("Hamdal"),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: <Color> [
              Colors.purpleAccent,
              Colors.yellowAccent
            ])
          ),
          padding: const EdgeInsets.all(10),
          child: const Text('pinjam dulu 100',style: TextStyle(fontSize: 20),)
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style:const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(4)
            ),
            onPressed: (){}, child: Text('Saya Tombol')),
        )

      ],
      );
  }
}