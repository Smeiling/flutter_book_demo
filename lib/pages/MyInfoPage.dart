import 'package:flutter/material.dart';
import 'package:lovebooks/pages/LoginPage.dart';

class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyInfoPageState();
  }
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 130.0, bottom: 40.0),
                alignment: Alignment.center,
                child: CircleAvatar(
                    backgroundImage: AssetImage('images/icon_user.png'),
                    backgroundColor: Colors.white,
                    radius: 50),
                width: 60.0,
                height: 60.0,
              ),
            ),
            GestureDetector(
              onTap: () {
//                Navigator.pushNamed(context, "login_page");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new LoginPage()));
              },
              child: Text(
                '退出登录',
                style: TextStyle(
                    backgroundColor: Colors.amberAccent, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
