defmodule KifuwarabeWcsc33.CLI.Views.Position do
  @doc """
    盤表示
  """
  def print(pos) do
    print_header()
    print_hand2()
    print_body(pos)
    print_hand1()
  end

  # 盤表示のヘッダー
  #
  # ## 例
  #
  #   [1 moves / First / 0 repeat(s)]
  #
  defp print_header() do
    # ムーブズ・ナンバー（moves-number；何手目か）、Half-ply
    m = "?"
    # ターン（turn；手番）
    t = "First?"
    # フォーフォルド・レピティション（Fourfold repetition；千日手）
    r = "0"

    IO.puts("""
    [#{m} moves / #{t} / #{r} repeat(s)]
    """)
  end

  # ▽後手（上手）の駒台（持ち駒の数）表示
  #
  # ## 例
  #
  #    k  r  b  g  s  n  l  p
  #  +--+--+--+--+--+--+--+--+
  #  | 0| 0| 0| 0| 0| 0| 0| 0|
  #  +--+--+--+--+--+--+--+--+
  #
  defp print_hand2() do
    # キング（King；玉）
    k = " 0"
    # ルック（Rook；飛車）
    r = " 0"
    # ビショップ（Bishop；角）
    b = " 0"
    # ゴールド（Gold；金）
    g = " 0"
    # シルバー（Silver；銀）
    s = " 0"
    # ナイト（kNight；桂）
    n = " 0"
    # ランス（Lance；香）
    l = " 0"
    # ポーン（Pawn；歩）
    p = " 0"

    IO.puts("""
      k  r  b  g  s  n  l  p
    +--+--+--+--+--+--+--+--+
    |#{k}|#{r}|#{b}|#{g}|#{s}|#{n}|#{l}|#{p}|
    +--+--+--+--+--+--+--+--+
    """)
  end

  # ▲先手（下手）の駒台（持ち駒の数）表示
  #
  # ## 例
  #
  #         K  R  B  G  S  N  L  P
  #       +--+--+--+--+--+--+--+--+
  #       | 0| 0| 0| 0| 0| 0| 0| 0|
  #       +--+--+--+--+--+--+--+--+
  #
  defp print_hand1() do
    # キング（King；玉）
    k = " 0"
    # ルック（Rook；飛車）
    r = " 0"
    # ビショップ（Bishop；角）
    b = " 0"
    # ゴールド（Gold；金）
    g = " 0"
    # シルバー（Silver；銀）
    s = " 0"
    # ナイト（kNight；桂）
    n = " 0"
    # ランス（Lance；香）
    l = " 0"
    # ポーン（Pawn；歩）
    p = " 0"

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
    a9 = print_piece(pos.piece_map[91])
    a8 = print_piece(pos.piece_map[81])
    a7 = print_piece(pos.piece_map[71])
    a6 = print_piece(pos.piece_map[61])
    a5 = print_piece(pos.piece_map[51])
    a4 = print_piece(pos.piece_map[41])
    a3 = print_piece(pos.piece_map[31])
    a2 = print_piece(pos.piece_map[21])
    a1 = print_piece(pos.piece_map[11])
    # ２段目
    b9 = print_piece(pos.piece_map[92])
    b8 = print_piece(pos.piece_map[82])
    b7 = print_piece(pos.piece_map[72])
    b6 = print_piece(pos.piece_map[62])
    b5 = print_piece(pos.piece_map[52])
    b4 = print_piece(pos.piece_map[42])
    b3 = print_piece(pos.piece_map[32])
    b2 = print_piece(pos.piece_map[22])
    b1 = print_piece(pos.piece_map[12])
    # ３段目
    c9 = print_piece(pos.piece_map[93])
    c8 = print_piece(pos.piece_map[83])
    c7 = print_piece(pos.piece_map[73])
    c6 = print_piece(pos.piece_map[63])
    c5 = print_piece(pos.piece_map[53])
    c4 = print_piece(pos.piece_map[43])
    c3 = print_piece(pos.piece_map[33])
    c2 = print_piece(pos.piece_map[23])
    c1 = print_piece(pos.piece_map[13])
    # ４段目
    d9 = print_piece(pos.piece_map[94])
    d8 = print_piece(pos.piece_map[84])
    d7 = print_piece(pos.piece_map[74])
    d6 = print_piece(pos.piece_map[64])
    d5 = print_piece(pos.piece_map[54])
    d4 = print_piece(pos.piece_map[44])
    d3 = print_piece(pos.piece_map[34])
    d2 = print_piece(pos.piece_map[24])
    d1 = print_piece(pos.piece_map[14])
    # ５段目
    e9 = print_piece(pos.piece_map[95])
    e8 = print_piece(pos.piece_map[85])
    e7 = print_piece(pos.piece_map[75])
    e6 = print_piece(pos.piece_map[65])
    e5 = print_piece(pos.piece_map[55])
    e4 = print_piece(pos.piece_map[45])
    e3 = print_piece(pos.piece_map[35])
    e2 = print_piece(pos.piece_map[25])
    e1 = print_piece(pos.piece_map[15])
    # ６段目
    f9 = print_piece(pos.piece_map[96])
    f8 = print_piece(pos.piece_map[86])
    f7 = print_piece(pos.piece_map[76])
    f6 = print_piece(pos.piece_map[66])
    f5 = print_piece(pos.piece_map[56])
    f4 = print_piece(pos.piece_map[46])
    f3 = print_piece(pos.piece_map[36])
    f2 = print_piece(pos.piece_map[26])
    f1 = print_piece(pos.piece_map[16])
    # ７段目
    g9 = print_piece(pos.piece_map[97])
    g8 = print_piece(pos.piece_map[87])
    g7 = print_piece(pos.piece_map[77])
    g6 = print_piece(pos.piece_map[67])
    g5 = print_piece(pos.piece_map[57])
    g4 = print_piece(pos.piece_map[47])
    g3 = print_piece(pos.piece_map[37])
    g2 = print_piece(pos.piece_map[27])
    g1 = print_piece(pos.piece_map[17])
    # ８段目
    h9 = print_piece(pos.piece_map[98])
    h8 = print_piece(pos.piece_map[88])
    h7 = print_piece(pos.piece_map[78])
    h6 = print_piece(pos.piece_map[68])
    h5 = print_piece(pos.piece_map[58])
    h4 = print_piece(pos.piece_map[48])
    h3 = print_piece(pos.piece_map[38])
    h2 = print_piece(pos.piece_map[28])
    h1 = print_piece(pos.piece_map[18])
    # ９段目
    i9 = print_piece(pos.piece_map[99])
    i8 = print_piece(pos.piece_map[89])
    i7 = print_piece(pos.piece_map[79])
    i6 = print_piece(pos.piece_map[69])
    i5 = print_piece(pos.piece_map[59])
    i4 = print_piece(pos.piece_map[49])
    i3 = print_piece(pos.piece_map[39])
    i2 = print_piece(pos.piece_map[29])
    i1 = print_piece(pos.piece_map[19])

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

  # 駒の表示
  #
  # ## 引数
  #
  # pc - ピース（piece；先後付きの駒種類）
  #
  defp print_piece(pc) do
    case pc do
      # ▲先手（下手）
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
      # ▽後手（上手）
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
end
