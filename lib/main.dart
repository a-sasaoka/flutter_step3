import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // カウンターの値で偶数、奇数のWidgetを出し分けるためのメソッド
  Text _showString() {
    if (_counter % 2 == 0) {
      return const Text(
        '上の数は偶数です',
        style: TextStyle(
          color: Colors.red,
        ),
      );
    } else {
      return const Text(
        '上の数は奇数です',
        style: TextStyle(
          color: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          children: [
            Icon(
              Icons.create,
            ),
            Text(
              '初めてのタイトル',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Text(
            'HelloWolrd',
          ),
          const Text(
            'ハローワールド',
          ),
          Text(
            'テキストボタンをクリックした回数：$_counter',
          ),
          // メソッドでWidgetを出し分ける
          _showString(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.limeAccent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
            ),
            onPressed: _incrementCounter,
            child: const Text(
              'テキストボタン',
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24.0,
              ),
              Icon(
                Icons.audiotrack,
                color: Colors.green,
                size: 30.0,
              ),
              Icon(
                Icons.beach_access,
                color: Colors.blue,
                size: 36.0,
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(
          Icons.timer,
        ),
      ),
      drawer: const Drawer(
        child: Center(
          child: Text(
            'Drawer',
          ),
        ),
      ),
      endDrawer: const Drawer(
        child: Center(
          child: Text(
            'EndDrawer',
          ),
        ),
      ),
    );
  }
}
