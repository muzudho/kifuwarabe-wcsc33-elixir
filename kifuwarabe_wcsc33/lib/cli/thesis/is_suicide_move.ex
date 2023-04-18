defmodule KifuwarabeWcsc33.CLI.Thesis.IsSuicideMove do
  @moduledoc """

  玉の自殺手ですか？

  """

  # 玉の自殺手ですか？
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  # ## 雑談
  #
  #   論理値型は関数名の末尾に ? を付ける？
  #
  def is_suicide_move?(pos, src_sq) do
    # TODO 玉の利き、飛車の利き、角の利き、桂の前後逆の利きを調べる

    # 先手視点で定義しろだぜ
    #
    # 北側のマスが
    dst_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, :north_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(dst_sq) do
        # その駒は
        target_pc = pos.board[dst_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToSengo.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            case target_pt do
              # キング（King；玉）
              :k -> true
              # ルック（Rook；飛車）
              :r -> true
              # ビショップ（Bishop；角）
              :b -> false
              # ゴールド（Gold；金）
              :g -> true
              # シルバー（Silver；銀）
              :s -> true
              # ナイト（kNight；桂）
              :n -> false
              # ランス（Lance；香）
              :l -> true
              # ポーン（Pawn；歩）
              :p -> true
              # 玉は成れません
              # :pk
              # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
              :pr -> true
              # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
              :pb -> true
              # 金は成れません
              # :pg
              # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
              :ps -> true
              # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
              :pn -> true
              # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
              :pl -> true
              # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
              :pp -> true
              _ -> raise "unexpected target_piece_type:#{target_pt}"
            end
          else
            # 見方の駒
            false
          end

        else
          # TODO 長い利き
          # TODO 空白なら再帰
          # TODO 香、飛なら利きに飛び込む。それ以外の駒なら自殺手ではない
          false
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    if is_suicide_move do
      true
    else
      # TODO 他の向き
      false

      ## 玉の利き
      #[
      #  # ∧
      #  # │
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
      #  # 　─┐
      #  # ／
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_east_of),
      #  # ──＞
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :east_of),
      #  # ＼
      #  # 　─┘
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_east_of),
      #  # │
      #  # Ｖ
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_of),
      #  # 　／
      #  # └─
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_west_of),
      #  # ＜──
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :west_of),
      #  # ┌─
      #  # 　＼
      #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_west_of),
      #]
    end
  end
end
