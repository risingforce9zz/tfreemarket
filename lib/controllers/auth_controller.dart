import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../firebase_options.dart';
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
      Get.offAll(SelectSignInPage());
    } catch (error) {
      setAuthErrorMessage('パスワードリセットでエラーが発生しました。');
    }
  }

  /// Twitterログイン
  signInWithTwitter() async {
    // TwitterLoginのインスタンス化
    final twitterLogin = TwitterLogin(
        apiKey: dotenv.env['TWITTER_API_KEY']!,
        apiSecretKey: dotenv.env['TWITTER_API_SECRET_KEY']!,
        redirectURI: dotenv.env['TWITTER_REDIRECT_URI']!);

    // Twitterサインイン　フロー開始
    final authResult = await twitterLogin.login();
    String accessToken = authResult.authToken!;
    String accessTokenSecret = authResult.authTokenSecret!;
    String screenName = authResult.user!.screenName;
    String twitterThumbnailImage = authResult.user!.thumbnailImage;
    String name = authResult.user!.name;

    // アクセストークンからcredentialを作成
    final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: accessToken, secret: accessTokenSecret);

    // firebaseのcredentialを作成
    await _auth.signInWithCredential(twitterAuthCredential);
  }

  /// Googleサインイン
  signInWithGoogle() async {
    // 認証フローの開始
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: DefaultFirebaseOptions.currentPlatform.iosClientId)
        .signIn();

    // 認証情報詳細を取得
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // クレデンシャルの作成
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // サインインに成功するとユーザークレデンシャルが返る
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

  }

  /// AppleIDでサインイン
  signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    if (kIsWeb) {
      await _auth.signInWithPopup(appleProvider);
    } else {
      await _auth.signInWithAuthProvider(appleProvider);
    }
  }

}
