defmodule KifuwarabeWcsc33.CLI.Views.Position do
  @doc """
    盤表示
  """
  def print() do
    print_header()
    print_hand2()
    print_body()
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
  defp print_body() do
    # うわっ、めんどくさ！
    # １段目
    a9 = print_piece(:l2)
    a8 = print_piece(:n2)
    a7 = print_piece(:s2)
    a6 = print_piece(:g2)
    a5 = print_piece(:k2)
    a4 = print_piece(:g2)
    a3 = print_piece(:s2)
    a2 = print_piece(:n2)
    a1 = print_piece(:l2)
    # ２段目
    b9 = print_piece(:sp)
    b8 = print_piece(:r2)
    b7 = print_piece(:sp)
    b6 = print_piece(:sp)
    b5 = print_piece(:sp)
    b4 = print_piece(:sp)
    b3 = print_piece(:sp)
    b2 = print_piece(:b2)
    b1 = print_piece(:sp)
    # ３段目
    c9 = print_piece(:p2)
    c8 = print_piece(:p2)
    c7 = print_piece(:p2)
    c6 = print_piece(:p2)
    c5 = print_piece(:p2)
    c4 = print_piece(:p2)
    c3 = print_piece(:p2)
    c2 = print_piece(:p2)
    c1 = print_piece(:p2)
    # ４段目
    d9 = print_piece(:sp)
    d8 = print_piece(:sp)
    d7 = print_piece(:sp)
    d6 = print_piece(:sp)
    d5 = print_piece(:sp)
    d4 = print_piece(:sp)
    d3 = print_piece(:sp)
    d2 = print_piece(:sp)
    d1 = print_piece(:sp)
    # ５段目
    e9 = print_piece(:sp)
    e8 = print_piece(:sp)
    e7 = print_piece(:sp)
    e6 = print_piece(:sp)
    e5 = print_piece(:sp)
    e4 = print_piece(:sp)
    e3 = print_piece(:sp)
    e2 = print_piece(:sp)
    e1 = print_piece(:sp)
    # ６段目
    f9 = print_piece(:sp)
    f8 = print_piece(:sp)
    f7 = print_piece(:sp)
    f6 = print_piece(:sp)
    f5 = print_piece(:sp)
    f4 = print_piece(:sp)
    f3 = print_piece(:sp)
    f2 = print_piece(:sp)
    f1 = print_piece(:sp)
    # ７段目
    g9 = print_piece(:p1)
    g8 = print_piece(:p1)
    g7 = print_piece(:p1)
    g6 = print_piece(:p1)
    g5 = print_piece(:p1)
    g4 = print_piece(:p1)
    g3 = print_piece(:p1)
    g2 = print_piece(:p1)
    g1 = print_piece(:p1)
    # ８段目
    h9 = print_piece(:sp)
    h8 = print_piece(:b1)
    h7 = print_piece(:sp)
    h6 = print_piece(:sp)
    h5 = print_piece(:sp)
    h4 = print_piece(:sp)
    h3 = print_piece(:sp)
    h2 = print_piece(:r1)
    h1 = print_piece(:sp)
    # ９段目
    i9 = print_piece(:l1)
    i8 = print_piece(:n1)
    i7 = print_piece(:s1)
    i6 = print_piece(:g1)
    i5 = print_piece(:k1)
    i4 = print_piece(:g1)
    i3 = print_piece(:s1)
    i2 = print_piece(:n1)
    i1 = print_piece(:l1)

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
