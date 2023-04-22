defmodule KifuwarabeWcsc33.CLI.Helpers.PositionParser do
  @doc """

    解析

  ## Parameters

    * `line` - 一行の文字列。例参考

  ## Returns

    0. ポジション（Position；局面）

  ## Examples

    position startpos moves 7g7f 3c3d 2g2f
    position sfen lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL w - 1 moves 5a6b 7g7f 3a3b

    // 📖 [USIプロトコル表記: 最多合法手５９３手の局面](https://ameblo.jp/professionalhearts/entry-10001031814.html)
    position sfen R8/2K1S1SSk/4B4/9/9/9/9/9/1L1L1L3 w RBGSNLP3g3n17p 1

    // 📖 [USIプロトコル表記: 飛角落ち初期局面](http://www.geocities.jp/shogidokoro/usi.html)
    position sfen lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL w - 1 moves 5a6b 7g7f 3a3b

  """
  def parse(line) do
    # IO.puts("parse(1) line:#{line}")

    # 局面データ（初期値は平手初期局面）
    pos = KifuwarabeWcsc33.CLI.Models.Position.new()

    rest =
      if line |> String.starts_with?("position startpos") do
        # 平手初期局面をセット（初期値のまま）

        # `position startpos` を除去 |> あれば、続くスペースを削除
        line |> String.slice(String.length("position startpos")..-1) |> String.trim_leading()
      else
        # pass
        line
      end

    # IO.puts("parse(2) rest:#{rest}")

    {rest, pos} =
      if rest |> String.starts_with?("position sfen") do
        # 途中局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        rest = line |> String.slice(String.length("position sfen")..-1) |> String.trim_leading()

        # IO.puts("parse(3) rest:#{rest}")

        # 盤面部分を解析。「９一」番地からスタート
        {rest, _sq, board} = rest |> map_string_to_board(91, %{})
        # rest = tuple |> elem(0)
        # sq = tuple |> elem(1)
        # board = tuple |> elem(2)
        # IO.inspect(board, label: "parse(4) The board is")
        # IO.puts("parse(5) rest:#{rest}")

        if map_size(board) != 81 do
          raise "unexpected board cell count:#{length(board)}"
        end

        # 手番の解析
        {rest, turn} = rest |> parse_turn()
        # IO.puts("parse(6) turn:#{turn} rest:#{rest}")

        # 駒台の解析
        {rest, hand_pieces} = rest |> parse_hands(%{})
        IO.inspect(hand_pieces, label: "parse(7) The Hand pieces is")
        # IO.puts("parse(8) rest:#{rest}")

        # 次の手は何手目か、を表す数字だが、「将棋所」は「この数字は必ず１にしています」という仕様なので
        # 「将棋所」しか使わないのなら、「1」しかこない、というプログラムにしてしまうのも手だ
        first_char = rest |> String.at(0)
        rest = rest |> String.slice(1..-1)

        if first_char != "1" do
          raise "unexpected first_char:#{first_char}"
        end

        # IO.puts("parse first_char:[#{first_char}]")
        moves_num = String.to_integer(first_char)
        # IO.puts("parse(9) moves_num:[#{moves_num}]")

        # 将棋盤の更新
        pos = %{pos |
          moves_num: moves_num,
          turn: turn,
          opponent_turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(turn),
          board: board,
          hand_pieces: hand_pieces
        }

        # 残りの文字列 |> あれば、続くスペースを削除
        rest = rest |> String.trim_leading()

        {rest, pos}
      else
        # pass
        {rest, pos}
      end

    # ５文字取る
    first_5chars = rest |> String.slice(0..4)
    rest = rest |> String.slice(5..-1)

    {_rest, pos} =
      if first_5chars == "moves" do
        # 指し手が付いている場合
        # IO.puts("parse(10) first_5chars:[#{first_5chars}]")
        # IO.puts("parse(11) rest:#{rest}")

        # 残りの文字列 |> あれば、続くスペースを削除
        rest = rest |> String.trim_leading()

        # 指し手読取と、局面更新
        {rest, pos} = rest |> parse_moves_string_and_update_position(pos)

        # IO.inspect(moves, label: "parse(12) The move_list is")

        {rest, pos}
      else
        # 指し手が付いていない場合
        # 完了
        {rest, pos}
      end

    # IO.puts("parse(13) rest:#{rest}")

    pos
  end

  # 盤面文字列を解析して、駒のリストを返す
  #
  # ## Parameters
  #
  #   * `rest` - 残りの文字列
  #   * `sq` - スクウェア（Square；マス番地）
  #   * `board` - （成果物）ボード（Board；将棋盤）
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
  defp map_string_to_board(rest, sq, board) do
    if rest |> String.length() < 1 do
      # base case

      # 何の成果も増えません。計算終了
      {rest, sq, board}
    else
      # recursive

      # こうやって、１文字ずつ取りだして、減らしていけるけど……
      first_char = rest |> String.at(0)
      # IO.puts("map_string_to_board char:[#{first_char}]")
      rest = rest |> String.slice(1..-1)

      # 盤の区切り
      if first_char == " " do
        # base case

        # 何の成果も増えません。計算終了
        {rest, sq, board}
      else
        {rest, sq, board} =
          cond do
            # 本将棋の盤上の１行では、連続するスペースの数は最大で１桁に収まる
            Regex.match?(~r/^\d$/, first_char) ->
              # 空きマスが何個連続するかの数
              space_num = String.to_integer(first_char)
              # 愚直な方法
              {sq, board} =
                case space_num do
                  1 ->
                    {sq - 10, Map.merge(board, %{sq => :sp})}

                  2 ->
                    {sq - 20, Map.merge(board, %{sq => :sp, (sq - 10) => :sp})}

                  3 ->
                    {sq - 30, Map.merge(board, %{sq => :sp, (sq - 10) => :sp, (sq - 20) => :sp})}

                  4 ->
                    {sq - 40,
                     Map.merge(board, %{
                       sq => :sp,
                       (sq - 10) => :sp,
                       (sq - 20) => :sp,
                       (sq - 30) => :sp
                     })}

                  5 ->
                    {sq - 50,
                     Map.merge(board, %{
                       sq => :sp,
                       (sq - 10) => :sp,
                       (sq - 20) => :sp,
                       (sq - 30) => :sp,
                       (sq - 40) => :sp
                     })}

                  6 ->
                    {sq - 60,
                     Map.merge(board, %{
                       sq => :sp,
                       (sq - 10) => :sp,
                       (sq - 20) => :sp,
                       (sq - 30) => :sp,
                       (sq - 40) => :sp,
                       (sq - 50) => :sp
                     })}

                  7 ->
                    {sq - 70,
                     Map.merge(board, %{
                       sq => :sp,
                       (sq - 10) => :sp,
                       (sq - 20) => :sp,
                       (sq - 30) => :sp,
                       (sq - 40) => :sp,
                       (sq - 50) => :sp,
                       (sq - 60) => :sp
                     })}

                  8 ->
                    {sq - 80,
                     Map.merge(board, %{
                       sq => :sp,
                       (sq - 10) => :sp,
                       (sq - 20) => :sp,
                       (sq - 30) => :sp,
                       (sq - 40) => :sp,
                       (sq - 50) => :sp,
                       (sq - 60) => :sp,
                       (sq - 70) => :sp
                     })}

                  9 ->
                    {sq - 90,
                     Map.merge(board, %{
                       sq => :sp,
                       (sq - 10) => :sp,
                       (sq - 20) => :sp,
                       (sq - 30) => :sp,
                       (sq - 40) => :sp,
                       (sq - 50) => :sp,
                       (sq - 60) => :sp,
                       (sq - 70) => :sp,
                       (sq - 80) => :sp
                     })}

                  _ ->
                    raise "unexpected space_num:#{space_num}"
                end

              {rest, sq, board}

            # 成り駒
            first_char == "+" ->
              second_char = rest |> String.at(0)

              promoted_piece =
                KifuwarabeWcsc33.CLI.Views.Piece.as_code(first_char <> second_char)

              board = Map.merge(board, %{sq => promoted_piece})
              # 右列へ１つ移動（-10）
              sq = sq - 10

              rest = rest |> String.slice(1..-1)
              {rest, sq, board}

            # 段の区切り
            first_char == "/" ->
              # 次の段へ

              # 左端列に戻って（+90）
              # 一段下がる（+1）
              sq = sq + 91
              {rest, sq, board}

            # それ以外
            true ->
              piece = KifuwarabeWcsc33.CLI.Views.Piece.as_code(first_char)

              board = Map.merge(board, %{sq => piece})
              # 右列へ１つ移動（-10）
              sq = sq - 10

              {rest, sq, board}
          end

        # Recursive
        # =========

        {rest, sq, board} = rest |> map_string_to_board(sq, board)

        # 結果を上に投げ上げるだけ
        {rest, sq, board}
      end
    end
  end

  # 指定局面の手番の解析
  #
  # b （Blackの頭文字）なら、▲せんて（Sente；先手）
  # w （Whiteの頭文字）なら、▽ごて（Gote；後手）
  defp parse_turn(rest) do
    # ２文字取る
    first_chars = rest |> String.slice(0..1)
    # IO.puts("parse_turn chars:[#{first_chars}]")
    rest = rest |> String.slice(2..-1)

    turn =
      case first_chars do
        "b " -> :sente
        "w " -> :gote
        _ -> raise "unexpected first_chars:#{first_chars}"
      end

    {rest, turn}
  end

  # 駒台（持ち駒の数）の解析
  #
  # ## Parameters
  #
  # * `rest` - レスト（Rest；残りの文字列）
  # * `hand_pieces` - ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  # ## Returns
  #
  #   0. レスト（Rest；残りの文字列）
  #   1. ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  defp parse_hands(rest, hand_pieces) do
    # 先頭の１文字（取りださない）
    first_char = rest |> String.at(0)
    # IO.puts("[parse_hands] first_char:[#{first_char}]")

    if first_char == "-" do
      # 持ち駒１つもなし

      # 先頭の２文字 "- " を切り捨て
      rest = rest |> String.slice(2..-1)

      {rest, hand_pieces}
    else
      # 持ち駒あり
      rest |> parse_piece_type_on_hands(0, hand_pieces)
    end
  end

  # 持ち駒の種類１つ分の解析
  #
  # 数字が出てきたら、もう１回再帰
  #
  # ## Parameters
  #
  # * `rest` - レスト（Rest；残りの文字列）
  # * `number` - ナンバー（Number；前回の解析から引き継いだ数字）
  # * `hand_pieces` - ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  # ## Returns
  #
  #   0. レスト（Rest；残りの文字列）
  #   1. ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  defp parse_piece_type_on_hands(rest, number, hand_pieces) do
    # 先頭の１文字切り出し
    first_char = rest |> String.at(0)
    # IO.puts("[parse_piece_type_on_hands] first_char:[#{first_char}]")
    rest = rest |> String.slice(1..-1)

    if first_char == " " do
      # Base case
      # IO.puts("[parse_piece_type_on_hands] Terminate")
      # 何も成果を増やさず終了
      {rest, hand_pieces}
    else
      {rest, number, hand_pieces} =
        cond do
          # 数字が出てきたら -> 数が増えるだけ
          Regex.match?(~r/^\d$/, first_char) ->
            # ２つ目の数字は一の位なので、以前の数は十の位なので、10倍する
            number = 10 * number + String.to_integer(first_char)
            # IO.puts("[parse_piece_type_on_hands] number:#{number}")

            {rest, number, hand_pieces}

          true ->
            # ピース（Piece；先後付きの駒種類）
            piece = KifuwarabeWcsc33.CLI.Views.Piece.as_code(first_char)

            # 枚数指定がないなら 1
            number =
              if number == 0 do
                1
              else
                number
              end

            # IO.puts("[parse_piece_type_on_hands] number:#{number} piece:#{piece}")

            # 持ち駒データ追加
            hand_pieces = Map.merge(hand_pieces, %{piece => number})
            # IO.inspect(hand_pieces, label: "[parse_piece_type_on_hands] hand_pieces:")

            # 数をリセット
            number = 0

            {rest, number, hand_pieces}
        end

      # Recursive
      # =========
      {rest, hand_pieces} = rest |> parse_piece_type_on_hands(number, hand_pieces)

      # 再帰からの帰り道にも成果を返す
      {rest, hand_pieces}
    end
  end

  # 指し手の解析と、局面更新
  #
  # - 手番の更新
  # - 駒の位置の更新
  #
  # ## Parameters
  #
  #   * `rest` - レスト（Rest；残りの文字列）
  #   * `pos` - ポジション（Position；局面）
  #
  defp parse_moves_string_and_update_position(rest, pos) do

    # コードを、指し手へ変換
    {rest, move} = KifuwarabeWcsc33.CLI.Mappings.ToMove.from_code_line(rest)

    # IO.inspect(move, label: "parse move")

    # 局面更新（実際、指してみる）
    pos = pos |> KifuwarabeWcsc33.CLI.Routes.DoMove.do_it(move)

    # 区切り
    # ======
    #
    # * （あれば）続くスペースを除去
    #
    rest = rest |> String.trim_leading()

    {rest, pos} =
      if rest |> String.length() < 1 do
        # Base case
        {rest, pos}
      else
        # Recursive
        rest |> parse_moves_string_and_update_position(pos)
      end

    {rest, pos}
  end
end
