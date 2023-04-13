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
    IO.puts("parse(1) line:#{line}")

    rest =
      if line |> String.starts_with?("position startpos") do
        # TODO 平手初期局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        line |> String.slice(String.length("position startpos")..-1) |> String.trim_leading()
      else
        # pass
        line
      end

    IO.puts("parse(2) rest:#{rest}")

    rest =
      if rest |> String.starts_with?("position sfen") do
        # TODO 途中局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        rest = line |> String.slice(String.length("position sfen")..-1) |> String.trim_leading()

        IO.puts("parse(3) rest:#{rest}")

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

        # 盤面部分を解析
        tuple = rest |> parse_board_string_to_piece_list([])
        rest = tuple |> elem(0)
        piece_list_on_board = tuple |> elem(1)
        IO.inspect(piece_list_on_board, label: "parse(4) The piece_list_on_board is")
        IO.puts("parse(5) rest:#{rest}")

        # 手番の解析
        tuple = rest |> parse_turn()
        rest = tuple |> elem(0)
        turn = tuple |> elem(1)
        IO.puts("parse(6) turn:#{turn} rest:#{rest}")

        # 駒台（持ち駒の数）の解析
        tuple = rest |> parse_hands(%{})
        rest = tuple |> elem(0)
        hand_num_map = tuple |> elem(1)
        IO.inspect(hand_num_map, label: "parse(7) The hand number map is")
        IO.puts("parse(8) rest:#{rest}")

        # 次の手は何手目か、を表す数字だが、「将棋所」は「この数字は必ず１にしています」という仕様なので
        # 「将棋所」しか使わないのなら、「1」しかこない、というプログラムにしてしまうのも手だ
        first_char = rest |> String.at(0)
        rest = rest |> String.slice(1..-1)

        if first_char != "1" do
          raise "unexpected first_char:#{first_char}"
        end

        # IO.puts("parse first_char:[#{first_char}]")
        moves_num = String.to_integer(first_char)
        IO.puts("parse(9) moves_num:[#{moves_num}]")

        # 残りの文字列 |> あれば、続くスペースを削除
        rest = rest |> String.trim_leading()

        rest
      else
        # pass
        rest
      end

    # ５文字取る
    first_5chars = rest |> String.slice(0..4)
    rest = rest |> String.slice(5..-1)

    if first_5chars == "moves" do
      # 指し手が付いている場合
      IO.puts("parse(10) first_5chars:[#{first_5chars}]")
      IO.puts("parse(11) rest:#{rest}")

      # TODO 指し手読取
      tuple = rest |> parse_moves_string_to_move_list([])
      rest = tuple |> elem(0)
      move_list = tuple |> elem(1)

      IO.inspect(move_list, label: "parse(12) The hand number map is")
      IO.puts("parse(13) rest:#{rest}")
    else
      # 指し手が付いていない場合
      # 完了
    end
  end

  # 盤面文字列を解析して、駒のリストを返す
  #
  # ## Parameters
  #
  #   * `rest` - 残りの文字列
  #   * `result` - 成果物。ピースのリスト
  #
  # ## Returns
  #
  #   0. レスト（Rest；残りの文字列）
  #   1. リザルト（Result；結果）
  #
  # ## 例
  #
  # lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL
  #
  # ## 雑談
  #
  # デービッド・フォーサイスさんの発案したチェスの盤面の記録方法（１行ごとに縦線 | で区切る）を、
  # スティーブン・J・エドワーズさんがコンピューター・チェスのメーリングリストで１０年がかりで意見を取り入れてコンピューター向けに仕様を決めたもの
  #
  defp parse_board_string_to_piece_list(rest, result) do
    if rest |> String.length() < 1 do
      # base case

      # 何の成果も増えません。計算終了
      {rest, result}
    else
      # recursive

      # こうやって、１文字ずつ取りだして、減らしていけるけど……
      first_char = rest |> String.at(0)
      # IO.puts("parse_board_string_to_piece_list char:[#{first_char}]")
      rest = rest |> String.slice(1..-1)

      # 盤の区切り
      if first_char == " " do
        # base case

        # 何の成果も増えません。計算終了
        {rest, result}
      else
        tuple =
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

              {rest, result}

            # 成り駒
            first_char == "+" ->
              second_char = rest |> String.at(0)

              promoted_piece =
                KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(first_char <> second_char)

              result = result ++ [promoted_piece]
              rest = rest |> String.slice(1..-1)
              {rest, result}

            # 段の区切り
            first_char == "/" ->
              # 何の成果も増えません
              {rest, result}

            # それ以外
            true ->
              piece = KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(first_char)
              result = result ++ [piece]
              {rest, result}
          end

        # Recursive
        # =========

        rest = tuple |> elem(0)
        result = tuple |> elem(1)
        tuple = rest |> parse_board_string_to_piece_list(result)

        # 結果を上に投げ上げるだけ
        rest = tuple |> elem(0)
        result = tuple |> elem(1)
        {rest, result}
      end
    end
  end

  # 指定局面の手番の解析
  #
  # w （Whiteの頭文字）なら、せんて（Sente；先手）
  # b （Blackの頭文字）なら、ごて（Gote；後手）
  defp parse_turn(rest) do
    # ２文字取る
    first_chars = rest |> String.slice(0..1)
    IO.puts("parse_turn chars:[#{first_chars}]")
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
  #
  # ## Returns
  #
  #   * 0 - レスト（Rest；残りの文字列）
  #   * 1 - ハンド・ナンバー・マップ（Hand Number Map；持ち駒と枚数のマップ）
  #
  defp parse_hands(rest, hand_num_map) do
    # 先頭の１文字（取りださない）
    first_char = rest |> String.at(0)
    IO.puts("parse_hands first_char:[#{first_char}]")
    # rest = rest |> String.slice(1..-1)

    if first_char == "-" do
      # 持ち駒１つもなし

      # 先頭の２文字 "- " を切り捨て
      rest = rest |> String.slice(2..-1)

      IO.puts("parse_hands no-hands rest:#{rest}")
      {rest, hand_num_map}
    else
      # 持ち駒あり
      tuple = rest |> parse_piece_type_on_hands(0, hand_num_map)
      rest = tuple |> elem(0)
      hand_num_map = tuple |> elem(1)
      # IO.inspect(hand_num_map, label: "parse_hands hand_num_map")
      IO.puts("parse_hands rest:#{rest}")

      {rest, hand_num_map}
    end
  end

  # 持ち駒の種類１つ分の解析
  #
  # 数字が出てきたら、もう１回再帰
  #
  # ## Returns
  #
  #   * 0 - レスト（Rest；残りの文字列）
  #   * 1 - ハンド・ナンバー・マップ（Hand Number Map；持ち駒と枚数のマップ）
  #
  defp parse_piece_type_on_hands(rest, number, hand_num_map) do
    # 先頭の１文字切り出し
    first_char = rest |> String.at(0)
    # IO.puts("parse_piece_type_on_hands first_char:[#{first_char}]")
    rest = rest |> String.slice(1..-1)

    if first_char == " " do
      # Base case
      # IO.puts("parse_piece_type_on_hands Terminate")
      # 何も成果を増やさず終了
      {rest, hand_num_map}
    else
      tuple =
        cond do
          # 数字が出てきたら -> 数が増えるだけ
          Regex.match?(~r/^\d$/, first_char) ->
            # ２つ目の数字は一の位なので、以前の数は十の位なので、10倍する
            number = 10 * number + String.to_integer(first_char)
            # IO.puts("parse_piece_type_on_hands number:#{number}")

            {rest, number, hand_num_map}

          true ->
            # ピース（Piece；先後付きの駒種類）
            piece = KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(first_char)

            # 枚数指定がないなら 1
            number =
              if number == 0 do
                1
              else
                number
              end

            # IO.puts("parse_piece_type_on_hands number:#{number} piece:#{piece}")

            # 持ち駒データ追加
            hand_num_map = Map.merge(hand_num_map, %{piece => number})
            # IO.inspect(hand_num_map, label: "parse_piece_type_on_hands hand_num_map:")

            # 数をリセット
            number = 0

            {rest, number, hand_num_map}
        end

      # Recursive
      # =========

      rest = tuple |> elem(0)
      number = tuple |> elem(1)
      hand_num_map = tuple |> elem(2)

      tuple = rest |> parse_piece_type_on_hands(number, hand_num_map)
      # 結果を上に投げ上げるだけ
      rest = tuple |> elem(0)
      hand_num_map = tuple |> elem(1)
      {rest, hand_num_map}
    end
  end

  # 指し手の解析
  defp parse_moves_string_to_move_list(rest, result) do
    move = KifuwarabeWcsc33.CLI.Models.Move.new()
    # １文字目は、「大文字英字」か、「筋の数字」

    # 先頭の１文字切り出し
    first_char = rest |> String.at(0)
    IO.puts("parse_moves_string_to_move_list first_char:[#{first_char}]")
    rest = rest |> String.slice(1..-1)

    cond do
      # 数字が出てきたら -> 「筋の数字」
      Regex.match?(~r/^\d$/, first_char) ->
        nil

      # それ以外は「打つ駒」
      true ->
        # 1文字目が駒だったら打。2文字目は必ず「*」なはずなので読み飛ばす。
        case first_char do
          "R" ->
            move = %{move | piece_type: :r}
            IO.inspect(move, label: "parse(12) The move is")
        end

        nil
    end

    {rest, result}
  end
end
