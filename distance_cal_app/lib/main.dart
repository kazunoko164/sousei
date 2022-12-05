import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:external_path/external_path.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io'; //ファイル出力用ライブラリ
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _location = "no data";

  // 生成したデータを直接保存するときのファイル名
  final String savedFileNameO = "SaveTest.txt";

  // 生成したデータを、いったんアプリ内専用フォルダに保存するときのファイル名
  //final String inAppFolderFileNameO = "AppFolderTest.txt";

  // いったん保存したデータを、再保存（バックアップ）するときのファイル名
  //final String backUppedFileNameO = "BackUpTest.txt";

  String data = "";
  double bf_Lon = 0;
  double bf_Lat = 0;
  //while(true)
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // 現在の位置を返す

    // List<String> data = [];
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    """
    print("緯度: " + position.latitude.toString());
    // 東経がプラス、西経がマイナス
    print("経度: " + position.longitude.toString());
    // 高度
    print("高度: " + position.altitude.toString());
    double distanceInMeters =
        Geolocator.distanceBetween(35.68, 139.76, -23.61, -46.40);
    //print(distanceInMeters);
    // 方位を返す
    double bearing = Geolocator.bearingBetween(35.68, 139.76, -23.61, -46.40);
    //print(bearing);
    """;
    setState(() {
      //_location = position.toString();
      var Lat = position.latitude;
      var Lon = position.longitude;
      var dis_Lat = Lat - bf_Lat;
      var dis_Lon = Lon - bf_Lon;
      var now = DateTime.now();

      //data.add(now.toString() + ", " + _location);
      _location =
          "$now\n${position.latitude}\n ($dis_Lat)\n${position.longitude}\n ($dis_Lon)";
      data +=
          "$now, ${position.latitude}($dis_Lat), ${position.longitude}($dis_Lon)\n";
      //_saveNewFileO(data[0]);
      _counter++;
      bf_Lat = position.latitude;
      bf_Lon = position.longitude;
    });
  }

  int _counter = 0;

  bool flag_getloc = false;

  void _getLoc() {
    setState(() {
      if (flag_getloc == true) {
        _saveNewFileO(data);
      }
      flag_getloc = !flag_getloc;
      _counter = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onLocation);
  }

  void _onLocation(Timer timer) {
    /// 現在位置を取得する
    if (flag_getloc == true) {
      setState(() {
        getLocation();
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _saveNewFileO("これはsaveNewFileaaaです");
      //_makeFileInAppFolderO("こっちはmakeFileなんとか");
      //_backUpExistingFileO();
    });
  }

//'async' or 'async*'
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Show where you are:',
            ),
            Text(
              '$_location',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              //'$_counter',
              '$flag_getloc',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              //onPressed: () {/* ボタンがタップされた時の処理 */},
              onPressed: _getLoc,
              child: Text('click here'),
            ),
            // const Text()
          ],
        ),
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up, // childrenの先頭が下に配置されます。
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 1つ目のFAB
          FloatingActionButton(
              // 参考※3よりユニークな名称をつけましょう。ないとエラーになります。
              // There are multiple heroes that share the same tag within a subtree.
              heroTag: "search",
              child: Icon(Icons.search),
              backgroundColor: Colors.blue[200],
              //onPressed: _incrementCounter),
              onPressed: _incrementCounter),
          // 2つ目のFAB
          Container(
            // 余白を設けるためContainerでラップします。
            margin: EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
                // 参考※3よりユニークな名称をつけましょう。ないとエラーになります。
                heroTag: "scan",
                child: Icon(Icons.stop),
                backgroundColor: Colors.pink[200],
                onPressed: getLocation),
          ),
        ],
      ),

      //tooltip: 'Increment',
      //child: const Icon(Icons.add),
      //), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // テスト③ 実行メソッド
  Future<void> _saveNewFileO(String massage) async {
    final String savedContentO = massage;

    // 端末内ストレージへのアクセスについて、ユーザー同意を得る画面を表示
    // ※テスト④を先にやって同意済の場合は表示されない
    await [Permission.storage].request();

    // 保存先のパス名（ファイル名除く）をいったん空文字で設定
    String savedPathO = "";

    // AndroidとiOSでは用いるメソッドが異なるため、OS判定をして分岐

    // Androidの場合
    if (Platform.isAndroid) {
      // ダウンロードフォルダのパスを取得
      savedPathO = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      // 「ext_storage」を使う場合は以下の書き方になる（ただし、使用しない方が無難）
      // savedPathO = (await ExtStorage.getExternalStoragePublicDirectory(
      //  ExtStorage.DIRECTORY_DOWNLOADS))!;

      // iOSの場合
    } else {
      // アプリ専用フォルダ内のフォルダ情報を取得
      final savedDocumentDirectoryO = await getApplicationDocumentsDirectory();

      // 上記フォルダ情報（Directory型）からパス名を取得
      savedPathO = savedDocumentDirectoryO.path;
    }

    // 取得したパス名とファイル名を連結してフルパスを作成
    String savedFullPathO = "$savedPathO/$savedFileNameO";

    try {
      // 上記フルパスにFileクラスのインスタンスを設定
      File savedFileO = File(savedFullPathO);
      print("$savedFullPathO");

      // 上記インスタンスにファイル内容を書き込む（ここで初めてファイルが保存される）
      await savedFileO.writeAsString(savedContentO);
    } catch (e) {
      print(e);
    }
  }
