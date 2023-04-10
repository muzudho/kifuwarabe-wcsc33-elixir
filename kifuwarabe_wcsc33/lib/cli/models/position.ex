defmodule KifuwarabeWcsc33.CLI.Models.Position do
  # ## 雑談
  #
  #   Auto Format 融通きかねーっ
  #   リストに入れてからマップに変換など、色々やってみたが、これよりマシに Auto Format されるものを見つけられなかった。
  #   このようなコーディング体験は不快だ
  #
  # ムーブズ・ナンバー（moves-number；何手目か）、Half-ply
  defstruct moves_num: 0,
            # ターン（turn；手番）
            turn: :sente,
            # フォーフォルド・レピティション（Fourfold repetition；千日手）
            fourfold_repetition: 0,
            # 盤上の駒
            piece_map: %{
              # １段目
              91 => :l2,
              81 => :n2,
              71 => :s2,
              61 => :g2,
              51 => :k2,
              41 => :g2,
              31 => :s2,
              21 => :n2,
              11 => :l2,
              # ２段目
              92 => :em,
              82 => :b2,
              72 => :em,
              62 => :em,
              52 => :em,
              42 => :em,
              32 => :em,
              22 => :r2,
              12 => :em,
              # ３段目
              93 => :p2,
              83 => :p2,
              73 => :p2,
              63 => :p2,
              53 => :p2,
              43 => :p2,
              33 => :p2,
              23 => :p2,
              13 => :p2,
              # ４段目
              94 => :em,
              84 => :em,
              74 => :em,
              64 => :em,
              54 => :em,
              44 => :em,
              34 => :em,
              24 => :em,
              14 => :em,
              # ５段目
              95 => :em,
              85 => :em,
              75 => :em,
              65 => :em,
              55 => :em,
              45 => :em,
              35 => :em,
              25 => :em,
              15 => :em,
              # ６段目
              96 => :em,
              86 => :em,
              76 => :em,
              66 => :em,
              56 => :em,
              46 => :em,
              36 => :em,
              26 => :em,
              16 => :em,
              # ７段目
              97 => :p1,
              87 => :p1,
              77 => :p1,
              67 => :p1,
              57 => :p1,
              47 => :p1,
              37 => :p1,
              27 => :p1,
              17 => :p1,
              # ８段目
              98 => :em,
              88 => :b1,
              78 => :em,
              68 => :em,
              58 => :em,
              48 => :em,
              38 => :em,
              28 => :r1,
              18 => :em,
              # ９段目
              99 => :l1,
              89 => :n1,
              79 => :s1,
              69 => :g1,
              59 => :k1,
              49 => :g1,
              39 => :s1,
              29 => :n1,
              19 => :l1
            },
            # 駒台（持ち駒の数）
            hand_map: %{
              # ▲先手
              # キング（King；玉）
              :k1 => 0,
              # ルック（Rook；飛）
              :r1 => 0,
              # ビショップ（Bishop；角）
              :b1 => 0,
              # ゴールド（Gold；金）
              :g1 => 0,
              # シルバー（Silver；銀）
              :s1 => 0,
              # ナイト（kNight；桂）
              :n1 => 0,
              # ランス（Lance；香）
              :l1 => 0,
              # ポーン（Pawn；歩）
              :p1 => 0,
              # ▽後手
              # キング（King；玉）
              :k2 => 0,
              # ルック（Rook；飛）
              :r2 => 0,
              # ビショップ（Bishop；角）
              :b2 => 0,
              # ゴールド（Gold；金）
              :g2 => 0,
              # シルバー（Silver；銀）
              :s2 => 0,
              # ナイト（kNight；桂）
              :n2 => 0,
              # ランス（Lance；香）
              :l2 => 0,
              # ポーン（Pawn；歩）
              :p2 => 0
            }

  # Elixir のリスト、リンクドリストだ、ランダム・アクセス遅そう、使いたくねー
  # defstruct piece_list:
  #             [] ++
  #               [:l2, :n2, :s2, :g2, :k2, :g2, :s2, :n2, :l2] ++
  #               [:em, :b2, :em, :em, :em, :em, :em, :r2, :em] ++
  #               [:p2, :p2, :p2, :p2, :p2, :p2, :p2, :p2, :p2] ++
  #               [:em, :em, :em, :em, :em, :em, :em, :em, :em] ++
  #               [:em, :em, :em, :em, :em, :em, :em, :em, :em] ++
  #               [:em, :em, :em, :em, :em, :em, :em, :em, :em] ++
  #               [:p1, :p1, :p1, :p1, :p1, :p1, :p1, :p1, :p1] ++
  #               [:em, :b1, :em, :em, :em, :em, :em, :r1, :em] ++
  #               [:l1, :n1, :s1, :g1, :k1, :g1, :s1, :n1, :l1]

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.Position)
  end
end
