import 'package:flutter/material.dart';
import 'package:lovebooks/common/DialogUtils.dart';
import 'package:lovebooks/main.dart';
import 'package:lovebooks/pages/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.black), home: LoginPageWidget());
  }
}

class LoginPageWidget extends StatelessWidget {
  // 账户
  var _str_account = '';

  // 密码
  var _str_pass = '';

  // 文本编辑控制器，可用于监听文本内容的改变
  TextEditingController accountController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('登录', textAlign: TextAlign.center),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text('您好！', style: TextStyle(fontSize: 30.0)),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('欢迎来到登录界面', style: TextStyle(fontSize: 16.0)),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: TextField(
                controller: accountController,
                keyboardType: TextInputType.phone,
                // 设置hint
                decoration: InputDecoration(hintText: '请输入11位手机号码'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: TextField(
                controller: passController,
                // 是否以密码形式显示（*）
                obscureText: true,
                decoration: InputDecoration(hintText: '请输入6位密码'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new RegisterPage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                alignment: Alignment.topLeft,
                child: Text('没有账号，注册一个吧～',
                    style: TextStyle(
                        // 下划线
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: MaterialButton(
                child: Text(
                  '登录',
                  style: TextStyle(fontSize: 24.0, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                // 按钮点击事件
                onPressed: () {
                  _str_account = accountController.text;
                  _str_pass = passController.text;
                  localLogin(context, _str_account, _str_pass);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void localLogin(BuildContext context, String account, String password) async {
    if (account.trim() == '') {
      DialogUtils.show(context, '提示', '账号不能为空');
      return;
    }
    if (password.trim() == '') {
      DialogUtils.show(context, '提示', '密码不能为空');
      return;
    }
    var sp = await SharedPreferences.getInstance();
    if (sp.get(account) == password) {
      sp.setString("current_login_user", account);
    } else {
      DialogUtils.show(context, '提示', '登录失败，用户名或密码错误');
    }
  }
}
