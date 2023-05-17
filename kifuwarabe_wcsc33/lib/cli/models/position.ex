defmodule KifuwarabeWcsc33.CLI.Models.Position do
  @type t :: %KifuwarabeWcsc33.CLI.Models.Position{
          moves_num: integer,
          turn: atom,
          fourfold_repetition: integer,
          board: map,
          hand_pieces: map,
          moves: list,
          friend_is_lose_list: list,
          opponent_is_lose_list: list,
          captured_piece_types: map,
          location_of_kings: map,
          materials_value: integer
        }

  # ## 雑談
  #
  #   Auto Format 融通きかねーっ
  #   リストに入れてからマップに変換など、色々やってみたが、これよりマシに Auto Format されるものを見つけられなかった。
  #   このようなコーディング体験は不快だ
  #
  # ムーブズ・ナンバー（moves-number；何手目か）、Half-ply
  defstruct moves_num: 1,
            # ターン（Turn；手番）
            turn: :sente,
            # オポネント・ターン（Opponent Turn；相手のターン） - 手番の逆
            opponent_turn: :gote,
            # フォーフォルド・レピティション（Fourfold repetition；千日手）
            fourfold_repetition: 0,
            # 盤上の駒
            board: %{
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
              92 => :sp,
              82 => :r2,
              72 => :sp,
              62 => :sp,
              52 => :sp,
              42 => :sp,
              32 => :sp,
              22 => :b2,
              12 => :sp,
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
              94 => :sp,
              84 => :sp,
              74 => :sp,
              64 => :sp,
              54 => :sp,
              44 => :sp,
              34 => :sp,
              24 => :sp,
              14 => :sp,
              # ５段目
              95 => :sp,
              85 => :sp,
              75 => :sp,
              65 => :sp,
              55 => :sp,
              45 => :sp,
              35 => :sp,
              25 => :sp,
              15 => :sp,
              # ６段目
              96 => :sp,
              86 => :sp,
              76 => :sp,
              66 => :sp,
              56 => :sp,
              46 => :sp,
              36 => :sp,
              26 => :sp,
              16 => :sp,
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
              98 => :sp,
              88 => :b1,
              78 => :sp,
              68 => :sp,
              58 => :sp,
              48 => :sp,
              38 => :sp,
              28 => :r1,
              18 => :sp,
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
            hand_pieces: %{
              #
              # ▲せんて（Sente；先手） or したて（Shitate；下手）
              # ============================================
              #
              # キング（King；玉）. 対局中は玉は取れない。検討時など、盤上から玉を取り除きたいときに使う
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
              #
              # ▽ごて（Gote；後手） or うわて（Uwate；上手）
              # =======================================
              #
              # キング（King；玉）. 対局中は玉は取れない。検討時など、盤上から玉を取り除きたいときに使う
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
            },
            # ムーブズ（Moves；指し手のリスト）
            moves: [],
            #
            # 手番の方は負けか？
            # ===============
            #
            friend_is_lose_list: [false],
            #
            # 相手番の方は負けか？
            # =================
            #
            opponent_is_lose_list: [false],
            # キャプチャード・ピースズ（Captured pieces；取った駒のリスト）（先後の情報なし、成りの情報付き）
            captured_piece_types: [],
            # 玉のいるマス番地（玉のいるマス番地をよく探すので）
            location_of_kings: %{
              :k1 => 59,
              :k2 => 51
            },
            #
            # （手番から見た）駒得評価値
            # ======================
            #
            #   - 古典的アルゴリズムで用いられる、思考部で使う
            #   - 現局面の手番の局面評価値。正の数なら手番良し、負の数なら相手番良し
            #
            materials_value: 0

  # Elixir のリスト、リンクドリストだ、ランダム・アクセス遅そう、使いたくねー
  # defstruct piece_list:
  #             [] ++
  #               [:l2, :n2, :s2, :g2, :k2, :g2, :s2, :n2, :l2] ++
  #               [:sp, :b2, :sp, :sp, :sp, :sp, :sp, :r2, :sp] ++
  #               [:p2, :p2, :p2, :p2, :p2, :p2, :p2, :p2, :p2] ++
  #               [:sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp] ++
  #               [:sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp] ++
  #               [:sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp, :sp] ++
  #               [:p1, :p1, :p1, :p1, :p1, :p1, :p1, :p1, :p1] ++
  #               [:sp, :b1, :sp, :sp, :sp, :sp, :sp, :r1, :sp] ++
  #               [:l1, :n1, :s1, :g1, :k1, :g1, :s1, :n1, :l1]

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.Position)
  end

  @doc """

  ## 雑談

    Elixir さっぱり分からん。クラス定義できないから仕方なくマップに初期値いれて返す

  """
  def new_hand_pieces() do
    %{
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）. 対局中は玉は取れない。検討時など、盤上から玉を取り除きたいときに使う
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
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）. 対局中は玉は取れない。検討時など、盤上から玉を取り除きたいときに使う
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
  end
end
