// ライブラリ・パッケージ読み取り部分
import 'package:flutter/material.dart';

// mainから実行して関数RunAppで渡されたWedget(ここではMyApp)で設定されたデザインを表示する
void main() => runApp(MyApp());

// StatelessWidgetは状態(？)をもたないWidget、画面推移の話？
// 状態を持つ場合はStatefulWidgetを利用する
// 最初に表示するデザインのMyAppを今から定義
class MyApp extends StatelessWidget {
  @override
  // build: UIの一部を表現する
  // BuikdContext: Widgetツリー内のWidgetの場所を取り扱う、意味わからん
  Widget build(BuildContext context) {
    // MaterialApp()はマテリアルデザインを用いたアプリケーションと定義する。？？
    return MaterialApp(
      title: 'Flutter Demo', // アプリ名ではない何か、アプリ名はこのプロジェクト名
      theme: ThemeData(
        primarySwatch: Colors.red, // アプリのデフォルトカラーみたいなのが変わる
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page!',
      ), // 画面上部のタイトルが変わる
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // コンストラクタ らしい

  final String title;

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(); // MyHomePageState という状態を作成、MyHomePageにいるよって状態？変数や関数の戦闘に_を表すことでprivateを表す
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.start),
      ),
    );
  }
}
