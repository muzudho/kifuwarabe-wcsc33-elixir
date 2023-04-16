defmodule KifuwarabeWcsc33.CLI.Mappings.ToPiece do
  def from_turn_and_piece_type(turn, piece_type) do
    if turn == :sente do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      case piece_type do
        # キング（King；玉）
        :k -> :k1
        # ルック（Rook；飛車）
        :r -> :r1
        # ビショップ（Bishop；角）
        :b -> :b1
        # ゴールド（Gold；金）
        :g -> :g1
        # シルバー（Silver；銀）
        :s -> :s1
        # ナイト（kNight；桂）
        :n -> :n1
        # ランス（Lance；香）
        :l -> :l1
        # ポーン（Pawn；歩）
        :p -> :p1
        # 玉は成れません
        # :pk
        # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
        :pr -> :pr1
        # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
        :pb -> :pb1
        # 金は成れません
        # :pg
        # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
        :ps -> :ps1
        # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
        :pn -> :pn1
        # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
        :pl -> :pl1
        # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
        :pp -> :pp1
        _ -> raise "unexpected piece_type:#{piece_type}"
      end
    else
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      case piece_type do
        # キング（King；玉）
        :k -> :k2
        # ルック（Rook；飛車）
        :r -> :r2
        # ビショップ（Bishop；角）
        :b -> :b2
        # ゴールド（Gold；金）
        :g -> :g2
        # シルバー（Silver；銀）
        :s -> :s2
        # ナイト（kNight；桂）
        :n -> :n2
        # ランス（Lance；香）
        :l -> :l2
        # ポーン（Pawn；歩）
        :p -> :p2
        # 玉は成れません
        # :pk
        # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
        :pr -> :pr2
        # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
        :pb -> :pb2
        # 金は成れません
        # :pg
        # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
        :ps -> :ps2
        # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
        :pn -> :pn2
        # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
        :pl -> :pl2
        # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
        :pp -> :pp2
        _ -> raise "unexpected piece_type:#{piece_type}"
      end
    end
  end
end
