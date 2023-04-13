defmodule KifuwarabeWcsc33.CLI.Views.Position do
  @doc """
    盤表示
  
  ## 引数
  
    * `pos` - ポジション（Position；局面）
  
  """
  def print(pos) do
    print_header(pos)
    print_hand2(pos)
    print_body(pos)
    print_hand1(pos)
    print_moves(pos)
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
  defp print_header(pos) do
    # ムーブズ・ナンバー（moves-number；何手目か）、Half-ply
    m = "#{pos.moves_num}"
    # ターン（turn；手番）
    t = print_turn(pos.turn)
    # フォーフォルド・レピティション（Fourfold repetition；千日手）
    r = "#{pos.fourfold_repetition}"

    IO.puts("""
    [#{m} moves / #{t} / #{r} repeat(s)]
    """)
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
  #  | 0| 0| 0| 0| 0| 0| 0| 0|
  #  +--+--+--+--+--+--+--+--+
  #
  defp print_hand2(pos) do
    # キング（King；玉）
    k = String.pad_leading("#{pos.hand_pieces[:k2]}", 2, " ")
    # ルック（Rook；飛車）
    r = String.pad_leading("#{pos.hand_pieces[:r2]}", 2, " ")
    # ビショップ（Bishop；角）
    b = String.pad_leading("#{pos.hand_pieces[:b2]}", 2, " ")
    # ゴールド（Gold；金）
    g = String.pad_leading("#{pos.hand_pieces[:g2]}", 2, " ")
    # シルバー（Silver；銀）
    s = String.pad_leading("#{pos.hand_pieces[:s2]}", 2, " ")
    # ナイト（kNight；桂）
    n = String.pad_leading("#{pos.hand_pieces[:n2]}", 2, " ")
    # ランス（Lance；香）
    l = String.pad_leading("#{pos.hand_pieces[:l2]}", 2, " ")
    # ポーン（Pawn；歩）
    p = String.pad_leading("#{pos.hand_pieces[:p2]}", 2, " ")

    IO.puts("""
      k  r  b  g  s  n  l  p
    +--+--+--+--+--+--+--+--+
    |#{k}|#{r}|#{b}|#{g}|#{s}|#{n}|#{l}|#{p}|
    +--+--+--+--+--+--+--+--+
    """)
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
  #       | 0| 0| 0| 0| 0| 0| 0| 0|
  #       +--+--+--+--+--+--+--+--+
  #
  defp print_hand1(pos) do
    # キング（King；玉）
    k = String.pad_leading("#{pos.hand_pieces[:k1]}", 2, " ")
    # ルック（Rook；飛車）
    r = String.pad_leading("#{pos.hand_pieces[:r1]}", 2, " ")
    # ビショップ（Bishop；角）
    b = String.pad_leading("#{pos.hand_pieces[:b1]}", 2, " ")
    # ゴールド（Gold；金）
    g = String.pad_leading("#{pos.hand_pieces[:g1]}", 2, " ")
    # シルバー（Silver；銀）
    s = String.pad_leading("#{pos.hand_pieces[:s1]}", 2, " ")
    # ナイト（kNight；桂）
    n = String.pad_leading("#{pos.hand_pieces[:n1]}", 2, " ")
    # ランス（Lance；香）
    l = String.pad_leading("#{pos.hand_pieces[:l1]}", 2, " ")
    # ポーン（Pawn；歩）
    p = String.pad_leading("#{pos.hand_pieces[:p1]}", 2, " ")

    IO.puts("""
         K  R  B  G  S  N  L  P
       +--+--+--+--+--+--+--+--+
       |#{k}|#{r}|#{b}|#{g}|#{s}|#{n}|#{l}|#{p}|
       +--+--+--+--+--+--+--+--+
    """)
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
  defp print_body(pos) do
    #
    # 将棋盤を反時計回りに９０°回すと、座標は 11,12,13 ... のように合理的になるが
    # 本エンジンでは素直に（将棋盤を回さず）、コーディングする
    #
    # うわっ、めんどくさ！
    # １段目
    a9 = print_piece(pos.board[91])
    a8 = print_piece(pos.board[81])
    a7 = print_piece(pos.board[71])
    a6 = print_piece(pos.board[61])
    a5 = print_piece(pos.board[51])
    a4 = print_piece(pos.board[41])
    a3 = print_piece(pos.board[31])
    a2 = print_piece(pos.board[21])
    a1 = print_piece(pos.board[11])
    # ２段目
    b9 = print_piece(pos.board[92])
    b8 = print_piece(pos.board[82])
    b7 = print_piece(pos.board[72])
    b6 = print_piece(pos.board[62])
    b5 = print_piece(pos.board[52])
    b4 = print_piece(pos.board[42])
    b3 = print_piece(pos.board[32])
    b2 = print_piece(pos.board[22])
    b1 = print_piece(pos.board[12])
    # ３段目
    c9 = print_piece(pos.board[93])
    c8 = print_piece(pos.board[83])
    c7 = print_piece(pos.board[73])
    c6 = print_piece(pos.board[63])
    c5 = print_piece(pos.board[53])
    c4 = print_piece(pos.board[43])
    c3 = print_piece(pos.board[33])
    c2 = print_piece(pos.board[23])
    c1 = print_piece(pos.board[13])
    # ４段目
    d9 = print_piece(pos.board[94])
    d8 = print_piece(pos.board[84])
    d7 = print_piece(pos.board[74])
    d6 = print_piece(pos.board[64])
    d5 = print_piece(pos.board[54])
    d4 = print_piece(pos.board[44])
    d3 = print_piece(pos.board[34])
    d2 = print_piece(pos.board[24])
    d1 = print_piece(pos.board[14])
    # ５段目
    e9 = print_piece(pos.board[95])
    e8 = print_piece(pos.board[85])
    e7 = print_piece(pos.board[75])
    e6 = print_piece(pos.board[65])
    e5 = print_piece(pos.board[55])
    e4 = print_piece(pos.board[45])
    e3 = print_piece(pos.board[35])
    e2 = print_piece(pos.board[25])
    e1 = print_piece(pos.board[15])
    # ６段目
    f9 = print_piece(pos.board[96])
    f8 = print_piece(pos.board[86])
    f7 = print_piece(pos.board[76])
    f6 = print_piece(pos.board[66])
    f5 = print_piece(pos.board[56])
    f4 = print_piece(pos.board[46])
    f3 = print_piece(pos.board[36])
    f2 = print_piece(pos.board[26])
    f1 = print_piece(pos.board[16])
    # ７段目
    g9 = print_piece(pos.board[97])
    g8 = print_piece(pos.board[87])
    g7 = print_piece(pos.board[77])
    g6 = print_piece(pos.board[67])
    g5 = print_piece(pos.board[57])
    g4 = print_piece(pos.board[47])
    g3 = print_piece(pos.board[37])
    g2 = print_piece(pos.board[27])
    g1 = print_piece(pos.board[17])
    # ８段目
    h9 = print_piece(pos.board[98])
    h8 = print_piece(pos.board[88])
    h7 = print_piece(pos.board[78])
    h6 = print_piece(pos.board[68])
    h5 = print_piece(pos.board[58])
    h4 = print_piece(pos.board[48])
    h3 = print_piece(pos.board[38])
    h2 = print_piece(pos.board[28])
    h1 = print_piece(pos.board[18])
    # ９段目
    i9 = print_piece(pos.board[99])
    i8 = print_piece(pos.board[89])
    i7 = print_piece(pos.board[79])
    i6 = print_piece(pos.board[69])
    i5 = print_piece(pos.board[59])
    i4 = print_piece(pos.board[49])
    i3 = print_piece(pos.board[39])
    i2 = print_piece(pos.board[29])
    i1 = print_piece(pos.board[19])

    IO.puts("""
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
    """)
  end

  # 手番の表示
  defp print_turn(turn) do
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
  defp print_piece(pc) do
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
    end
  end

  # 棋譜の表示
  defp print_moves(pos) do
    IO.write("moves ")
    IO.inspect(pos.moves)
  end
end
