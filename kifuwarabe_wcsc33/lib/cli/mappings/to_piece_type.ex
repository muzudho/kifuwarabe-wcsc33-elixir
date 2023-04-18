defmodule KifuwarabeWcsc33.CLI.Mappings.ToPieceType do

  @doc """

    解析

  ## 引数

    * `piece` - ピース（Piece；先後付きの駒種類）の文字列。例参照。この関数では、スペース（Space；空きマス）は判定しません

  """
  def from_piece(piece) do
    case piece do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      # キング（King；玉）
      :k1 -> :k
      # ルック（Rook；飛車）
      :r1 -> :r
      # ビショップ（Bishop；角）
      :b1 -> :b
      # ゴールド（Gold；金）
      :g1 -> :g
      # シルバー（Silver；銀）
      :s1 -> :s
      # ナイト（kNight；桂）
      :n1 -> :n
      # ランス（Lance；香）
      :l1 -> :l
      # ポーン（Pawn；歩）
      :p1 -> :p
      # 玉は成れません
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr1 -> :pr
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb1 -> :pb
      # 金は成れません
      # :pg1
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps1 -> :ps
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn1 -> :pn
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl1 -> :pl
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp1 -> :pp
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      # キング（King；玉）
      :k2 -> :k
      # ルック（Rook；飛車）
      :r2 -> :r
      # ビショップ（Bishop；角）
      :b2 -> :b
      # ゴールド（Gold；金）
      :g2 -> :g
      # シルバー（Silver；銀）
      :s2 -> :s
      # ナイト（kNight；桂）
      :n2 -> :n
      # ランス（Lance；香）
      :l2 -> :l
      # ポーン（Pawn；歩）
      :p2 -> :p
      # 玉は成れません
      # :pk2
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr2 -> :pr
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb2 -> :pb
      # 金は成れません
      # :pg2
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps2 -> :ps
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn2 -> :pn
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl2 -> :pl
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp2 -> :pp
      #
      # それ以外はエラー
      # ==============
      #
      _ -> raise "unexpected piece:#{piece}"
    end
  end

  @doc """
  
    移動先の駒の先後を調べる（なければニル）

  ## Parameters

    * `pos` - ポジション（Position；局面）
    * `dst_sq` - デスティネーションスクウェア（DeSTination SQuare：移動先のマス番地）

  """
  def get_it_or_nil_from_destination(pos, dst_sq) do
    # 盤上なら
    # ターゲット・ピース（Target Piece；移動先の駒）を調べる
    # IO.puts("[to_destination move_list_from] in_board src_sq:#{src_sq} dst_sq:#{dst_sq} direction_of:#{direction_of} step:#{step} pos.turn:#{pos.turn}")
    target_pc = pos.board[dst_sq]

    target_turn_or_nil =
      cond do
        target_pc == :sp ->
          nil

        true ->
          KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
      end

    target_turn_or_nil
  end
end
