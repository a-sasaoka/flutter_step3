import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloworld/barcode_scanner_window.dart';
import 'package:helloworld/qr_reader.dart';
import 'package:helloworld/time_to_live.dart';
import 'package:helloworld/web_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _initString = '';

  int _counter = 0;
  bool _flg = true;
  dynamic dateTime;
  dynamic dateFormat;
  String _selectDuration = '1日';
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  String _result = '';
  String _result2 = '';

  final MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _counter = 0;
    _flg = true;
    dateTime = DateTime.now();
    dateFormat = DateFormat('yyyy年MM月dd日').format(dateTime);
    _selectDuration = '1日';
    _init();
  }

  Future<void> _init() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _initString = prefs.getString('key') ?? '';
    });
  }

  Future<void> _save() async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString('key', _initString);
  }

  Future<void> _clear() async {
    final SharedPreferences prefs = await _prefs;

    prefs.remove('key');
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                'HelloWolrd',
              ),
              const Text(
                'ハローワールド',
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) =>
                          const WebView('https://flutter.dev'),
                    ),
                  );
                },
                child: const Text(
                  'WebView起動',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
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
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 256,
                child: TextField(
                  controller: TextEditingController(
                    text: _initString,
                  ),
                  decoration: const InputDecoration(
                    labelText: '何かを入力するフィールド',
                    border: UnderlineInputBorder(),
                    hintText: '何か入力してください',
                    helperText: '何を入力しても大丈夫です',
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  onChanged: (value) {
                    _initString = value;
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      _save();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      fixedSize: const Size(96, 32),
                    ),
                    child: const Text(
                      '保存',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                '確認',
                              ),
                              content: const Text(
                                'クリアしてもよいですか？',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'NO'),
                                  child: const Text('NO'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'YES'),
                                  child: const Text('YES'),
                                ),
                              ],
                            );
                          });
                      if (result == 'YES') {
                        _clear();
                        setState(() {
                          _initString = '';
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      fixedSize: const Size(96, 32),
                    ),
                    child: const Text(
                      'クリア',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _init();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      fixedSize: const Size(96, 32),
                    ),
                    child: const Text(
                      '読込',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                '1文字入力すると次に移動',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.length == 1) {
                          _focusNode2.requestFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: _focusNode2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.length == 1) {
                          _focusNode3.requestFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: _focusNode3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.length == 1) {
                          _focusNode4.requestFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: _focusNode4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.length == 1) {
                          _focusNode5.requestFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: _focusNode5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.length == 1) {
                          _focusNode6.requestFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: _focusNode6,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => const QRReader(),
                    ),
                  );
                  setState(() {
                    _result = result;
                  });
                },
                child: const Text(
                  'QRコード読み込み（qr_code_scanner）',
                ),
              ),
              Text(
                _result,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) =>
                          const BarcodeScannerWithScanWindow(),
                    ),
                  );
                  setState(() {
                    _result2 = result ?? '';
                  });
                },
                child: const Text(
                  'QRコード読み込み（mobile_scanner）',
                ),
              ),
              Text(
                _result2,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Bottom Sheet',
                        ),
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  fixedSize: const Size(256, 32),
                ),
                child: const Text(
                  '下から出てきます',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    if (await controller.analyzeImage(image.path)) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Barcode found!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No barcode found!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'QRコードの画像を読み込む',
                ),
              ),

///////////////////////////////////////////////////
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
