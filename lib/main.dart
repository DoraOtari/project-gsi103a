import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int halSaatIni = 0;

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
      body:<Widget>[
            const HalamanPertama(),
            const HalamanKedua(),
          ][halSaatIni],
      bottomNavigationBar: NavigationBar(
        selectedIndex: halSaatIni,
        onDestinationSelected: (int index) => setState(() {
          halSaatIni = index;
        }),
        indicatorColor: Colors.green.shade200,
        destinations:const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_filled,), 
            label: 'Page Satu'),
          NavigationDestination(
            icon: Icon(Icons.picture_in_picture), 
            label: 'Page Dua'),
        ],
        ),
    );
  }
}

class HalamanPertama extends StatelessWidget {
  const HalamanPertama({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
       return ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage('https://picsum.photos/id/${index*3}/200')
            ),
          title: Text('Jili the kid'),
          subtitle: Text('pinjam dulu ${index+1}00 besok ganti'),
          trailing: Column(
            children: [
              Text('${index+4}.51'),
              Badge.count(
                count: 1,
                backgroundColor: Colors.green,
              )
            ],
          ),
        );
      },
    );
  }
}

class HalamanKedua extends StatelessWidget {
  const HalamanKedua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:const Center(
        child: Column(
          children: [
            Text('ini halaman kedua'),
          ],
        ),
      ),
    );
  }
}
