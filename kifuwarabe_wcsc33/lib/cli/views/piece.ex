defmodule KifuwarabeWcsc33.CLI.Views.Piece do
  @doc """

    解析

  ## 引数

    * `pt` - ピース・タイプ（Piece Type；駒種類）の文字列。例参照。この関数では、スペース（Space；空きマス）は判定しません

  ## 例

    "l"
    "n"
    ...
  """
  def as_code(pt) do
    case pt do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      "K" -> :k1
      # ルック（Rook；飛車）
      "R" -> :r1
      # ビショップ（Bishop；角）
      "B" -> :b1
      # ゴールド（Gold；金）
      "G" -> :g1
      # シルバー（Silver；銀）
      "S" -> :s1
      # ナイト（kNight；桂）
      "N" -> :n1
      # ランス（Lance；香）
      "L" -> :l1
      # ポーン（Pawn；歩）
      "P" -> :p1
      # 玉は成れません
      # "+K"
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      "+R" -> :pr1
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      "+B" -> :pb1
      # 金は成れません
      # "+G"
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      "+S" -> :ps1
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      "+N" -> :pn1
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      "+L" -> :pl1
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      "+P" -> :pp1
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      "k" -> :k2
      # ルック（Rook；飛車）
      "r" -> :r2
      # ビショップ（Bishop；角）
      "b" -> :b2
      # ゴールド（Gold；金）
      "g" -> :g2
      # シルバー（Silver；銀）
      "s" -> :s2
      # ナイト（kNight；桂）
      "n" -> :n2
      # ランス（Lance；香）
      "l" -> :l2
      # ポーン（Pawn；歩）
      "p" -> :p2
      # 玉は成れません
      # "+k"
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      "+r" -> :pr2
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      "+b" -> :pb2
      # 金は成れません
      # "+g"
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      "+s" -> :ps2
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      "+n" -> :pn2
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      "+l" -> :pl2
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      "+p" -> :pp2
      #
      # それ以外はエラー
      # ==============
      #
      _ -> raise "unexpected pt:#{pt}"
    end
  end
end
