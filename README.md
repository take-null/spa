# Referer-hub

![gif](https://github.com/take-null/spa/blob/main/image/main.JPG)

## テーマ

このアプリケーションは読書好きのユーザーが

〇読んだ書籍の情報を記録する  
〇書評の投稿を通じて他のユーザーと情報共有を行う  
〇投稿された書評を表示するタイムラインを通じて新しい本と出会う  
〇他のユーザーとリアルタイムでコミュニケーションを取れる  

事をテーマに制作されています。

## 制作の背景

私は、自身が学習した結果を成果物として示したいと思っていました。  
そしてテーマ設定を具体化するため、公立図書館からヒントを得ようとしました。  
来館者の動向や実際に運用されているサービスを観察した結果  

〇図書館には特定の本を探して来館する者だけでなく、他者が推薦する図書を求めて来る者が多い  
〇来館者の中には職員や他の来館者との緩やかなコミュニケーションを求める者が多い  

という事に気づきました。

その結果、実際に運用されている「推薦図書スペース」「共用スペース(交流の場としても機能している)」をインターネット上で再現したいと思い、本アプリケーションを制作しました。

url サーバー移行のため、現在公開停止中です。

## AWS構成図

![gif](https://github.com/take-null/spa/blob/main/image/%E3%82%A4%E3%83%B3%E3%83%95%E3%83%A9%E6%A7%8B%E6%88%90%E5%9B%B3.png)

## ER図

![gif](https://github.com/take-null/spa/blob/main/image/%E3%82%AD%E3%83%A3%E3%83%97%E3%83%81%E3%83%A3%EF%BC%92.JPG)

## 使用技術

〇フロントエンド  
HTML/CSS/JavaScript/Nuxt.js+Vuetify/JEST  
※SPAモード

〇バックエンド  
Ruby3.0.2/Ruby on Rails6.1.3/Rspec  
※Apiモード

〇インフラ  
Docker/CircleCI/AWS(ECS,EC2)  

## 工夫した点

〇UI/UX  
派手な装飾を避け、かつ、既視感のあるインターフェイスにまとめました。  
Welcomeページ(下記のデモに同じ)のスライドを見ればユーザーが直感的に動作を把握できる画面設計を心掛けました。  
レスポンシブ対応(最低画面幅320(Iphone7相当))を実現しています。  
画面幅を自動計算し、画面サイズを変更してもリアルタイムで最適な表示になります。  

〇全体の構成  
気軽に利用できるよう完全SPA化し、高速に動作するWebアプリケーションにしました。  
気の合うユーザー同士がストレス無く繋がれるようWebsocket通信を用いてリアルタイムでメッセージの交換を行えるようにしました。  
通知機能等により、他のユーザーからのリアクションが把握できるようになっています。  
外部Apiから取得した情報はデータベースに登録されるため、長期的に運用する上で機能を拡張しやすい構成になっています。  

〇インフラ構成  
CircleClによる自動テストとAWSへの自動デプロイを行う事で開発効率を上げ、コードの品質を一定に保った状態で迅速なデプロイを可能にしました。  

## デモ
タイムライン
![gif](https://github.com/take-null/spa/blob/main/front/assets/img/timeline.gif)
本の検索と投稿
![gif](https://github.com/take-null/spa/blob/main/front/assets/img/post.gif)
ユーザーのマイページ
![gif](https://github.com/take-null/spa/blob/main/front/assets/img/mypage.gif)
リアルタイムチャット
![gif](https://github.com/take-null/spa/blob/main/front/assets/img/chat.gif)

## 機能一覧

ユーザー登録機能  
ログイン機能  
ログアウト機能  
ゲストログイン機能  
ユーザー情報編集(アバター、プロフィール情報、パスワード)機能
ユーザー退会機能  
メーラーとTokenを用いたパスワードリセット機能  
フォロー機能  
ユーザーマイページ(ユーザー情報及び本棚(投稿データ)等)表示機能  
通知機能(フォロー通知、投稿に対するグッド通知)  
DM機能(チャットルーム作成及びリアルタイムチャット)  
チャットルーム一覧及び新着チャット表示機能  
タイムライン機能  
タグ検索機能  
書籍ランキング表示及び検索機能  
無限スクロール機能(リロードが不可能になると自動で先頭に戻ります)  
書籍検索機能(GoogleBooksApi)  
書評投稿機能(レーティング(５段階)、タグ(自由入力可)、コメント)  
書評削除機能
メーラーを利用したユーザーアンケート機能  
