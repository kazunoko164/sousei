// ライブラリ・パッケージ読み取り部分
import 'package:flutter/material.dart';

void main() {
  // mainから実行して関数RunAppで渡されたWedget(ここではMyApp)で設定されたデザインを表示する
  // ほぼ役割はなく、最低限の記述だけでOK
  runApp(const MyApp());
}

// StatelessWidgetとは、State（状態）を持たないWidgetのことです。
// なので変数を定義しても、その変数は親Widgetより渡されるのみで、自分でその値を更新することはできません。
// 状態を持つ場合はStatefulWidgetを利用する

// 最初に表示するデザインのMyAppを今から定義
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // MaterialAppを返す？
  // BuildContext: Widgetツリー内のWidgetの場所を取り扱う、意味わからん
  Widget build(BuildContext context) {
    //
    //引数にタイトル、全体の色などのテーマ情報、初期表示のホームとなるクラス（ここでは、MyHomePage）を指定しています。
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.red, // 基本色みたいなやつ
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// こっちは動的なWidgetもといデザイン。レイアウト？
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // MyHomePageState という状態を作成、MyHomePageにいるよって状態？変数や関数の戦闘に_を表すことでprivateを表す
  // => はreturn みたいなものだと思えば良い、状態を作ってやることは_MyHomePageStateという関数を実行する
  _MyHomePageState createState() => _MyHomePageState();
}

// 状態を作る？
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // ボタンが押されたときに呼び出す関数
  void _incrementCounter() {
    // 関数setStateは多分更新されてんぞっていうやつ、再描写の合図みたいな
    setState(() {
      _counter++;
    });
  }

  // ウィジェットのビルドを行います。この中にボタンや変化するテキスト（数字）などの画面の内容を設定します。
  // 多分レイアウトの話？ここが状態がMyHomePageStateのときどのように描写するかってこと？
  @override
  Widget build(BuildContext context) {
    // Scaffoldで画面を作成するパーツや情報をまとめて、returnで返す
    return Scaffold(
      // アプリ上部のタイトルのこと、widget.titleはMyHomePageに渡されたものを持ってくる, 多分MyAppのところ？
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // 内容の中心となるものを配置ます。Centerはコンテンツを中央寄せで配置する要素です。
      body: Center(
        // bodyにchild属性があります。子要素が必要な要素は、child属性やchildren属性が必須となります。
        // よくわからん。多分必ず必要なやつのこと？
        // childは単体、childrenは複数、表示物の数によって分ける
        child: Column(
          // mainAxisAlignment属性を変更することで、縦もしくは横に子要素を並べるかを設定できます。
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // こっちは静的のテキスト
            const Text(
              'You have pushed the button this many times:',
            ),
            // こっちは動的なテキスト
            //Theme.of(context) で親のテーマ情報を持ってきています。
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // 画面左下にあるボタンで、body外に定義します。
      // onPressed にボタンが押された時の動作として、「_incrementCounter()関数」を設定します。
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // 押されたときの処理
        tooltip: 'Increment', //
        child: const Icon(Icons.add), // アイコンの種類
      ),
    );
  }
}
