import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:lovebooks/common/DialogUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 注册页面
class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  // 账户
  var strAccount = '';

  // 密码
  var strPass = '';

  // 昵称
  var strNick = '';

  // 头像图片
  File imageHead;

  TextEditingController accountController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nickController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(
          title: Text('注册'),
          leading: IconButton(
            icon: BackButtonIcon(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BodyPage(),
      ),
    );
  }

  Widget BodyPage() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
                margin: EdgeInsets.only(top: 30.0),
                alignment: Alignment.center,
                child: imageHead == null
                    ? CircleAvatar(
                        backgroundImage: AssetImage('images/icon_user.png'),
                        backgroundColor: Colors.white,
                        radius: 50)
                    : CircleAvatar(
                        backgroundImage: new FileImage(imageHead),
                        backgroundColor: Colors.white,
                        radius: 50.0,
                      )),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '您好',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '欢迎来到注册界面',
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: TextField(
              controller: accountController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: '请输入11位手机号码'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: TextField(
              controller: nickController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: '请输入您的昵称'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(hintText: '请输入6位密码'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: MaterialButton(
              minWidth: 120.0,
              height: 50.0,
              child: Text(
                '立即注册',
                style: TextStyle(fontSize: 20.0, backgroundColor: Colors.cyan),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                strAccount = accountController.text;
                strPass = passController.text;
                strNick = passController.text;

                register(context, strAccount, strPass, strNick);
              },
            ),
          )
        ],
      ),
    );
  }

  void getImage() {}

  void register(
      BuildContext context, String account, String pass, String nick) async {
    if (account.trim() == '') {
      DialogUtils.show(context, '提示', '手机号不能为空');
      return;
    }
    if (pass.trim() == '') {
      DialogUtils.show(context, '提示', '密码不能为空');
      return;
    }

    var sp = await SharedPreferences.getInstance();
    sp.setString(account, pass);
    sp.setString(account + "_nick", nick);

    DialogUtils.show(context, '提示', '注册成功，请返回登录');
  }
}
