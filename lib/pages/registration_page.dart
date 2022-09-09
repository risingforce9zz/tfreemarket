import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../helper/utility.dart';
import 'profile_page.dart';
import '../../common/theme_helper.dart';
import './widgets/header_widget.dart';

class RegistrationPage extends StatelessWidget {
  final Rx<bool> checkboxValue = false.obs;
  final AuthController authController = AuthController.to;

  /// 送信ボタンクリック時に各入力フィールドをチェック
  /// エラーの場合は、SnackBarを表示する。
  bool _validate() {
    // 表示名
    if (authController.displayNameController.text.isEmpty) {
      Utility.customSnackBar('入力確認', '表示名を入力してください。', 'warn');
      return false;
    }
    // 氏名
    if (authController.nameController.text.isEmpty) {
      Utility.customSnackBar('入力確認', '氏名を入力してください。', 'warn');
      return false;
    }
    // 表示名
    String val = authController.emailController.text.trim();
    if (val.isEmpty || !GetUtils.isEmail(val)) {
      Utility.customSnackBar('入力確認', '有効なメールアドレスを入力してください。', 'warn');
      return false;
    }
    // 携帯電話番号
    val = authController.phoneNumberController.text;
    if (!RegExp(r"^0[5789]0-[0-9]{4}-[0-9]{4}$").hasMatch(val)) {
      Utility.customSnackBar('入力確認', 'xxx-xxxx-xxxxで入力してください。。', 'warn');
      return false;
    }

    // パスワード
    RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    val = authController.passwordController.text.trim();
    if (!passValid.hasMatch(val) || val.length < 8) {
      Utility.customSnackBar('入力確認', '8文字以上、半角で英数大文字・小文字・数字・記号が各1文字以上', 'warn');
      return false;
    }
    // 利用規約同意
    if (!checkboxValue.value) {
      Utility.customSnackBar("入力確認", '利用規約同意が必要です。', 'warn');
      return false;
    }
    return true;
  }

  void _submit() {
    if (_validate()) {
      authController.signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextField(
                            decoration: ThemeHelper().textInputDecoration(
                                '表示名', '表示名を入力してください'),
                            controller: authController.displayNameController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextField(
                            decoration: ThemeHelper().textInputDecoration(
                                '氏名(非表示)', '氏名を入力してください。'),
                            controller: authController.nameController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextField(
                            decoration: ThemeHelper().textInputDecoration(
                                "メールアドレス", "メールアドレスを入力してください。"),
                            keyboardType: TextInputType.emailAddress,
                            controller: authController.emailController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextField(
                            decoration: ThemeHelper().textInputDecoration(
                                "携帯電話番号", "携帯電話番号を入力してください。"),
                            keyboardType: TextInputType.phone,
                            controller: authController.phoneNumberController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "パスワード", "パスワードを入力してください。"),
                            controller: authController.passwordController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                   Obx(()=> Checkbox(
                                        value: checkboxValue.value,
                                        onChanged: (value) {
                                          checkboxValue.value = !checkboxValue.value;
                                        }),
                                   ),
                                    Text(
                                      "利用規約に同意します。",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "登録",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _submit();
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
