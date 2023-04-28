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

    {rest, pos} =
      cond do
        # 平手初期局面をセット（初期値のまま）
        line |> String.starts_with?("position startpos") ->
          # `position startpos` を除去 |> あれば、続くスペースを削除
          rest_line =
            line |> String.slice(String.length("position startpos")..-1) |> String.trim_leading()

          #
          # 文字列型は elixir では使いづらいんで、マルチバイト・キャラクター・リスト（Multi-byte Character List；マルチバイト文字列型のリスト）に変換する
          #
          # こうではない:
          #   ['p', `o`, `s`, `i`, ...]
          #
          # こうだ:
          #   ["p", "o", "s", "i", ...]
          #
          # `trim: true` を付ける。付けないと、余計な空文字列が含まれている
          rest = rest_line |> String.split("", trim: true)
          {rest, pos}

        # 途中局面をセット
        line |> String.starts_with?("position sfen") ->
          # `position startpos` を除去 |> あれば、続くスペースを削除
          rest_line =
            line |> String.slice(String.length("position sfen")..-1) |> String.trim_leading()

          #
          # 文字列型は elixir では使いづらいんで、マルチバイト・キャラクター・リスト（Multi-byte Character List；マルチバイト文字列型のリスト）に変換する
          #
          # こうではない:
          #   ['p', `o`, `s`, `i`, ...]
          #
          # こうだ:
          #   ["p", "o", "s", "i", ...]
          #
          # `trim: true` を付ける。付けないと、余計な空文字列が含まれている
          rest = rest_line |> String.split("", trim: true)
          # IO.inspect(rest, label: "[PositionParser parse] rest mchar_list")

          # 将棋盤の初期化
          pos = %{
            pos
            | location_of_kings: %{
                # 玉は盤上に無いかもしれないので
                :k1 => nil,
                :k2 => nil
              }
          }

          # 盤面部分を解析。「９一」番地からスタート
          {rest, _sq, board} = rest |> map_string_to_board(91, %{})

          if map_size(board) != 81 do
            raise "unexpected board cell count:#{length(board)}"
          end

          # 手番の解析
          {rest, turn} = rest |> parse_turn()

          # 駒台の解析
          {rest, hand_pieces} =
            rest |> parse_hands(KifuwarabeWcsc33.CLI.Models.Position.new_hand_pieces())

          # IO.inspect(hand_pieces, label: "parse(7) The Hand pieces is")

          #
          # 次の手は何手目か、を表す数字だが、「将棋所」は「この数字は必ず１にしています」という仕様なので
          # 「将棋所」しか使わないのなら、「1」しかこない、というプログラムにしてしまうのも手だ
          #
          mchar = hd(rest)
          rest = tl(rest)

          # 複数桁の数字列に対応する書き方分かんないんで、エラーにする
          if mchar != "1" do
            raise "unexpected mst_char:#{mchar}"
          end

          moves_num = String.to_integer(mchar)

          # 将棋盤の更新
          pos = %{
            pos
            | moves_num: moves_num,
              turn: turn,
              opponent_turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(turn),
              board: board,
              hand_pieces: hand_pieces
          }

          # あれば、続くスペースを削除
          # rest = rest |> String.trim_leading()
          rest =
            if 0 < length(rest) and hd(rest) == " " do
              tl(rest)
            else
              rest
            end

          {rest, pos}

        true ->
          raise "unexpected position command line:#{line}"
      end

    #
    # "moves" が続くか、ここで終わりのはず
    #
    {_rest, pos} =
      if 5 <= length(rest) do
        # 先頭の５文字取る
        # first_5chars = rest |> String.slice(0..4)
        # rest = rest |> String.slice(5..-1)
        rest = tl(rest)
        rest = tl(rest)
        rest = tl(rest)
        rest = tl(rest)
        rest = tl(rest)

        # 多分 "moves" だろう

        # 空白が続くか？
        if 1 <= length(rest) do
          # １文字取る
          # rest = rest |> String.trim_leading()
          # space = hd(rest)
          rest = tl(rest)

          # 指し手読取と、局面更新
          {rest, pos} = rest |> parse_moves_string_and_update_position(pos)

          # IO.inspect(pos.moves, label: "parse(12) The Moves is")
          # IO.inspect(pos.captured_piece_types, label: "parse(12) The Captured pieces is")

          # IO.puts("parse(13) rest:#{rest}")

          pos = %{
            pos
            | # 玉の場所は覚えておきたい
              location_of_kings: %{
                pos.location_of_kings
                | :k1 => KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, :sente),
                  :k2 => KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, :gote)
              },
              # （手番から見た）駒得評価値を算出
              materials_value: KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.count(pos)
          }

          {rest, pos}
        else
          {rest, pos}
        end
      else
        {rest, pos}
      end

    pos
  end

  #
  # パターンマッチ
  #
  defp map_string_to_board(rest, sq, board)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  defp map_string_to_board([], sq, board) do
    # 何の成果も増えません。計算終了
    {"", sq, board}
  end

  # 盤面文字列を解析して、駒のリストを返す
  #
  # ## Parameters
  #
  #   * `[mchar1 | rest]` - mchar1 は先頭の１文字、rest は残りの文字列
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
  defp map_string_to_board([mchar1 | rest], sq, board) do
    # 盤の区切り
    if mchar1 == " " do
      # base case

      # 何の成果も増えません。計算終了
      {rest, sq, board}
    else
      {rest, sq, board} =
        cond do
          # 本将棋の盤上の１行では、連続するスペースの数は最大で１桁に収まる
          Regex.match?(~r/^\d$/, mchar1) ->
            # 空きマスが何個連続するかの数
            space_num = String.to_integer(mchar1)
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
          mchar1 == "+" ->
            mchar2 = hd(rest)
            rest = tl(rest)

            promoted_piece = KifuwarabeWcsc33.CLI.Views.Piece.from_code(mchar1 <> mchar2)

            board = Map.merge(board, %{sq => promoted_piece})
            # 右列へ１つ移動（-10）
            sq = sq - 10

            {rest, sq, board}

          # 段の区切り
          mchar1 == "/" ->
            # 次の段へ

            # 左端列に戻って（+90）
            # 一段下がる（+1）
            sq = sq + 91
            {rest, sq, board}

          # それ以外
          true ->
            piece = KifuwarabeWcsc33.CLI.Views.Piece.from_code(mchar1)
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

  # 指定局面の手番の解析
  #
  # b （Blackの頭文字）なら、▲せんて（Sente；先手）
  # w （Whiteの頭文字）なら、▽ごて（Gote；後手）
  #
  # ## Parameters
  #
  #   * `[mchar, rest]` - mchar は先頭要素（文字列型）、rest は残りの文字列
  #
  defp parse_turn([mchar | rest]) do
    turn =
      case mchar do
        "b" -> :sente
        "w" -> :gote
        _ -> raise "unexpected mchar:#{mchar}"
      end

    # 次の１文字は空白 " " なので読み飛ばす
    # space = hd(rest)
    rest = tl(rest)

    {rest, turn}
  end

  # 駒台（持ち駒の数）の解析
  #
  # ## Parameters
  #
  #   * `[mchar, rest]` - mchar は先頭要素（文字列型）、rest は残りの文字列
  #   * `hand_pieces` - ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  # ## Returns
  #
  #   0. レスト（Rest；残りの文字列）
  #   1. ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  defp parse_hands([mchar | rest], hand_pieces) do
    # 先頭の１文字
    if mchar == "-" do
      # 持ち駒１つもなし

      # 次の１文字は空白 " " なので読み飛ばす
      # space = hd(rest)
      rest = tl(rest)

      {rest, hand_pieces}
    else
      # 持ち駒あり

      # 頭と尾をつなげて、元のリストに戻す
      mchar_list = [mchar] ++ rest
      # IO.inspect(mchar_list, label: "[parse_piece_type_on_hands] mchar_list")
      mchar_list |> parse_piece_type_on_hands(0, hand_pieces)
    end
  end

  #
  # パターンマッチ
  #
  defp parse_piece_type_on_hands(mchar_list, number, hand_pieces)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  defp parse_piece_type_on_hands([], _number, hand_pieces) do
    # IO.puts("[parse_piece_type_on_hands] Terminate")
    # 何も成果を増やさず終了
    {"", hand_pieces}
  end

  # 持ち駒の種類１つ分の解析
  #
  # 数字が出てきたら、もう１回再帰
  #
  # ## Parameters
  #
  # * `[mchar | rest]` - mchar は先頭の１文字、レスト（Rest；残り）は残りの文字列
  # * `number` - ナンバー（Number；前回の解析から引き継いだ数字）
  # * `hand_pieces` - ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  # ## Returns
  #
  #   0. レスト（Rest；残りの文字列）
  #   1. ハンド・ピースズ（Hand Pieces；持ち駒と枚数のマップ）
  #
  defp parse_piece_type_on_hands([mchar | rest], number, hand_pieces) do
    if mchar == " " do
      # 区切りの空白。再帰を停止
      {rest, hand_pieces}
    else
      {mchar_list, number, hand_pieces} =
        cond do
          # 数字が出てきたら -> 数が増えるだけ
          Regex.match?(~r/^\d$/, mchar) ->
            # ２つ目の数字は一の位なので、以前の数は十の位なので、10倍する
            number = 10 * number + String.to_integer(mchar)
            # IO.puts("[parse_piece_type_on_hands] number:#{number}")

            {rest, number, hand_pieces}

          true ->
            # ピース（Piece；先後付きの駒種類）
            piece = KifuwarabeWcsc33.CLI.Views.Piece.from_code(mchar)

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
      {mchar_list, hand_pieces} = mchar_list |> parse_piece_type_on_hands(number, hand_pieces)

      # 再帰からの帰り道にも成果を返す
      {mchar_list, hand_pieces}
    end
  end

  #
  # パターンマッチ
  #
  defp parse_moves_string_and_update_position(mchar_list, pos)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  defp parse_moves_string_and_update_position([], pos) do
    {"", pos}
  end

  # 指し手の解析と、局面更新
  #
  # - 手番の更新
  # - 駒の位置の更新
  #
  # ## Parameters
  #
  #   * `mchar_list` - マルチバイト・キャラクター・リスト（Multi-byte Character List；マルチバイト文字列のリスト）
  #   * `pos` - ポジション（Position；局面）
  #
  defp parse_moves_string_and_update_position(mchar_list, pos) do
    # IO.inspect(mchar_list, label: "[parse_moves_string_and_update_position] mchar_list")

    # コードを、指し手へ変換
    {rest, move} = KifuwarabeWcsc33.CLI.Mappings.ToMove.from_code_line(mchar_list)
    # IO.inspect(move, label: "[parse_moves_string_and_update_position] parse move")

    # 局面更新（実際、指してみる）
    pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.DoMove.do_it(move)

    # IO.puts("[parse_moves_string_and_update_position] length(rest):#{length(rest)}")

    {rest, pos} =
      if 1 <= length(rest) do
        # IO.inspect(rest, label: "[parse_moves_string_and_update_position] rest1")

        # 区切り
        # ======
        #
        # * （あれば）続くスペースを除去
        #
        # rest = rest |> String.trim_leading()
        rest =
          if hd(rest) == " " do
            # space = hd(rest)
            tl(rest)
          else
            rest
          end

        # IO.inspect(rest, label: "[parse_moves_string_and_update_position] rest2")

        # Recursive
        # =========
        {rest, pos} = rest |> parse_moves_string_and_update_position(pos)
        {rest, pos}
      else
        {rest, pos}
      end

    # 再帰の帰り道でも、値を返します
    {rest, pos}
  end
end
