import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovebooks/pages/BookStore.dart';
import 'package:lovebooks/pages/LoginPage.dart';
import 'package:lovebooks/pages/MyInfoPage.dart';
import 'package:lovebooks/pages/RegisterPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "login_page": (context) => LoginPage(),
        "register_page": (context) => RegisterPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int selectedIndex = 0;
  TabController controller;

  final tabTextStyleNormal = new TextStyle(color: Colors.amberAccent);
  final tabTextStyleSelected = new TextStyle(color: Colors.amber);

  var tagImages;
  var bodyStack;

  var appBarTitles = ['首页', '我的'];

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == selectedIndex) {
      return tagImages[curIndex][0];
    } else {
      return tagImages[curIndex][1];
    }
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex],
        style: TextStyle(fontSize: 10.0, color: Colors.amberAccent));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });
    });
  }

  void initData() {
    tagImages = [
      [
        getTabImage('images/icon_home.png'),
        getTabImage('image/icon_home_default.png')
      ],
      [
        getTabImage('images/icon_my.png'),
        getTabImage('images/icon_my_default.png')
      ]
    ];
    bodyStack = new IndexedStack(
      children: <Widget>[new BookStore(), new MyInfoPage()],
      index: selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    initData();
    return new MaterialApp(
        theme: new ThemeData(primaryColor: Colors.black),
        home: new Scaffold(

          body: TabBarView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[new BookStore(), new MyInfoPage()],
          ),
          bottomNavigationBar: new CupertinoTabBar(
            backgroundColor: const Color(0xffeae9e7),
            items: [
              new BottomNavigationBarItem(
                  icon: getTabIcon(0), title: getTabTitle(0)),
              new BottomNavigationBarItem(
                  icon: getTabIcon(1), title: getTabTitle(1)),
            ],

            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                controller.index = index;
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}
