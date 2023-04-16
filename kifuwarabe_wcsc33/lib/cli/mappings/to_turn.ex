defmodule KifuwarabeWcsc33.CLI.Mappings.ToTurn do
  @doc """
    ピースを、ターンへ変換

  ## Parameters

    * `piece` - ピース（Piece；先後付きの駒種類）。スペースを渡すとエラー

  ## Returns

    0. ターン（Turn；先後）

  """
  def from_piece(piece) do
    case piece do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      :k1 -> :sente
      # ルック（Rook；飛車）
      :r1 -> :sente
      # ビショップ（Bishop；角）
      :b1 -> :sente
      # ゴールド（Gold；金）
      :g1 -> :sente
      # シルバー（Silver；銀）
      :s1 -> :sente
      # ナイト（kNight；桂）
      :n1 -> :sente
      # ランス（Lance；香）
      :l1 -> :sente
      # ポーン（Pawn；歩）
      :p1 -> :sente
      # 玉は成れません
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr1 -> :sente
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb1 -> :sente
      # 金は成れません
      # :pg1
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps1 -> :sente
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn1 -> :sente
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl1 -> :sente
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp1 -> :sente
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      :k2 -> :gote
      # ルック（Rook；飛車）
      :r2 -> :gote
      # ビショップ（Bishop；角）
      :b2 -> :gote
      # ゴールド（Gold；金）
      :g2 -> :gote
      # シルバー（Silver；銀）
      :s2 -> :gote
      # ナイト（kNight；桂）
      :n2 -> :gote
      # ランス（Lance；香）
      :l2 -> :gote
      # ポーン（Pawn；歩）
      :p2 -> :gote
      # 玉は成れません
      # :pk2
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr2 -> :gote
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb2 -> :gote
      # 金は成れません
      # :pg2
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps2 -> :gote
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn2 -> :gote
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl2 -> :gote
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp2 -> :gote
      #
      # それ以外はエラー
      # ==============
      #
      _ -> raise "unexpected piece:#{piece}"
    end
  end
end
