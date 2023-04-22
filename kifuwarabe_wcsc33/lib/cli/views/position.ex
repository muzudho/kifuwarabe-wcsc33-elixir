defmodule KifuwarabeWcsc33.CLI.Views.Position do
  @doc """
    盤表示

  ## 引数

    * `pos` - ポジション（Position；局面）

  """
  def stringify(pos) do
    header = pos |> stringify_header()
    hand2 = pos |> stringify_hand2()
    body = pos |> stringify_body()
    hand1 = pos |> stringify_hand1()
    record = pos |> stringify_record()
    location_of_kings = pos |> stringify_location_of_kings()

    """

    """ <> header <> hand2 <> body <> hand1 <> location_of_kings <> record
  end

  # 盤表示のヘッダー
  #
  # ## 引数
  #
  #   * `pos` - ポジション（Position；局面）
  #
  # ## 例
  #
  #   [1 moves / First / 0 repeat(s)]
  #
  defp stringify_header(pos) do
    # ムーブズ・ナンバー（moves-number；何手目か）、Half-ply
    m = "#{pos.moves_num}"
    # ターン（turn；手番）
    t = stringify_turn(pos.turn)
    # フォーフォルド・レピティション（Fourfold repetition；千日手）
    r = "#{pos.fourfold_repetition}"

    """
    [#{m} moves / #{t} / #{r} repeat(s)]

    """
  end

  # ▽ごて（Gote；後手） or うわて（Uwate；上手）の、駒台（持ち駒の数）表示
  #
  # ## 引数
  #
  #   * `pos` - ポジション（Position；局面）
  #
  # ## 例
  #
  #    k  r  b  g  s  n  l  p
  #  +--+--+--+--+--+--+--+--+
  #  | 1| 1| 1| 1| 1| 1| 1| 1|
  #  +--+--+--+--+--+--+--+--+
  #
  #   * 0 は空欄になる
  #
  defp stringify_hand2(pos) do
    # キング（King；玉）
    k = :k2 |> stringify_cell(pos)
    # ルック（Rook；飛車）
    r = :r2 |> stringify_cell(pos)
    # ビショップ（Bishop；角）
    b = :b2 |> stringify_cell(pos)
    # ゴールド（Gold；金）
    g = :g2 |> stringify_cell(pos)
    # シルバー（Silver；銀）
    s = :s2 |> stringify_cell(pos)
    # ナイト（kNight；桂）
    n = :n2 |> stringify_cell(pos)
    # ランス（Lance；香）
    l = :l2 |> stringify_cell(pos)
    # ポーン（Pawn；歩）
    p = :p2 |> stringify_cell(pos)

    """
      k  r  b  g  s  n  l  p
    +--+--+--+--+--+--+--+--+
    |#{k}|#{r}|#{b}|#{g}|#{s}|#{n}|#{l}|#{p}|
    +--+--+--+--+--+--+--+--+

    """
  end

  # ▲せんて（Sente；先手） or したて（Shitate；下手）の、駒台（持ち駒の数）表示
  #
  # ## 引数
  #
  #   * `pos` - ポジション（Position；局面）
  #
  # ## 例
  #
  #         K  R  B  G  S  N  L  P
  #       +--+--+--+--+--+--+--+--+
  #       | 1| 1| 1| 1| 1| 1| 1| 1|
  #       +--+--+--+--+--+--+--+--+
  #
  #   * 0 は空欄になる
  #
  defp stringify_hand1(pos) do
    # キング（King；玉）
    k = :k1 |> stringify_cell(pos)
    # ルック（Rook；飛車）
    r = :r1 |> stringify_cell(pos)
    # ビショップ（Bishop；角）
    b = :b1 |> stringify_cell(pos)
    # ゴールド（Gold；金）
    g = :g1 |> stringify_cell(pos)
    # シルバー（Silver；銀）
    s = :s1 |> stringify_cell(pos)
    # ナイト（kNight；桂）
    n = :n1 |> stringify_cell(pos)
    # ランス（Lance；香）
    l = :l1 |> stringify_cell(pos)
    # ポーン（Pawn；歩）
    p = :p1 |> stringify_cell(pos)
    """
         K  R  B  G  S  N  L  P
       +--+--+--+--+--+--+--+--+
       |#{k}|#{r}|#{b}|#{g}|#{s}|#{n}|#{l}|#{p}|
       +--+--+--+--+--+--+--+--+

    """
  end

  #
  # 持ち駒の数のセル
  #
  #   * 0 は空欄になる
  #
  defp stringify_cell(piece_type, pos) do
    num = pos.hand_pieces[piece_type]

    if 0 < num do
      String.pad_leading("#{num}", 2, " ")
    else
      "  "
    end
  end

  # 盤表示
  #
  # ## 例
  #
  #      9  8  7  6  5  4  3  2  1
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | a
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | b
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | c
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | d
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | e
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | f
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | g
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | h
  #    +--+--+--+--+--+--+--+--+--+
  #    |  |  |  |  |  |  |  |  |  | i
  #    +--+--+--+--+--+--+--+--+--+
  #
  defp stringify_body(pos) do
    #
    # 将棋盤を反時計回りに９０°回すと、座標は 11,12,13 ... のように合理的になるが
    # 本エンジンでは素直に（将棋盤を回さず）、コーディングする
    #
    # うわっ、めんどくさ！
    # １段目
    a9 = stringify_piece(pos.board[91])
    a8 = stringify_piece(pos.board[81])
    a7 = stringify_piece(pos.board[71])
    a6 = stringify_piece(pos.board[61])
    a5 = stringify_piece(pos.board[51])
    a4 = stringify_piece(pos.board[41])
    a3 = stringify_piece(pos.board[31])
    a2 = stringify_piece(pos.board[21])
    a1 = stringify_piece(pos.board[11])
    # ２段目
    b9 = stringify_piece(pos.board[92])
    b8 = stringify_piece(pos.board[82])
    b7 = stringify_piece(pos.board[72])
    b6 = stringify_piece(pos.board[62])
    b5 = stringify_piece(pos.board[52])
    b4 = stringify_piece(pos.board[42])
    b3 = stringify_piece(pos.board[32])
    b2 = stringify_piece(pos.board[22])
    b1 = stringify_piece(pos.board[12])
    # ３段目
    c9 = stringify_piece(pos.board[93])
    c8 = stringify_piece(pos.board[83])
    c7 = stringify_piece(pos.board[73])
    c6 = stringify_piece(pos.board[63])
    c5 = stringify_piece(pos.board[53])
    c4 = stringify_piece(pos.board[43])
    c3 = stringify_piece(pos.board[33])
    c2 = stringify_piece(pos.board[23])
    c1 = stringify_piece(pos.board[13])
    # ４段目
    d9 = stringify_piece(pos.board[94])
    d8 = stringify_piece(pos.board[84])
    d7 = stringify_piece(pos.board[74])
    d6 = stringify_piece(pos.board[64])
    d5 = stringify_piece(pos.board[54])
    d4 = stringify_piece(pos.board[44])
    d3 = stringify_piece(pos.board[34])
    d2 = stringify_piece(pos.board[24])
    d1 = stringify_piece(pos.board[14])
    # ５段目
    e9 = stringify_piece(pos.board[95])
    e8 = stringify_piece(pos.board[85])
    e7 = stringify_piece(pos.board[75])
    e6 = stringify_piece(pos.board[65])
    e5 = stringify_piece(pos.board[55])
    e4 = stringify_piece(pos.board[45])
    e3 = stringify_piece(pos.board[35])
    e2 = stringify_piece(pos.board[25])
    e1 = stringify_piece(pos.board[15])
    # ６段目
    f9 = stringify_piece(pos.board[96])
    f8 = stringify_piece(pos.board[86])
    f7 = stringify_piece(pos.board[76])
    f6 = stringify_piece(pos.board[66])
    f5 = stringify_piece(pos.board[56])
    f4 = stringify_piece(pos.board[46])
    f3 = stringify_piece(pos.board[36])
    f2 = stringify_piece(pos.board[26])
    f1 = stringify_piece(pos.board[16])
    # ７段目
    g9 = stringify_piece(pos.board[97])
    g8 = stringify_piece(pos.board[87])
    g7 = stringify_piece(pos.board[77])
    g6 = stringify_piece(pos.board[67])
    g5 = stringify_piece(pos.board[57])
    g4 = stringify_piece(pos.board[47])
    g3 = stringify_piece(pos.board[37])
    g2 = stringify_piece(pos.board[27])
    g1 = stringify_piece(pos.board[17])
    # ８段目
    h9 = stringify_piece(pos.board[98])
    h8 = stringify_piece(pos.board[88])
    h7 = stringify_piece(pos.board[78])
    h6 = stringify_piece(pos.board[68])
    h5 = stringify_piece(pos.board[58])
    h4 = stringify_piece(pos.board[48])
    h3 = stringify_piece(pos.board[38])
    h2 = stringify_piece(pos.board[28])
    h1 = stringify_piece(pos.board[18])
    # ９段目
    i9 = stringify_piece(pos.board[99])
    i8 = stringify_piece(pos.board[89])
    i7 = stringify_piece(pos.board[79])
    i6 = stringify_piece(pos.board[69])
    i5 = stringify_piece(pos.board[59])
    i4 = stringify_piece(pos.board[49])
    i3 = stringify_piece(pos.board[39])
    i2 = stringify_piece(pos.board[29])
    i1 = stringify_piece(pos.board[19])

    """
      9  8  7  6  5  4  3  2  1
    +--+--+--+--+--+--+--+--+--+
    |#{a9}|#{a8}|#{a7}|#{a6}|#{a5}|#{a4}|#{a3}|#{a2}|#{a1}| a
    +--+--+--+--+--+--+--+--+--+
    |#{b9}|#{b8}|#{b7}|#{b6}|#{b5}|#{b4}|#{b3}|#{b2}|#{b1}| b
    +--+--+--+--+--+--+--+--+--+
    |#{c9}|#{c8}|#{c7}|#{c6}|#{c5}|#{c4}|#{c3}|#{c2}|#{c1}| c
    +--+--+--+--+--+--+--+--+--+
    |#{d9}|#{d8}|#{d7}|#{d6}|#{d5}|#{d4}|#{d3}|#{d2}|#{d1}| d
    +--+--+--+--+--+--+--+--+--+
    |#{e9}|#{e8}|#{e7}|#{e6}|#{e5}|#{e4}|#{e3}|#{e2}|#{e1}| e
    +--+--+--+--+--+--+--+--+--+
    |#{f9}|#{f8}|#{f7}|#{f6}|#{f5}|#{f4}|#{f3}|#{f2}|#{f1}| f
    +--+--+--+--+--+--+--+--+--+
    |#{g9}|#{g8}|#{g7}|#{g6}|#{g5}|#{g4}|#{g3}|#{g2}|#{g1}| g
    +--+--+--+--+--+--+--+--+--+
    |#{h9}|#{h8}|#{h7}|#{h6}|#{h5}|#{h4}|#{h3}|#{h2}|#{h1}| h
    +--+--+--+--+--+--+--+--+--+
    |#{i9}|#{i8}|#{i7}|#{i6}|#{i5}|#{i4}|#{i3}|#{i2}|#{i1}| i
    +--+--+--+--+--+--+--+--+--+

    """
  end

  # 手番の表示
  defp stringify_turn(turn) do
    case turn do
      :sente -> "Sente"
      :gote -> "Gote"
    end
  end

  # 駒の表示
  #
  # ## 引数
  #
  # pc - ピース（piece；先後付きの駒種類）
  #
  defp stringify_piece(pc) do
    case pc do
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      :k1 -> " K"
      # ルック（Rook；飛車）
      :r1 -> " R"
      # ビショップ（Bishop；角）
      :b1 -> " B"
      # ゴールド（Gold；金）
      :g1 -> " G"
      # シルバー（Silver；銀）
      :s1 -> " S"
      # ナイト（kNight；桂）
      :n1 -> " N"
      # ランス（Lance；香）
      :l1 -> " L"
      # ポーン（Pawn；歩）
      :p1 -> " P"
      # 玉は成れません
      # :pk
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr1 -> "+R"
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb1 -> "+B"
      # 金は成れません
      # :pg
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps1 -> "+S"
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn1 -> "+N"
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl1 -> "+L"
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp1 -> "+P"
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      :k2 -> " k"
      # ルック（Rook；飛車）
      :r2 -> " r"
      # ビショップ（Bishop；角）
      :b2 -> " b"
      # ゴールド（Gold；金）
      :g2 -> " g"
      # シルバー（Silver；銀）
      :s2 -> " s"
      # ナイト（kNight；桂）
      :n2 -> " n"
      # ランス（Lance；香）
      :l2 -> " l"
      # ポーン（Pawn；歩）
      :p2 -> " p"
      # 玉は成れません
      # :pk
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr2 -> "+r"
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb2 -> "+b"
      # 金は成れません
      # :pg
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps2 -> "+s"
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn2 -> "+n"
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl2 -> "+l"
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp2 -> "+p"
      # スペース（Space；空きマス）
      :sp -> "  "
      _ -> raise "unexpected piece:#{pc}"
    end
  end

  # 棋譜の表示
  defp stringify_record(pos) do
    # IO.inspect(pos.moves)

    record = Enum.zip(pos.moves, pos.captured_piece_types)

    record_element_text_list = record |> Enum.map(fn ({move, captured_pt}) ->
        captured_pt_text =
          if captured_pt != nil do
            piece_type_text = KifuwarabeWcsc33.CLI.Views.PieceType.stringify_upper_case(captured_pt)
            # IO.puts("[position stringify_record] piece_type_text:(#{piece_type_text})")
            "<#{piece_type_text}>"
          else
            ""
          end

        " #{KifuwarabeWcsc33.CLI.Views.Move.as_code(move)}#{captured_pt_text}"
      end)
    # IO.inspect(record_element_text_list)

    record_text = record_element_text_list |> Enum.join()

    """
    record #{record_text}

    """
  end

  # 玉のいるマス番地
  defp stringify_location_of_kings(pos) do
    """
    king_sq ^#{pos.location_of_kings[:sente]} v#{pos.location_of_kings[:gote]}

    """
  end
end
