## アプリケーション名
SteamApp

## アプリケーション概要
Steamに登録されたゲームのレビュー・価格情報を検索できる。

## URL
https://steam-app-36233.herokuapp.com/

## テスト用アカウント
Basic認証
ID: admin
Pass: 4805

## 利用方法
トップページに20件ずつSteamのアプリ情報が表示される。
キーワードやタグを使ってアプリを検索できる。
アプリをクリックすると詳細画面に遷移して、スクリーンショットやニュースが見れる。

## 目指した課題解決
1日6000万人(2020年度)のSteam利用者のために、Steamに不足してる機能を補った価格比較サイトを作成した。
Steamの検索機能は使い難いので、より使いやすい検索機能を実装した。
また、Steamではセール履歴が残らないので、時系列順に確認できるようにした。

## 洗い出した要件
Steam-API
Webスクレイピング
アプリ一覧表示
アプリ詳細表示
キーワード検索
タグ検索
価格履歴
ページネーション
ニュース履歴

## 実装した機能についての画像やGIFおよびその説明
Steam-API
[![Image from Gyazo](https://i.gyazo.com/32eedf3e9de2ef21045ecb5b739838f6.png)](https://gyazo.com/32eedf3e9de2ef21045ecb5b739838f6)

Webスクレイピング
[![Image from Gyazo](https://i.gyazo.com/fea982dea28d4cf90ec9451b6a6ee94c.png)](https://gyazo.com/fea982dea28d4cf90ec9451b6a6ee94c)

アプリ一覧表示
[![Image from Gyazo](https://i.gyazo.com/d0ff4e96acfe4280804140678e91ced7.png)](https://gyazo.com/d0ff4e96acfe4280804140678e91ced7)

アプリ詳細表示
[![Image from Gyazo](https://i.gyazo.com/b846417db1fd4d31aedfc41833239c74.jpg)](https://gyazo.com/b846417db1fd4d31aedfc41833239c74)

キーワード検索
[![Image from Gyazo](https://i.gyazo.com/db279cd6477635ba58941d1cd8e5c1e5.png)](https://gyazo.com/db279cd6477635ba58941d1cd8e5c1e5)

タグ検索
[![Image from Gyazo](https://i.gyazo.com/beb1c9abef2ce27f5074a0c8c2239921.png)](https://gyazo.com/beb1c9abef2ce27f5074a0c8c2239921)

価格履歴
[![Image from Gyazo](https://i.gyazo.com/0b286758bce07ede8088800b83fc4d56.png)](https://gyazo.com/0b286758bce07ede8088800b83fc4d56)

ページネーション
[![Image from Gyazo](https://i.gyazo.com/0fd7e0c05b15e3cca53a34f772c70c7d.png)](https://gyazo.com/0fd7e0c05b15e3cca53a34f772c70c7d)

ニュース履歴
[![Image from Gyazo](https://i.gyazo.com/3be87c98296f224bbda6845efee9614a.png)](https://gyazo.com/3be87c98296f224bbda6845efee9614a)

## 実装予定の機能
定期的にアプリの情報を自動収集するBOT機能

## データベース設計
![](2021-08-22-18-46-49.png)

## ローカルでの動作方法
git clone <https://steam-app-36233.herokuapp.com/>
cd steam-app-36233
bundle install
yarn install
rails db:create
rails db:migrate
rails s