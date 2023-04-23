defmodule KifuwarabeWcsc33.CLI.Helpers.MaterialValueCalc do
  @moduledoc """

    駒得を数える

  """

  @doc """

    駒得を数える

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. バリュー（Value；評価値）

  """
  def count(pos) do

    # 先手が良ければプラス、後手が良ければマイナスとする

    # 全てのマスについて
    # |> 駒を評価値に変換
    # |> すべてのマスの評価値を足して、１つの整数にする
    value_on_board =
      KifuwarabeWcsc33.CLI.Models.Squares.all_squares
        |> Enum.map(fn (sq) -> get_value_by_piece(pos.board[sq]) end)
        |> Enum.reduce(0, fn (value, acc) -> acc + value end)

    # 全ての持ち駒について
    # |> 駒の数を、整数１つ分の評価値に変換
    # |> すべてのマスの評価値を足して、１つの整数にする
    value_on_hand =
      pos.hand_pieces
        |> Enum.map(fn (piece_and_num) -> elem(piece_and_num, 1) * get_value_by_piece(elem(piece_and_num, 0)) end)
        |> Enum.reduce(0, fn (value, acc) -> acc + value end)

    value_on_board + value_on_hand
  end

  defp get_value_on_board(_sq, _pos) do
    0
  end

  #
  # 先手から見た評価値
  #
  # ## 雑談
  #
  #   - この手法には、勝つことをそっちのけで「と金」をたくさん作ってしまう、という問題点がある。（数学的に言えば、線形だから）
  #   - 古典的には、歩を 100 にする想定（センチポーン）だが、一時期は 90 といった 100 未満に減らしたり、機械学習で自動的に点数付けられた時期を経て、 2023年現在では センチポーンは気にされなくなった
  #   - （特に決まりはないが、考えれば分かるが）玉の評価値は、それ以外の全ての駒を取ったときより大きくしておくこと
  #
  #     Pro.Rook   Pro.Bishop  Gold      Silver    Pro.Knight   Pro.Lance   Pro.Pawn
  #     2 * 1000 + 2 * 900 +   4 * 500 + 4 * 400 + 4 * 500    + 4 * 500   + 18 * 150 = 14100
  #
  #   - 下記の数値は、開発者の Muzudho が適当に付けた
  #
  @king 15000
  @rook 900
  @bishop 800
  @gold 500
  @silver 400
  @knight 200
  @lance 200
  @pawn 100
  @promoted_rook 1000
  @promoted_bishop 900
  @promoted_silver 400
  @promoted_knight 500
  @promoted_lance 500
  @promoted_pawn 150
  @space 0
  defp get_value_by_piece(piece) do
    case piece do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      :k1 -> @king
      # ルック（Rook；飛車）
      :r1 -> @rook
      # ビショップ（Bishop；角）
      :b1 -> @bishop
      # ゴールド（Gold；金）
      :g1 -> @gold
      # シルバー（Silver；銀）
      :s1 -> @silver
      # ナイト（kNight；桂）
      :n1 -> @knight
      # ランス（Lance；香）
      :l1 -> @lance
      # ポーン（Pawn；歩）
      :p1 -> @pawn
      # 成り玉なんて無いぜ
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr1 -> @promoted_rook
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb1 -> @promoted_bishop
      # 裏返った金なんて無いぜ
      # :pg1
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps1 -> @promoted_silver
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn1 -> @promoted_knight
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl1 -> @promoted_lance
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp1 -> @promoted_pawn
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      :k2 -> - @king
      # ルック（Rook；飛車）
      :r2 -> - @rook
      # ビショップ（Bishop；角）
      :b2 -> @bishop
      # ゴールド（Gold；金）
      :g2 -> @gold
      # シルバー（Silver；銀）
      :s2 -> @silver
      # ナイト（kNight；桂）
      :n2 -> @knight
      # ランス（Lance；香）
      :l2 -> @lance
      # ポーン（Pawn；歩）
      :p2 -> @pawn
      # 成り玉なんて無いぜ
      # :pk2
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr2 -> @promoted_rook
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb2 -> @promoted_bishop
      # 裏返った金なんて無いぜ
      # :pg2
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps2 -> @promoted_silver
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn2 -> @promoted_knight
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl2 -> @promoted_lance
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp2 -> @promoted_pawn
      #
      # 空マス
      # =====
      #
      :sp -> @space
      #
      # それ以外はエラー
      # ==============
      #
      _ -> raise "unexpected piece:#{piece}"
    end
  end
end