/*
  // テスト④ Step1 実行メソッド
  Future<void> _makeFileInAppFolderO(String massage) async {
    final String inAppFolderContentO = massage;

    // アプリ専用フォルダ内のフォルダ情報（ユーザーアクセス不可）を取得
    final inAppFolderDocumentDirectoryO =
        await getApplicationDocumentsDirectory();

    // 上記フォルダ情報（Directory型）からパス名を取得
    final inAppFolderPathO = inAppFolderDocumentDirectoryO.path;

    // 取得したパス名とファイル名を連結してフルパスを作成
    String inAppFolderFullPathO = "$inAppFolderPathO/$inAppFolderFileNameO";
    print("$inAppFolderFullPathO");

    try {
      // 上記フルパスにFileクラスのインスタンスを設定
      File inAppFolderFileO = File(inAppFolderFullPathO);
      print("$inAppFolderFullPathO");

      // 上記インスタンスにファイル内容を書き込む（ここで初めてファイルが保存される）
      await inAppFolderFileO.writeAsString(inAppFolderContentO);
    } catch (e) {
      print(e);
    }
  }

  // テスト④ Step2 実行メソッド
  Future<void> _backUpExistingFileO() async {
    // 端末内ストレージへのアクセスについて、ユーザー同意を得る画面を表示
    // ※テスト③を先にやって同意済の場合は表示されない
    await [Permission.storage].request();

    // Step1で保存したファイル（バックアップしたいファイル）のフォルダ情報を取得
    final inAppFolderDocumentDirectoryO =
        await getApplicationDocumentsDirectory();

    // 上記フォルダ情報（Directory型）からパス名を取得
    final inAppFolderPathO = inAppFolderDocumentDirectoryO.path;

    // Step1で保存したファイル（バックアップしたいファイル）のフルパスを取得
    String inAppFolderFullPathO = "$inAppFolderPathO/$inAppFolderFileNameO";

    // 上記フルパスにFileクラスのインスタンスを設定
    final backUppedFileO = File(inAppFolderFullPathO);

    // 元ファイルがテキスト以外の形式（画像、その他）であっても対応できるよう、
    // 数字の羅列で表現されるバイト型データ（Uint8List型）に変換
    Uint8List convertedBuckUppedFileO = await backUppedFileO.readAsBytes();

    // 再保存先（バックアップ先）のパス名（ファイル名除く）をいったん空文字で設定
    String backUppedPathO = "";

    // 以降は基本、テスト③と同じロジック

    if (Platform.isAndroid) {
      backUppedPathO = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      // 「ext_storage」を使う場合は以下の書き方になる（ただし、使用しない方が無難）
      // backUppedPathO = (await ExtStorage.getExternalStoragePublicDirectory(
      // ExtStorage.DIRECTORY_DOWNLOADS))!;
    } else {
      final backUppedDocumentDirectoryO =
          await getApplicationDocumentsDirectory();
      backUppedPathO = backUppedDocumentDirectoryO.path;
    }

    String backUppedFullPathO = "$backUppedPathO/$backUppedFileNameO";

    try {
      File backUppedFileO = File(backUppedFullPathO);
      print("$backUppedFullPathO");

      // 上記インスタンスにファイル内容を書き込む（バイト型データとして保存）
      await backUppedFileO.writeAsBytes(convertedBuckUppedFileO);
    } catch (e) {
      print(e);
    }
  }
  */
}
