defmodule KifuwarabeWcsc33.CLI do
  # このメソッドは、コンソール・アプリケーションのエントリー・ポイントではなく、
  # 本来はスーパーバイザーの開始を書くメソッドだが、Elixirのスーパーバイザーが気に入らないので書かない。
  def start(_type, _args) do
    # Elixirのロガーが気に入らないので、正常時には出ないようにする
    Logger.configure(level: :error)

    # 標準入力を受け取る |> 末尾の改行を削除するために trim() を使う
    input = IO.gets("") |> String.trim_trailing()

    # コンピューター将棋の USIプロトコル（2007年1月17日原案公開。原案：トード・ロムスタッド。保守：将棋所）は、プロトコルとして基本が成ってないと言われることがあるが、
    # そもそも オリジナルの UCIプロトコル（2000年11月原案公開。原案：ステファン・メイヤー＝カーレン）は もともと、仕様がバラバラで
    # 対局するのも一苦労だったコンピューター・チェス・エンジン同士を、１つのマシンで対局させることができる初めての仕様であり、
    # 2020年のWeb時代の感覚で見ると物足りないのは、みな分かって使っているので、納得して従うことにする
    #
    # USIの最新の動向は、やねうらおさんの MyShogi を参考にされたい
    # https://github.com/yaneurao/MyShogi/blob/master/MyShogi/docs/USI2.0.md
    #
    # また、 USI はコンピューター・チェス由来であり、 WCSC（世界コンピューター将棋選手権）とは関りがない。
    # WCSCではCSAプロトコルを使う。
    # しかし、「将棋所」を使うと、USIプロトコルで書かれた将棋エンジンに代わって CSAプロトコルで通信してくれる
    # http://shogidokoro.starfree.jp/
    #
    # Elixirに if～else-if～else 構造はない。 case文かcond文を使う。
    cond do
      input == "usi" ->
        # > | usi             | (GUIから私へ) お前はUSIプロトコル対応エンジンか？
        # < | id name xxxx    | (私からGUIへ) エンジンの名前は xxxx だぜ
        # < | id author xxxx  |              エンジンの著者の名前は xxxx だぜ
        # < | usiok           |              情報終わり。はい、USIプロトコル対応エンジンだぜ

        # 将棋エンジン名 - （省略可） GUIに表示される。エンジンを選ぶのに使う。WCSC大会では使わないから、エンジンを区別しやすい名前がいい
        IO.puts("id name Kifuwaraxir")

        # エンジンの作者名 - (省略可) GUIでエンジンを選ぶときに表示されることがあるぐらい。WCSC大会では使わないから、エンジンを区別しやすい名前がいい
        IO.puts("id author TAKAHASHI satoshi")
        IO.puts("usiok")

      input == "isready" ->
        # > | isready | (GUIから私へ) 命令送ったら応答できんの？
        # < | readyok | (私からGUIへ) なんでもこい
        IO.puts("readyok")

      input == "usinewgame" ->
        # > | usinewgame  | (GUIから私へ) 新しい対局を始める。このタイミングで、前回の対局情報をクリアーしてもらってもかまわない
        #   | 　　　　　　 | (私からGUIへ送るものは何もありません)
        nil

      input == "position" ->
        # > | position  | (GUIから私へ) 現在の局面を作るのに必要な全データを送る。まだ何も応答するな
        #   | 　　　　　　 | (私からGUIへ送るものは何もありません)
        nil

      input == "go" ->
        # > | position        | (GUIから私へ) さっき送った局面に対して、指し手を返せ
        # < | bestmove resign | (私からGUIへ) (指し手を返す)
        IO.puts("bestmove resign")

      input == "quit" ->
        # > | quit  | (GUIから私へ) エンジン止めろ、アプリケーション終了しろ
        #   | 　　　 | (私からGUIへ送るものは何もありません)
        System.stop()
        nil

      # 以下は、USIプロトコルにないコマンド
      input == "board" ->
        # > | quit  | (ターミナルから私へ) 将棋盤を表示して
        # < | 　　　 | (私からターミナルへ) 将棋盤を表示
        nil

      # Otherwise
      true ->
        IO.puts("Hi! I am a Kifuwarabe. It's start! " <> input)
    end

    # 本来は、スーパーバイザーのPIDを返却する
    {:ok, self()}
  end

  # Elixirに複数行コメントは無い。 関数の中では @doc、モジュールの中では @moduledoc を使う。マクロの中ではコメントは書けない
  @moduledoc """
  # if～else文の使い方
  if input = "usi" do
    IO.puts("id name Kifuwarabe")
    IO.puts("id author TAKAHASHI satoshi")
    IO.puts("usiok")
  else
    IO.puts("Hi! I am a Kifuwarabe. It's start! " <> input)
  end
  """
end
