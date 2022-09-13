import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tfreemarket/controllers/auth_controller.dart';

import '../common/theme_helper.dart';
import 'widgets/header_widget.dart';


class SelectSignInPage extends StatelessWidget{
  SelectSignInPage({Key? key}): super(key:key);
  final AuthController authController = AuthController.to;
  final double _headerHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.storefront), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),// This will be the login form
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0,),
                      const Text(
                        '以下の方法でログインできます。',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0,),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Row(
                              children: const <Widget>[
                                FaIcon(FontAwesomeIcons.envelope, size: 23),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                  child: Text('Emailとパスワード', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                              ]
                          ),
                          onPressed: (){
                            Get.toNamed('/login');
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Row(
                              children: const [
                                FaIcon(FontAwesomeIcons.twitter, size: 23, color: Colors.blue),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                  child: Text('Twitterアカウント', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                              ]
                          ),
                          onPressed: (){
                              authController.signInWithTwitter();
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Row(
                              children: const [
                                FaIcon(FontAwesomeIcons.google, size: 23),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                  child: Text('Googleアカウント', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                              ]
                          ),
                          onPressed: (){
                            authController.signInWithGoogle();
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Row(
                              children: const [
                                FaIcon(FontAwesomeIcons.apple, size: 23),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                  child: Text('Appleアカウント', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                              ]
                          ),
                          onPressed: (){
                            authController.signInWithApple();
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Row(
                              children: const [
                                FaIcon(FontAwesomeIcons.userPlus, size: 23,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
                                  child: Text('新規作成', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                              ]
                          ),
                          onPressed: (){
                            Get.toNamed('/registration');
                          },
                        ),
                      ),
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