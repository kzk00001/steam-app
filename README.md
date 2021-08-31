## アプリケーション名
SteamApp

## アプリケーション概要
Steamに登録されているアプリを検索して購入しやすくする価格比較サイト。

## URL
https://steam-app-36233.herokuapp.com/

## テスト用アカウント
Basic認証<br>
ID: admin<br>
Pass: 4805

## 利用方法
トップページに、Steamに登録されているアプリ一覧が表示される。<br>
キーワードやタグを入力して、アプリを検索できる。<br>
アプリ一覧は、レビュー評価順・割引率順・リリース日順に並び替えることが出来る。<br>
アプリ欄をクリックすると、詳細画面に遷移してスクリーンショットやニュースが確認できる。<br>
購入したい場合は、StoreボタンをクリックするとSteamのストアページに遷移する。

## 目指した課題解決
Steam利用者(6000万人/日,2020年度)のために、本家サイトで不足してる機能を補った価格比較サイトSteamAppを作成した。<br>
Steam URL: https://store.steampowered.com/?l=english<br>
<br>
SteamAppの具体的な機能は、キーワード検索・タグ検索を組み合わせた検索機能と、セール履歴の保存機能である。<br>
普段Steamを利用していて不便なのが、検索機能がお粗末なことと、セール履歴が残らないことだった。<br>
そのため、上記の欠点を補った価格比較サイトを、趣味と実益を兼ねて作成した。<br>
<br>
SteamAppの詳細な改善点は、キーワード検索・タグ検索機能を組み合わせて使用出来るようになっている。<br>
また、アプリ一覧表示画面にタグ一覧を表示しているので、類似したアプリを辿って検索しやすくなっている。<br>
アプリ一覧表示画面をレビュー評価順・割引率順などで並び替えられるようになっている。<br>
アプリ詳細画面に、アプリの過去と現在の価格情報をグラフ表示するようになっている。

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
### Steam-API<br>
Steam-APIからJSON形式で、Steam内に登録されているアプリのID・タイトル名のリストが入手できるので、配列を整形してデータベースに保存する
[![Image from Gyazo](https://i.gyazo.com/32eedf3e9de2ef21045ecb5b739838f6.png)](https://gyazo.com/32eedf3e9de2ef21045ecb5b739838f6)
***

### Webスクレイピング<br>
nokogiriというWebスクレイピング用のgemを利用して、ストアページのタグ・クラス名などを標的に、必要なデータを抽出してデータベースに保存する
[![Image from Gyazo](https://i.gyazo.com/fea982dea28d4cf90ec9451b6a6ee94c.png)](https://gyazo.com/fea982dea28d4cf90ec9451b6a6ee94c)
***

### アプリ一覧表示<br>
アプリのヘッダー画像、価格、セール情報、ユーザーレビュー、紹介文など購買動機に影響する情報を、アプリごとに一覧表示する
[![Image from Gyazo](https://i.gyazo.com/d0ff4e96acfe4280804140678e91ced7.png)](https://gyazo.com/d0ff4e96acfe4280804140678e91ced7)
***

### アプリ詳細表示<br>
アプリ一覧表示画面で確認できる情報に加えて、スクリーンショットのサムネイルや、現在と過去の価格情報、最近のニュース情報をアプリごとに表示する
[![Image from Gyazo](https://i.gyazo.com/b846417db1fd4d31aedfc41833239c74.jpg)](https://gyazo.com/b846417db1fd4d31aedfc41833239c74)
***

### キーワード検索<br>
ransakというgemを利用して、入力されたキーワード情報から、タイトル名が一致するアプリを、データベース内からあいまい検索する
[![Image from Gyazo](https://i.gyazo.com/db279cd6477635ba58941d1cd8e5c1e5.png)](https://gyazo.com/db279cd6477635ba58941d1cd8e5c1e5)
***

### タグ検索<br>
ransakというgemを利用して、アプリに紐付いたタグ情報から、同様のタグで紐付いているアプリを、データベース内から完全一致検索する
[![Image from Gyazo](https://i.gyazo.com/beb1c9abef2ce27f5074a0c8c2239921.png)](https://gyazo.com/beb1c9abef2ce27f5074a0c8c2239921)
***

### 価格履歴<br>
chartkickというgemを利用して、アプリの過去と現在の価格情報をグラフ表示する
[![Image from Gyazo](https://i.gyazo.com/0b286758bce07ede8088800b83fc4d56.png)](https://gyazo.com/0b286758bce07ede8088800b83fc4d56)
***

### ページネーション<br>
kaminariというgemを利用して、トップページでアプリを20件ずつ一覧表示する
[![Image from Gyazo](https://i.gyazo.com/0fd7e0c05b15e3cca53a34f772c70c7d.png)](https://gyazo.com/0fd7e0c05b15e3cca53a34f772c70c7d)
***

### ニュース履歴<br>
Steam-APIを利用して、JSON形式でニュースのリストを取得する
[![Image from Gyazo](https://i.gyazo.com/3be87c98296f224bbda6845efee9614a.png)](https://gyazo.com/3be87c98296f224bbda6845efee9614a)
***

### Webスクレイピングの定期実行<br>
Heroku Schedulerを利用して、Webスクレイピングの処理を定期実行する
[![Image from Gyazo](https://i.gyazo.com/6ad1373b27ab429bc843cab3c55fc38c.png)](https://gyazo.com/6ad1373b27ab429bc843cab3c55fc38c)

## 実装予定の機能
Webスクレイピングのコードを洗練させる (Herokuはクエリ発行数に制限があるため、Webスクレイピングと相性が悪い)
レビューの詳細表示 (現在はレビューの総評のみ掲載しているため)
アプリ詳細表示画面に動画を掲載 (未掲載のため)
広告表示機能 (収益化のため)

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