# README

ここにあるコードは、著書「0円でモバイルアプリを作る」内で使用しているサンプルアプリケーションのものです。

## レポジトリ構成
ブランチは、書籍の章毎に分けています。

* 01_login_screens_import
* 02_create_usermodel
* 03_flutterfire_setup
* 04_auth_controller
* 05_signup
* 06_email_signin
* 07_twitter_signin
* 08_google_signin
* 09_apple_signin

mainブランチは、各ブランチをマージしています。

## アプリケーション構成

* Dart 2.18
* Flutter 3.3.1


## アプリケーション 概要

オンライン・フリーマーケットを構築します。

まずは、ストア登録をお持ちの

* メール/パスワード
* Twitterアカウント
* Googleアカウント
* Appleアカウント

で開設していただきます。

ストア情報、商品情報の管理ができます。
画像は、Cloud Firestore上へアップロードします。

商品が売れた場合には、メッセージを送ります。

サンプルアプリケーションにつき決済機能はありません。

