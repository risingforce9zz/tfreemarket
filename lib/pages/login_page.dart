import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfreemarket/controllers/auth_controller.dart';

import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';
import '../../common/theme_helper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  double _headerHeight = 250;

  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'サインイン',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        children: [
                          Container(
                            child: TextField(
                              decoration: ThemeHelper().textInputDecoration(
                                  'メールアドレス', 'メールアドレスを入力します。'),
                              controller: authController.emailController,
                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            child: TextField(
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  'パスワード', 'パスワードを入力します。'),
                              controller: authController.passwordController,
                            ),
                            decoration: ThemeHelper()
                                .inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed('/forgotpassword');
                              },
                              child: Text("パスワードを忘れましたか?",
                                style: TextStyle(color: Colors.grey,),
                              ),
                            ),
                          ),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(
                                context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text('サインイン'.toUpperCase(),
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),
                              ),
                              onPressed: () {
                                authController.signIn();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}