defmodule KifuwarabeWcsc33.CLI.Mappings.ToPiece do

  @doc """
    変換
  """
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

  def promote(piece) do
    case piece do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # 玉は成れません
      # :k1
      # ルック（Rook；飛車）
      :r1 -> :pr1
      # ビショップ（Bishop；角）
      :b1 -> :pb1
      # 金は成れません
      # :g1
      # シルバー（Silver；銀）
      :s1 -> :ps1
      # ナイト（kNight；桂）
      :n1 -> :pn1
      # ランス（Lance；香）
      :l1 -> :pl1
      # ポーン（Pawn；歩）
      :p1 -> :pp1
      # 成り玉は在りません
      # :pk1
      # 竜は成れません
      # :pr1
      # 馬は成れません
      # :pb1
      # 成り金は在りません
      # :pg1
      # 全は成れません
      # :ps1
      # 圭は成れません
      # :pn1
      # 杏は成れません
      # :pl1
      # と金は成れません
      # :pp1
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # 玉は成れません
      # :k2
      # ルック（Rook；飛車）
      :r2 -> :pr2
      # ビショップ（Bishop；角）
      :b2 -> :pb2
      # 金は成れません
      # :g2
      # シルバー（Silver；銀）
      :s2 -> :ps2
      # ナイト（kNight；桂）
      :n2 -> :pn2
      # ランス（Lance；香）
      :l2 -> :pl2
      # ポーン（Pawn；歩）
      :p2 -> :pp2
      # 成り玉は在りません
      # :pk2
      # 竜は成れません
      # :pr2
      # 馬は成れません
      # :pb2
      # 成り金は在りません
      # :pg2
      # 全は成れません
      # :ps2
      # 圭は成れません
      # :pn2
      # 杏は成れません
      # :pl2
      # と金は成れません
      # :pp2
      _ -> raise "unexpected piece:#{piece}"
    end
  end

  def demote(piece) do
    case piece do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      # :k1
      # ルック（Rook；飛車）
      # :r1
      # ビショップ（Bishop；角）
      # :b1
      # ゴールド（Gold；金）
      # :g1
      # シルバー（Silver；銀）
      # :s1
      # ナイト（kNight；桂）
      # :n1
      # ランス（Lance；香）
      # :l1
      # ポーン（Pawn；歩）
      # :p1
      # 玉は成れません
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr1 -> :r1
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb1 -> :b1
      # 金は成れません
      # :pg
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps1 -> :s1
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn1 -> :n1
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl1 -> :l1
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp1 -> :p1
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      # :k2
      # ルック（Rook；飛車）
      # :r2
      # ビショップ（Bishop；角）
      # :b2
      # ゴールド（Gold；金）
      # :g2
      # シルバー（Silver；銀）
      # :s2
      # ナイト（kNight；桂）
      # :n2
      # ランス（Lance；香）
      # :l2
      # ポーン（Pawn；歩）
      # :p2
      # 玉は成れません
      # :pk2
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr2 -> :r2
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb2 -> :b2
      # 金は成れません
      # :pg2
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps2 -> :s2
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn2 -> :n2
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl2 -> :l2
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp2 -> :p2
      #
      # その他
      # =====
      #
      _ -> raise "unexpected piece:#{piece}"
    end
  end

  @doc """

    駒台へ置けるように変換

  ## Returns

    0. ピース（Piece；先後付きの駒） - ただし、持ち駒用にフィルタリング

  """
  def from_captured_piece_to_hand(captured_piece) do
    case captured_piece do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      :k1 -> :k2
      # ルック（Rook；飛車）
      :r1 -> :r2
      # ビショップ（Bishop；角）
      :b1 -> :b2
      # ゴールド（Gold；金）
      :g1 -> :g2
      # シルバー（Silver；銀）
      :s1 -> :s2
      # ナイト（kNight；桂）
      :n1 -> :n2
      # ランス（Lance；香）
      :l1 -> :l2
      # ポーン（Pawn；歩）
      :p1 -> :p2
      # 玉は成れません
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr1 -> :r2
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb1 -> :b2
      # 金は成れません
      # :pg1
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps1 -> :s2
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn1 -> :n2
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl1 -> :l2
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp1 -> :p2
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      :k2 -> :k1
      # ルック（Rook；飛車）
      :r2 -> :r1
      # ビショップ（Bishop；角）
      :b2 -> :b1
      # ゴールド（Gold；金）
      :g2 -> :g1
      # シルバー（Silver；銀）
      :s2 -> :s1
      # ナイト（kNight；桂）
      :n2 -> :n1
      # ランス（Lance；香）
      :l2 -> :l1
      # ポーン（Pawn；歩）
      :p2 -> :p1
      # 玉は成れません
      # :pk2
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr2 -> :r1
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb2 -> :b1
      # 金は成れません
      # :pg2
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps2 -> :s2
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn2 -> :n2
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl2 -> :l2
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp2 -> :p2
      #
      # その他
      # =====
      #
      _ -> raise "unexpected captured piece:#{captured_piece}"
    end
  end
end
