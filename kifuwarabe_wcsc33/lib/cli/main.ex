defmodule KifuwarabeWcsc33.CLI.Main do
  @doc """
  ## 雑談

      このメソッドは、コンソール・アプリケーションのエントリー・ポイントではなく、
      本来はスーパーバイザーの開始を書くメソッドだが、Elixirのスーパーバイザーが気に入らないので書かない。
  """
  def start(_type, _args) do
    # Elixirのロガーが気に入らないので、正常時には出ないようにする
    Logger.configure(level: :error)

    # デバッグ・フラグ表示
    if KifuwarabeWcsc33.CLI.Config.is_debug?() do
      IO.puts("[main] is_debug? : #{KifuwarabeWcsc33.CLI.Config.is_debug?()}")
    end

    if KifuwarabeWcsc33.CLI.Config.is_debug_utifudume_check?() do
      IO.puts(
        "[main] is_debug_utifudume_check? : #{KifuwarabeWcsc33.CLI.Config.is_debug_utifudume_check?()}"
      )
    end

    # 局面データ
    pos = KifuwarabeWcsc33.CLI.Models.Position.new()

    # USIプロトコル対応
    usi_loop(pos)

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

  # ## プライベート関数にドキュメント・コメントは付けれない
  #
  #   プライベート関数に @doc """ """ を付けても、プライベート関数はドキュメントに出力されないよ？という警告が出る。めんどくさ
  #
  # ## 雑談
  #
  #   コンピューター将棋の USIプロトコル（2007年1月17日原案公開。原案：トード・ロムスタッド。保守：将棋所）は、プロトコルとして基本が成ってないと言われることがあるが、
  #   そもそも オリジナルの UCIプロトコル（2000年11月原案公開。原案：ステファン・メイヤー＝カーレン）は もともと、仕様がバラバラで
  #   対局するのも一苦労だったコンピューター・チェス・エンジン同士を、１つのマシンで対局させることができる初めての仕様であり、
  #   2020年のWeb時代の感覚で見ると物足りないのは、みな分かって使っているので、納得して従うことにする
  #
  #   USIの最新の動向は、やねうらおさんの MyShogi を参考にされたい
  #   https://github.com/yaneurao/MyShogi/blob/master/MyShogi/docs/USI2.0.md
  #
  #   また、 USI はコンピューター・チェス由来であり、 WCSC（世界コンピューター将棋選手権）とは関りがない。
  #   WCSCではCSAプロトコルを使う。
  #   しかし、「将棋所」を使うと、USIプロトコルで書かれた将棋エンジンに代わって CSAプロトコルで通信してくれる
  #   http://shogidokoro.starfree.jp/
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #
  defp usi_loop(pos) do
    # 標準入力を受け取る |> 末尾の改行を削除するために trim() を使う
    input = IO.gets("") |> String.trim_trailing()
    # IO.puts("input:" <> input)

    # |> 文字列を空白で区切ってリストにする
    rest_tokens = input |> String.split(" ")
    # IO.puts("rest_tokens:" <> Enum.join(rest_tokens, ""))

    # 先頭の要素を取る
    # ==============
    #
    # 公式のガイドによると、Elixier ではリストへの添え字アクセスは遅いらしい。先頭の要素を取るのが高速なので、 hd という操作がある。 tl は、２番目以下の要素のリスト
    first_token = hd(rest_tokens)
    rest_tokens = tl(rest_tokens)
    # IO.puts("first_token:" <> first_token)

    #
    # Elixirに if～else-if～else 構造はない。 case文かcond文を使う。
    {pos} =
      cond do
        first_token == "usi" ->
          # > | usi             | (GUIから私へ) お前はUSIプロトコル対応エンジンか？
          # < | id name xxxx    | (私からGUIへ) エンジンの名前は xxxx だぜ
          # < | id author xxxx  |              エンジンの著者の名前は xxxx だぜ
          # < | usiok           |              情報終わり。はい、USIプロトコル対応エンジンだぜ

          # 将棋エンジン名 - （省略可） GUIに表示される。エンジンを選ぶのに使う。WCSC大会では使わないから、エンジンを区別しやすい名前がいい
          IO.puts("id name Kifuwaraxir")

          # エンジンの作者名 - (省略可) GUIでエンジンを選ぶときに表示されることがあるぐらい。WCSC大会では使わないから、エンジンを区別しやすい名前がいい
          IO.puts("id author TAKAHASHI satoshi")
          IO.puts("usiok")
          {pos}

        first_token == "isready" ->
          # > | isready | (GUIから私へ) 命令送ったら応答できんの？
          # < | readyok | (私からGUIへ) なんでもこい
          IO.puts("readyok")
          {pos}

        first_token == "usinewgame" ->
          # > | usinewgame  | (GUIから私へ) 新しい対局を始める。このタイミングで、前回の対局情報をクリアーしてもらってもかまわない
          #   | 　　　　　　 | (私からGUIへ送るものは何もありません)
          {pos}

        first_token == "position" ->
          # > | position  | (GUIから私へ) 現在の局面を作るのに必要な全データを送る。まだ何も応答するな
          #   | 　　　　    | (私からGUIへ送るものは何もありません)

          # 局面は、丸ごと差し替えだ
          pos = KifuwarabeWcsc33.CLI.Helpers.PositionParser.parse(input)

          # TODO 消す。盤表示
          IO.puts(KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

          {pos}

        first_token == "go" ->
          # > | position        | (GUIから私へ) さっき送った局面に対して、指し手を返せ
          # < | bestmove xxxx   | (私からGUIへ) (指し手を返す)

          # 探索開始時刻
          start_time = :os.system_time(:millisecond)

          # 現局面から、最善手を１つ選ぶ
          {pos, best_move, value, nodes_num_searched} = KifuwarabeWcsc33.CLI.USI.Go.do_it(pos)

          # 探索終了時刻
          end_time = :os.system_time(:millisecond)
          # 処理時間（単位：ミリ秒）
          time = end_time - start_time
          # 処理時間（単位：秒）
          elapsed_seconds = time / 1000
          # IO.puts("[main] go elapsed_seconds:#{elapsed_seconds} sec")

          best_move_as_str = KifuwarabeWcsc33.CLI.Views.Move.as_code(best_move)

          depth = KifuwarabeWcsc33.CLI.Config.depth()

          # エヌ・ピー・エス（NPS；ノード数／秒）は、Node Per Second だから 秒で割る
          # とりあえず　小数点以下切り捨て
          nps = trunc(nodes_num_searched/elapsed_seconds)


          #
          # 指し手の説明
          # ===========
          #
          # - ４手に１回は Flow を使って並列処理をするときのコメント
          #
          remain = rem(pos.moves_num,8)
          comment = "Hello, GPU! (I just made a table cleared by zero) Ok."

          comment =
            if remain == 1 or remain == 2 or remain == 5 or remain == 6 do
              comment <> "Hello, CUDA! The remainder of the #{pos.moves_num}(th) move divided by 8 is #{remain}."
            else
              comment <> "See you later CUDA. I'll play single-threaded!"
            end

          comment =
            comment <>
              cond do
                remain == 1 or remain == 2 ->
                  " So parallel processing of move generation! (Just move the pieces on the board)"
                remain == 5 or remain == 6 ->
                  " So parallel processing of move generation! (Just drop the pieces)"
                true ->
                  ""
              end

          IO.puts("info depth #{depth} time #{time} nodes #{nodes_num_searched} score cp #{value} nps #{nps} string #{comment}")

          IO.puts("bestmove #{best_move_as_str}")
          {pos}

        first_token == "quit" ->
          # > | quit  | (GUIから私へ) エンジン止めろ、アプリケーション終了しろ
          #   | 　　　 | (私からGUIへ送るものは何もありません)

          # Elixirで 終了処理は、どう書けばいいのか？
          # exit(0)
          System.stop()
          {pos}

        # 以下は、USIプロトコルにないコマンド
        # ==============================
        #
        # * `pos` - ポジション表示
        #
        first_token == "pos" ->
          # > | quit  | (ターミナルから私へ) 将棋盤を表示して
          # < | 　　　 | (私からターミナルへ) 将棋盤を表示

          # 盤表示
          IO.puts(KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

          {pos}

        #
        # * `do` - 一手指す
        #
        # ## Examples
        #
        #   do 7g7f
        #   -- ----
        #   0  1
        #
        first_token == "do" ->
          IO.inspect(rest_tokens, label: "[main usi_loop] rest_tokens")
          best_move_str = hd(rest_tokens)
          # rest_tokens = tl(rest_tokens)
          IO.puts("[main usi_loop] best_move:#{best_move_str}")

          # コードを、指し手へ変換
          {_rest, best_move} =
            KifuwarabeWcsc33.CLI.Mappings.ToMove.from_code_line(
              String.split(best_move_str, "", trim: true)
            )

          # 一手指す
          pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.DoMove.do_it(best_move)

          best_move_str = KifuwarabeWcsc33.CLI.Views.Move.as_code(best_move)
          # 盤表示
          IO.puts(
            """
            [main usi_loop] Do #{best_move_str}.

            """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos)
          )

          {pos}

        #
        # * `undo` - 一手戻す
        #
        # ## Examples
        #
        #   undo
        #   ----
        #   0
        #
        first_token == "undo" ->
          # 一手戻す
          pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.UndoMove.do_it()

          # 盤表示
          IO.puts(
            """
            [main usi_loop] Undone.

            """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos)
          )

          {pos}

        # Otherwise
        true ->
          # 対応していないメッセージは無視します
          IO.puts(
            "Hi! I am a Kifuwarabe. It's start! first_token[" <>
              first_token <> "] input:" <> input
          )

          {pos}
      end

    # 再帰ループ
    usi_loop(pos)
  end
end
