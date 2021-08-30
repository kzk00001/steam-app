## アプリケーション名
SteamApp

## アプリケーション概要
Steamに登録されているアプリを検索しやすくする。

## URL
https://steam-app-36233.herokuapp.com/

## テスト用アカウント
Basic認証<br>
ID: admin<br>
Pass: 4805

## 利用方法
トップページにSteamに登録されているアプリ一覧が表示される。<br>
キーワードやタグを入力してアプリを検索できる。<br>
アプリ一覧は、レビュー評価順・割引率順・リリース日順に並び替えることが出来る。<br>
アプリをクリックすると詳細画面に遷移して、スクリーンショットやニュースが確認できる。<br>
購入したい場合はStoreボタンをクリックすると、Steamのストアページに遷移する。

## 目指した課題解決
Steam利用者(6000万人/日,2020年度)のために、本家サイトで不足してる検索機能・セール履歴の保存機能を補った価格比較サイトを作成した。<br>
特徴的な機能は、アプリ一覧表示画面にタグを表示して、類似したアプリを辿って検索しやすくした。<br>
また、アプリ一覧表示画面をレビュー評価順・割引率順などで並び替えれるようにした。

## 洗い出した要件
Steam-API<br>
Webスクレイピング<br>
アプリ一覧表示<br>
アプリ詳細表示<br>
キーワード検索<br>
タグ検索<br>
価格履歴<br>
ページネーション<br>
ニュース履歴<br>
Webスクレイピングの定期実行

## 実装した機能についての画像やGIFおよびその説明
#### Steam-API<br>
Steam-APIからJSON形式で、Steam内に登録されているアプリのID・タイトル名のリストが入手できるので、配列を整形してデータベースに保存する
[![Image from Gyazo](https://i.gyazo.com/32eedf3e9de2ef21045ecb5b739838f6.png)](https://gyazo.com/32eedf3e9de2ef21045ecb5b739838f6)
***
Webスクレイピング<br>
nokogiriというWebスクレイピング用のgemを利用して、ストアページのタグ・クラス名などを標的に、必要なデータを抽出してデータベースに保存する
[![Image from Gyazo](https://i.gyazo.com/fea982dea28d4cf90ec9451b6a6ee94c.png)](https://gyazo.com/fea982dea28d4cf90ec9451b6a6ee94c)

アプリ一覧表示<br>
アプリのヘッダー画像、価格、セール情報、ユーザーレビュー、紹介文等の情報を、アプリごとに一覧表示する
[![Image from Gyazo](https://i.gyazo.com/d0ff4e96acfe4280804140678e91ced7.png)](https://gyazo.com/d0ff4e96acfe4280804140678e91ced7)

アプリ詳細表示<br>
一覧表示画面で確認できる情報に加えて、スクリーンショットのサムネイルや最近のニュースといった詳細情報を、アプリごとに個別に表示する
[![Image from Gyazo](https://i.gyazo.com/b846417db1fd4d31aedfc41833239c74.jpg)](https://gyazo.com/b846417db1fd4d31aedfc41833239c74)

キーワード検索<br>
ransakというgemを利用して、入力されたキーワードから、データベース内にあるアプリのタイトル名を、あいまい検索する
[![Image from Gyazo](https://i.gyazo.com/db279cd6477635ba58941d1cd8e5c1e5.png)](https://gyazo.com/db279cd6477635ba58941d1cd8e5c1e5)

タグ検索<br>
ransakというgemを利用して、アプリに紐付けられたタグから、データベース内にある同様のタグで紐付いたアプリを、完全一致検索する
[![Image from Gyazo](https://i.gyazo.com/beb1c9abef2ce27f5074a0c8c2239921.png)](https://gyazo.com/beb1c9abef2ce27f5074a0c8c2239921)

価格履歴<br>
chartkickというgemを利用して、アプリと紐付いた価格情報を、時系列順にグラフ表示する
[![Image from Gyazo](https://i.gyazo.com/0b286758bce07ede8088800b83fc4d56.png)](https://gyazo.com/0b286758bce07ede8088800b83fc4d56)

ページネーション<br>
kaminariというgemを利用して、アプリを20件ずつ一覧表示する
[![Image from Gyazo](https://i.gyazo.com/0fd7e0c05b15e3cca53a34f772c70c7d.png)](https://gyazo.com/0fd7e0c05b15e3cca53a34f772c70c7d)

ニュース履歴<br>
Steam-APIからJSON形式でリストが入手できるので、配列を整形してデータベースに保存する
[![Image from Gyazo](https://i.gyazo.com/3be87c98296f224bbda6845efee9614a.png)](https://gyazo.com/3be87c98296f224bbda6845efee9614a)

Webスクレイピングの定期実行<br>
Webスクレイピングの処理をメソッド化して、Heroku Schedulerを利用して定期実行する
[![Image from Gyazo](https://i.gyazo.com/6ad1373b27ab429bc843cab3c55fc38c.png)](https://gyazo.com/6ad1373b27ab429bc843cab3c55fc38c)

## 実装予定の機能

## データベース設計
![](2021-08-22-18-46-49.png)

## ローカルでの動作方法
git clone <https://steam-app-36233.herokuapp.com/><br>
cd steam-app-36233<br>
bundle install<br>
yarn install<br>
rails db:create<br>
rails db:migrate<br>
rails s