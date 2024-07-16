import 'package:flutter/material.dart';
import 'package:myapp/store.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
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
        title: const Text(
          'Whatsapp',
          style: TextStyle(
              color: Colors.green, fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: <Widget>[
        const HalamanPertama(),
        const HalamanKedua(),
        const MyStore(),
      ][halSaatIni],
      bottomNavigationBar: NavigationBar(
        selectedIndex: halSaatIni,
        onDestinationSelected: (int index) => setState(() {
          halSaatIni = index;
        }),
        indicatorColor: Colors.green.shade200,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'Page Satu'),
          NavigationDestination(
              icon: Icon(Icons.picture_in_picture), label: 'Page Dua'),
          NavigationDestination(icon: Icon(Icons.store), label: 'My Store')
        ],
      ),
    );
  }
}

class HalamanPertama extends StatelessWidget {
  const HalamanPertama({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
              foregroundImage:
                  NetworkImage('https://picsum.photos/id/${index * 3}/200')),
          title: Text('Jili the kid'),
          subtitle: Text('pinjam dulu ${index + 1}00 besok ganti'),
          trailing: Column(
            children: [
              Text('${index + 4}.51'),
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

class HalamanKedua extends StatefulWidget {
  const HalamanKedua({super.key});

  @override
  State<HalamanKedua> createState() => _HalamanKeduaState();
}

class _HalamanKeduaState extends State<HalamanKedua> {
  List<bool> isFavorit = List.generate(
    12,
    (_) => false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 12, crossAxisSpacing: 12, crossAxisCount: 2),
            itemCount: 12,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GridTile(
                      footer: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HalamanTiga(),
                            )),
                        child: Container(
                            height: 38,
                            alignment: Alignment.centerRight,
                            color: Colors.black.withOpacity(0.5),
                            child: IconButton(
                                onPressed: () => setState(() {
                                      isFavorit[index] = !isFavorit[index];
                                    }),
                                icon: Icon(
                                  isFavorit[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.pink,
                                  size: 34,
                                ))),
                      ),
                      child: Image.network(
                          'https://picsum.photos/id/${index + 8 * 3}/200')));
            }));
  }
}

class HalamanTiga extends StatelessWidget {
  const HalamanTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Tiga'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Will you marry Me',
              style: TextStyle(fontSize: 36),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ngak')),
                ElevatedButton(
                    onPressed: () {
                      final tinggiLayar = MediaQuery.of(context).size.height;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(bottom: tinggiLayar * 0.8),
                          backgroundColor: Colors.deepOrangeAccent,
                          showCloseIcon: true,
                          content: const Text(
                            'Ayo Gas 25-05-2025',
                            style: TextStyle(fontSize: 18),
                          )));
                    },
                    child: const Text('Mau..')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
