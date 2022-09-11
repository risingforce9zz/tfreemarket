import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/utility.dart';
import '../pages/select_signin_page.dart';

enum TextEditingControllerStatus { init, clear, dispose }

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  /// 新規作成画面、サインイン画面で使用するTextEditingController
  late TextEditingController nameController;
  late TextEditingController displayNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late TextEditingController profilePicController;
  late TextEditingController storeDescriptionController;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// firebaseのユーザ firebase_authで定義されている。
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    nameController = TextEditingController();
    displayNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    profilePicController = TextEditingController();
    storeDescriptionController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    /// getXのworker、監視対象(引数1)に変化があった場合、引数2のコールバックを呼び出す。
    /// everは毎回。
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onReady();
  }

  @override
  void onClose() {
    handleTextEditingControllers(TextEditingControllerStatus.dispose);
    super.onClose();
  }

  /// textEditingControllerの初期化、終了処理
  void handleTextEditingControllers(TextEditingControllerStatus status) {
    List<TextEditingController> textEditingControllers = [
      nameController,
      displayNameController,
      emailController,
      passwordController,
      phoneNumberController,
      profilePicController,
      storeDescriptionController,
    ];

    switch (status) {
      case TextEditingControllerStatus.clear:
        for (var controller in textEditingControllers) {
          controller.clear();
        }
        break;
      case TextEditingControllerStatus.dispose:
        for (var controller in textEditingControllers) {
          controller.dispose();
        }
        break;
      default:
        break;
    }
  }

  /// firebaseUserの状態が変化したときに呼ばれる
  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser == null) {
      handleTextEditingControllers(TextEditingControllerStatus.clear);
      if (Get.currentRoute != '/select-signin') {
        Get.toNamed('/select-signin');
      }
    } else {
      if (Get.currentRoute != '/profile') {
        Get.toNamed('/profile');
      }
    }
  }

  /// Error発生時にログイン状態を変更しSnackBarを表示
  void setAuthErrorMessage(String message) {
    Utility.customSnackBar('エラー', message);
  }

  /// アカウント新規作成
  Future<void> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      firebaseUser.value = _auth.currentUser;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'email-already-in-use') {
        setAuthErrorMessage('このメールアドレスはすでに使用されています。');
      }
    } catch (error) {
      setAuthErrorMessage(error.toString());
    }
  }

  /// Email, passwordでサインイン
  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      firebaseUser.value = _auth.currentUser;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        Utility.customSnackBar('エラー', 'このEmailではユーザ登録されていません。');
      } else {
        Utility.customSnackBar('エラー', e.message ?? 'サインイン時に特定できないエラーが発生しました。');
      }
    } catch (e) {
      Utility.customSnackBar('エラー', e.toString());
    }
  }

  /// サインアウト
  void singOut() async {
    await _auth.signOut();
    firebaseUser.value = _auth.currentUser;
  }

  ///パスワードリセット
  Future<void> passwordReset() async {
    try {
      _auth.sendPasswordResetEmail(email: emailController.text);
      Get.offAll(const SelectSignInPage());
    } catch (error) {
      setAuthErrorMessage('パスワードリセットでエラーが発生しました。');
    }
  }

}
