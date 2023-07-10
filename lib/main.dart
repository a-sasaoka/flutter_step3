import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloworld/time_to_live.dart';
import 'package:helloworld/web_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
  bool _flg = true;
  dynamic dateTime;
  dynamic dateFormat;
  String _selectDuration = '1日';

  @override
  void initState() {
    super.initState();
    _counter = 0;
    _flg = true;
    dateTime = DateTime.now();
    dateFormat = DateFormat('yyyy年MM月dd日').format(dateTime);
    _selectDuration = '1日';
  }

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

  // Flutter標準の日付選択
  _datePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      locale: const Locale('ja'),
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (datePicked != null && datePicked != dateTime) {
      setState(() {
        dateFormat = DateFormat('yyyy年MM月dd日').format(datePicked);
      });
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
          const SizedBox(
            height: 32,
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
          const SizedBox(
            height: 32,
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
              ),
              Icon(
                FontAwesomeIcons.gift,
                color: Colors.teal,
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'ブラウザでYahoo!を表示',
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () async {
              Uri uri = Uri.https('www.yahoo.co.jp');

              await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          const SizedBox(
            height: 32,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) => const WebView('https://flutter.dev'),
                  ));
            },
            child: const Text(
              'WebView起動',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          // Widgetを重ねて表示
          const Stack(
            children: [
              SizedBox(
                child: LinearProgressIndicator(
                  minHeight: 30,
                  backgroundColor: Colors.blue,
                  value: 0.3,
                ),
              ),
              Align(
                child: Text(
                  '残り70%',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            '$dateFormat',
          ),
          ElevatedButton(
            onPressed: () {
              _datePicker(context);
            },
            child: const Text(
              '日付を選択',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime(2049, 12, 31),
                onConfirm: (date) {
                  setState(() {
                    dateFormat = DateFormat('yyyy年MM月dd日').format(date);
                  });
                },
                currentTime: dateTime,
                locale: LocaleType.jp,
              );
            },
            child: const Text(
              'ドラム型で日付を選択',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          DropdownButton(
            value: _selectDuration,
            items: TimeToLive.values.map((v) {
              return DropdownMenuItem<String>(
                value: v.name,
                child: Text(v.name),
              );
            }).toList(),
            onChanged: (data) {
              setState(() {
                _selectDuration = data.toString();
              });
            },
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
      endDrawer: Drawer(
          child: ListView(
        children: [
          Container(
            height: 64,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'タイトル',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SwitchListTile(
            title: const Text(
              '項目名',
            ),
            secondary: const Icon(
              FontAwesomeIcons.gift,
              color: Colors.teal,
            ),
            value: _flg,
            onChanged: (bool value) => {
              setState(() {
                _flg = value;
              })
            },
          ),
        ],
      )),
    );
  }
}
