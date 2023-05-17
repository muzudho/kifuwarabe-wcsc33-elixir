# kifuwarabe-wcsc33-written-in-elixir-for-windows

きふわらべWCSC33

## 免責

* escriptは気に入らないので、使わない
* Elixirのロガーが気に入らないので、表示レベルは「エラー」にする
* Elixirのスーパーバイザーが気に入らないので、使わない

# インストール

## Elixir のインストール

1. 📖 [Elixirをインストール](https://elixir-lang.jp/install.html)
    * Edge でインストールできなければ、 Google Chrome や Firefox も使ってみる
2. Windowsでも、ビルドパスを手動で設定しなくても、自動で設定してくれているはず
    * 例： `C:\Program Files (x86)\Elixir`

## モジュールのダウンロード

```shell
cd kifuwarabe_wcsc33
# Example: C:\GitHub\kifuwarabe-wcsc33-written-in-elixir-for-windows\kifuwarabe_wcsc33>

mix deps.get
```

Hex のインストールを尋ねられたら、 `y` キーを打鍵してインストールしろ  

# 実行方法

### その前に、注意すること

初回実行時はコンパイルをしたという出力が出る（この出力が邪魔だ）。  
二度目以降はその出力は出ない。最初は１回、空実行しろ  

### ターミナルから実行するケース

```shell
cd kifuwarabe_wcsc33
# Example: C:\GitHub\kifuwarabe-wcsc33-written-in-elixir-for-windows\kifuwarabe_wcsc33>

main.bat
```

または

```shell
cd kifuwarabe_wcsc33
# Example: C:\GitHub\kifuwarabe-wcsc33-written-in-elixir-for-windows\kifuwarabe_wcsc33>

mix run
```

### Windows デスクトップ・アプリケーション（将棋所）から実行するケース

📖 [将棋所](http://shogidokoro.starfree.jp/) をダウンロードしろ  

# 開発環境の設定

* エディター
    * Visual Studio Code
* 入れる拡張
    * ElixirLS
* 入れない拡張
    * vscode-elixir (by Mat McLoughlin) - ElixirLS と相性が悪い

# 実行ファイルの作り方

👇 説明通りやっても作れない。分けわからん  

```shell
mix release
```

# References

📖 [TODO List](./docs/todo_list.md)
📖 [references.md](./docs/references.md) - あとで読む
