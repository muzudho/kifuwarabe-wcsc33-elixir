defmodule KifuwarabeWcsc33.CLI.Helpers.PositionParser do
  @doc """
  
    解析
  
  ## 引数
  
    * `line` - 一行の文字列。例参考
  
  ## 例
  
    position startpos moves 7g7f 3c3d 2g2f
    position sfen lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL w - 1 moves 5a6b 7g7f 3a3b
  
    // 📖 [USIプロトコル表記: 最多合法手５９３手の局面](https://ameblo.jp/professionalhearts/entry-10001031814.html)
    position sfen R8/2K1S1SSk/4B4/9/9/9/9/9/1L1L1L3 w RBGSNLP3g3n17p 1
  
    // 📖 [USIプロトコル表記: 飛角落ち初期局面](http://www.geocities.jp/shogidokoro/usi.html)
    position sfen lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL w - 1 moves 5a6b 7g7f 3a3b
  
  """
  def parse(line) do
    IO.puts("parse-1 line:#{line}")

    rest =
      if line |> String.starts_with?("position startpos") do
        # TODO 平手初期局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        line |> String.slice(String.length("position startpos")..-1) |> String.trim_leading()
      else
        # pass
        line
      end

    IO.puts("parse-2 rest:#{rest}")

    rest =
      if rest |> String.starts_with?("position sfen") do
        # TODO 途中局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        rest = line |> String.slice(String.length("position sfen")..-1) |> String.trim_leading()

        IO.puts("parse-3 rest:#{rest}")

        #
        # 盤の符号 ９一、８一、７一 …と読んでいく。１九が最後。
        # 10ずつ減っていき、十の位が無くなったら一の位が増える。
        #
        # TODO こんなん毎回生成したくないぞ
        # sequence = KifuwarabeWcsc33.CLI.Models.Sequence.new()
        #
        # show_sq = fn sq -> IO.puts("sq:#{sq}") end
        #
        # sequence.address_list
        # |> Enum.map(show_sq)

        # TODO 盤面部分を解析
        result = []
        tuple = rest |> parse_board(result)
        rest = tuple |> elem(0)
        result = tuple |> elem(1)
        IO.inspect(result, label: "The result list is")

        IO.puts("parse-4 rest:#{rest}")

        # 手番の解析
        tuple = rest |> parse_turn()
        rest = tuple |> elem(0)
        turn = tuple |> elem(1)
        IO.puts("parse-5 rest:#{rest} turn:#{turn}")

        # 駒台（持ち駒の数）の解析
        hand_list = []
        tuple = rest |> parse_hands(hand_list)
        rest = tuple |> elem(0)
        turn = tuple |> elem(1)
        IO.puts("parse-6 rest:#{rest} turn:#{turn}")
        IO.inspect(hand_list, label: "The hand list is")

        rest
      else
        # pass
        rest
      end
  end

  # 盤面部分を解析
  #
  # ## 例
  #
  # lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL
  #
  # ## 雑談
  #
  # デービッド・フォーサイスさんの発案したチェスの盤面の記録方法（１行ごとに縦線 | で区切る）を、
  # スティーブン・J・エドワーズさんがコンピューター・チェスのメーリングリストで１０年がかりで意見を取り入れてコンピューター向けに仕様を決めたもの
  defp parse_board(rest, result) do
    # こうやって、１文字ずつ取っていけるけど……
    tuple = parse_piece_on_board(rest, result)
    is_ok = elem(tuple, 0)
    rest = elem(tuple, 1)
    result = elem(tuple, 2)

    if is_ok do
      # Recursive
      parse_board(rest, result)
    else
      # Basecase
      {rest, result}
    end
  end

  # 字を解析して、駒または :none を返す
  #
  # ## Parameters
  #
  #   * `rest` - 残りの文字列
  #   * `result` - 成果物のリスト
  #
  defp parse_piece_on_board(rest, result) do
    if rest |> String.length() < 1 do
      # base case

      # 何の成果も増えません。計算終了
      {false, rest, result}
    else
      # recursive

      # こうやって、１文字ずつ取りだして、減らしていけるけど……
      first_char = rest |> String.at(0)
      IO.puts("parse_piece_on_board char:[#{first_char}]")
      rest = rest |> String.slice(1..-1)

      cond do
        # 本将棋の盤上の１行では、連続するスペースの数は最大で１桁に収まる
        Regex.match?(~r/^\d$/, first_char) ->
          # 空きマスが何個連続するかの数
          space_num = String.to_integer(first_char)
          # 愚直な方法
          result =
            case space_num do
              1 -> result ++ [:sp]
              2 -> result ++ [:sp, :sp]
              3 -> result ++ [:sp, :sp, :sp]
              4 -> result ++ [:sp, :sp, :sp, :sp]
              5 -> result ++ [:sp, :sp, :sp, :sp, :sp]
              6 -> result ++ [:sp, :sp, :sp, :sp, :sp, :sp]
              7 -> result ++ [:sp, :sp, :sp, :sp, :sp, :sp, :sp]
              8 -> result ++ [:sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp]
              9 -> result ++ [:sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp]
              _ -> raise "unexpected space_num:#{space_num}"
            end

          {true, rest, result}

        # 成り駒
        first_char == "+" ->
          second_char = rest |> String.at(0)

          promoted_piece =
            KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(first_char <> second_char)

          result = result ++ [promoted_piece]
          rest = rest |> String.slice(1..-1)
          {true, rest, result}

        # 段の区切り
        first_char == "/" ->
          # 何の成果も増えません
          {true, rest, result}

        # 盤の区切り
        first_char == " " ->
          # 何の成果も増えません。計算終了
          {false, rest, result}

        # それ以外
        true ->
          piece = KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(first_char)
          result = result ++ [piece]
          {true, rest, result}
      end
    end
  end

  # 指定局面の手番の解析
  #
  # w （Whiteの頭文字）なら、せんて（Sente；先手）
  # b （Blackの頭文字）なら、ごて（Gote；後手）
  defp parse_turn(rest, hand_list) do
    # ２文字取る
    first_chars = rest |> String.slice(0..1)
    IO.puts("parse_piece_on_board chars:[#{first_chars}]")
    rest = rest |> String.slice(2..-1)

    turn =
      case first_chars do
        "w " -> :sente
        "b " -> :gote
        _ -> raise "unexpected first_chars:#{first_chars}"
      end

    {rest, turn}
  end

  # 駒台（持ち駒の数）の解析
  defp parse_hands(rest) do
    # 先頭の１文字（取りださない）
    first_char = rest |> String.at(0)
    IO.puts("parse_hands first_char:[#{first_char}]")
    # rest = rest |> String.slice(1..-1)

    if first_char == "-" do
      # 持ち駒１つもなし
      rest = rest |> parse_piece_type_on_hands(0)
    else
    end

    rest
  end

  # 持ち駒の種類１つ分の解析
  #
  # 数字が出てきたら、もう１回再帰
  #
  # ## Returns
  #
  #   * 0 - レスト（Rest；残りの文字列）
  #   * 1 - ナンバー（Number；駒の数）
  #   * 2 - ピース・タイプ（Piece Type；駒の種類）
  #
  defp parse_piece_type_on_hands(rest, number) do
    # 先頭の１文字切り出し
    first_char = rest |> String.at(0)
    IO.puts("parse_piece_type_on_hands first_char:[#{first_char}]")
    rest = rest |> String.slice(1..-1)

    cond do
      # 数字が出てきたら
      Regex.match?(~r/^\d$/, first_char) ->
        # ２つ目の数字は一の位なので、以前の数は十の位なので、10倍する
        number = 10 * number + String.to_integer(first_char)
        # Recursive
        tuple = parse_piece_type_on_hands(rest, number)
        rest = tuple |> elem(0)
        number = tuple |> elem(1)
        piece_type = tuple |> elem(2)
    end

    {rest, number, piece_type}
  end
end
