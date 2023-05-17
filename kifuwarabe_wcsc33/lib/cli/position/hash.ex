defmodule KifuwarabeWcsc33.CLI.Position.Hash do
  @moduledoc """
    局面のハッシュ化

    👇 手番に、ハッシュを割り当てる（２箇所）
    ┌────────┬──────────┐
    │ Friend │ Opponent │
    └────────┴──────────┘

    👇 盤の各マスに、ハッシュを割り当てる（８１箇所）
    ┌───┬───┬───┬───┬───┬───┬───┬───┬───┐
    │ 91│   │   │   │   │   │   │   │ 11│
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │   │   │   │   │   │   │   │   │   │
    ├───┼───┼───┼───┼───┼───┼───┼───┼───┤
    │ 99│   │   │   │   │   │   │   │ 19│
    └───┴───┴───┴───┴───┴───┴───┴───┴───┘

    👇 持ち駒の種類別の枚数に、ハッシュを割り当てる（９０か所）
         ┌───┬───┬───┐
     ▲玉 │  0│  1│  2│
         ├───┼───┼───┤
     ▲飛 │  0│  1│  2│
         ├───┼───┼───┤
     ▲角 │  0│  1│  2│
         ├───┼───┼───┼───┬───┐
     ▲金 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┤
     ▲銀 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┤
     ▲桂 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┤
     ▲香 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┼───┬───┬───┬───┬───┬───┬───┬───┬───┐───┬───┬───┬───┬───┐
     ▲歩 │  0│  1│  2│  3│  4│  5│  6│  7│  8│  9│ 10│ 11│ 12│ 13│ 14│ 15│ 16│ 17│ 18│
         ├───┼───┼───┼───┴───┴───┴───┴───┴───┴───┘───┴───┴───┴───┴───┘───┴───┴───┴───┘
    ▽玉 │  0│  1│  2│
         ├───┼───┼───┤
    ▽飛 │  0│  1│  2│
         ├───┼───┼───┤
    ▽角 │  0│  1│  2│
         ├───┼───┼───┼───┬───┐
    ▽金 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┤
    ▽銀 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┤
    ▽桂 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┤
    ▽香 │  0│  1│  2│  3│  4│
         ├───┼───┼───┼───┼───┼───┬───┬───┬───┬───┬───┬───┬───┬───┐───┬───┬───┬───┬───┐
    ▽歩 │  0│  1│  2│  3│  4│  5│  6│  7│  8│  9│ 10│ 11│ 12│ 13│ 14│ 15│ 16│ 17│ 18│
         └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘───┴───┴───┴───┴───┘───┴───┴───┴───┘

         合計で１７９箇所分のハッシュを作成する
  """
  @max_int 18_446_744_073_709_551_615

  # * `a..b` - a以上、b以下
  defstruct turn: %{friend: Enum.random(0..@max_int), opponent: Enum.random(0..@max_int)},
            # 盤上の駒
            board: %{
              # １段目
              91 => Enum.random(0..@max_int),
              81 => Enum.random(0..@max_int),
              71 => Enum.random(0..@max_int),
              61 => Enum.random(0..@max_int),
              51 => Enum.random(0..@max_int),
              41 => Enum.random(0..@max_int),
              31 => Enum.random(0..@max_int),
              21 => Enum.random(0..@max_int),
              11 => Enum.random(0..@max_int),
              # ２段目
              92 => Enum.random(0..@max_int),
              82 => Enum.random(0..@max_int),
              72 => Enum.random(0..@max_int),
              62 => Enum.random(0..@max_int),
              52 => Enum.random(0..@max_int),
              42 => Enum.random(0..@max_int),
              32 => Enum.random(0..@max_int),
              22 => Enum.random(0..@max_int),
              12 => Enum.random(0..@max_int),
              # ３段目
              93 => Enum.random(0..@max_int),
              83 => Enum.random(0..@max_int),
              73 => Enum.random(0..@max_int),
              63 => Enum.random(0..@max_int),
              53 => Enum.random(0..@max_int),
              43 => Enum.random(0..@max_int),
              33 => Enum.random(0..@max_int),
              23 => Enum.random(0..@max_int),
              13 => Enum.random(0..@max_int),
              # ４段目
              94 => Enum.random(0..@max_int),
              84 => Enum.random(0..@max_int),
              74 => Enum.random(0..@max_int),
              64 => Enum.random(0..@max_int),
              54 => Enum.random(0..@max_int),
              44 => Enum.random(0..@max_int),
              34 => Enum.random(0..@max_int),
              24 => Enum.random(0..@max_int),
              14 => Enum.random(0..@max_int),
              # ５段目
              95 => Enum.random(0..@max_int),
              85 => Enum.random(0..@max_int),
              75 => Enum.random(0..@max_int),
              65 => Enum.random(0..@max_int),
              55 => Enum.random(0..@max_int),
              45 => Enum.random(0..@max_int),
              35 => Enum.random(0..@max_int),
              25 => Enum.random(0..@max_int),
              15 => Enum.random(0..@max_int),
              # ６段目
              96 => Enum.random(0..@max_int),
              86 => Enum.random(0..@max_int),
              76 => Enum.random(0..@max_int),
              66 => Enum.random(0..@max_int),
              56 => Enum.random(0..@max_int),
              46 => Enum.random(0..@max_int),
              36 => Enum.random(0..@max_int),
              26 => Enum.random(0..@max_int),
              16 => Enum.random(0..@max_int),
              # ７段目
              97 => Enum.random(0..@max_int),
              87 => Enum.random(0..@max_int),
              77 => Enum.random(0..@max_int),
              67 => Enum.random(0..@max_int),
              57 => Enum.random(0..@max_int),
              47 => Enum.random(0..@max_int),
              37 => Enum.random(0..@max_int),
              27 => Enum.random(0..@max_int),
              17 => Enum.random(0..@max_int),
              # ８段目
              98 => Enum.random(0..@max_int),
              88 => Enum.random(0..@max_int),
              78 => Enum.random(0..@max_int),
              68 => Enum.random(0..@max_int),
              58 => Enum.random(0..@max_int),
              48 => Enum.random(0..@max_int),
              38 => Enum.random(0..@max_int),
              28 => Enum.random(0..@max_int),
              18 => Enum.random(0..@max_int),
              # ９段目
              99 => Enum.random(0..@max_int),
              89 => Enum.random(0..@max_int),
              79 => Enum.random(0..@max_int),
              69 => Enum.random(0..@max_int),
              59 => Enum.random(0..@max_int),
              49 => Enum.random(0..@max_int),
              39 => Enum.random(0..@max_int),
              29 => Enum.random(0..@max_int),
              19 => Enum.random(0..@max_int)
            },
            # 駒台（持ち駒の数）
            hand_pieces: %{
              #
              # ▲せんて（Sente；先手） or したて（Shitate；下手）
              # ============================================
              #
              # キング（King；玉）. 対局中は玉は取れない。検討時など、盤上から玉を取り除きたいときに使う
              :k1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int)},
              # ルック（Rook；飛）
              :r1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int)},
              # ビショップ（Bishop；角）
              :b1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int)},
              # ゴールド（Gold；金）
              :g1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # シルバー（Silver；銀）
              :s1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # ナイト（kNight；桂）
              :n1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # ランス（Lance；香）
              :l1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # ポーン（Pawn；歩）
              :p1 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int),
                5 => Enum.random(0..@max_int),
                6 => Enum.random(0..@max_int),
                7 => Enum.random(0..@max_int),
                8 => Enum.random(0..@max_int),
                9 => Enum.random(0..@max_int),
                10 => Enum.random(0..@max_int),
                11 => Enum.random(0..@max_int),
                12 => Enum.random(0..@max_int),
                13 => Enum.random(0..@max_int),
                14 => Enum.random(0..@max_int),
                15 => Enum.random(0..@max_int),
                16 => Enum.random(0..@max_int),
                17 => Enum.random(0..@max_int),
                18=> Enum.random(0..@max_int)},
              #
              # ▽ごて（Gote；後手） or うわて（Uwate；上手）
              # =======================================
              #
              # キング（King；玉）. 対局中は玉は取れない。検討時など、盤上から玉を取り除きたいときに使う
              :k2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int)},
              # ルック（Rook；飛）
              :r2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int)},
              # ビショップ（Bishop；角）
              :b2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int)},
              # ゴールド（Gold；金）
              :g2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # シルバー（Silver；銀）
              :s2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # ナイト（kNight；桂）
              :n2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # ランス（Lance；香）
              :l2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int)},
              # ポーン（Pawn；歩）
              :p2 => %{
                0 => Enum.random(0..@max_int),
                1 => Enum.random(0..@max_int),
                2 => Enum.random(0..@max_int),
                3 => Enum.random(0..@max_int),
                4 => Enum.random(0..@max_int),
                5 => Enum.random(0..@max_int),
                6 => Enum.random(0..@max_int),
                7 => Enum.random(0..@max_int),
                8 => Enum.random(0..@max_int),
                9 => Enum.random(0..@max_int),
                10 => Enum.random(0..@max_int),
                11 => Enum.random(0..@max_int),
                12 => Enum.random(0..@max_int),
                13 => Enum.random(0..@max_int),
                14 => Enum.random(0..@max_int),
                15 => Enum.random(0..@max_int),
                16 => Enum.random(0..@max_int),
                17 => Enum.random(0..@max_int),
                18=> Enum.random(0..@max_int)},
            }

end
