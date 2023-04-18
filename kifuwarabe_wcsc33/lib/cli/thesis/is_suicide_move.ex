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

    is_suicide_move =
      cond do
        # ∧
        # │
        pos |> is_sucide_move_in_north(src_sq) -> true
        # 　─┐
        # ／
        pos |> is_sucide_move_in_north_east(src_sq) -> true
        #
        # ──＞
        pos |> is_sucide_move_in_east(src_sq) -> true
        # ＼
        # 　─┘
        pos |> is_sucide_move_in_south_east(src_sq) -> true
        # │
        # Ｖ
        pos |> is_sucide_move_in_south(src_sq) -> true
        # 　／
        # └─
        pos |> is_sucide_move_in_south_east(src_sq, :south_west_of) -> true
        #
        # ＜──
        pos |> is_sucide_move_in_east(src_sq, :west_of) -> true
        # ┌─
        # 　＼
        pos |> is_sucide_move_in_north_east(src_sq, :north_west_of) -> true
        #
        # その他
        true -> false
      end

    is_suicide_move
  end

  # 北側のマス
  #
  # ∧
  # │
  #
  defp is_sucide_move_in_north(pos, src_sq) do
    # 先手視点で定義しろだぜ
    #
    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, :north_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

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
  end

  # 北東側のマス、または北西側のマス（共用）
  #
  # 　─┐　┌─
  # ／　，　 ＼
  #
  defp is_sucide_move_in_north_east(pos, src_sq, direction_of \\ :north_east_of) do
    # 先手視点で定義しろだぜ
    #
    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

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
              :r -> false
              # ビショップ（Bishop；角）
              :b -> true
              # ゴールド（Gold；金）
              :g -> true
              # シルバー（Silver；銀）
              :s -> true
              # ナイト（kNight；桂）
              :n -> false
              # ランス（Lance；香）
              :l -> false
              # ポーン（Pawn；歩）
              :p -> false
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
  end

  # 東側のマス、または西側のマス（共用）
  #
  # ──＞，　＜──
  #
  defp is_sucide_move_in_east(pos, src_sq, direction_of \\ :east_of) do
    # 先手視点で定義しろだぜ
    #
    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

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
              :s -> false
              # ナイト（kNight；桂）
              :n -> false
              # ランス（Lance；香）
              :l -> false
              # ポーン（Pawn；歩）
              :p -> false
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
  end

  # 南東側のマス、または南西側のマス（共用）
  #
  # ＼　　　　 ／
  # 　─┘，　└─
  defp is_sucide_move_in_south_east(pos, src_sq, direction_of \\ :south_east_of) do
    # 先手視点で定義しろだぜ
    #
    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

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
              :r -> false
              # ビショップ（Bishop；角）
              :b -> true
              # ゴールド（Gold；金）
              :g -> false
              # シルバー（Silver；銀）
              :s -> true
              # ナイト（kNight；桂）
              :n -> false
              # ランス（Lance；香）
              :l -> false
              # ポーン（Pawn；歩）
              :p -> false
              # 玉は成れません
              # :pk
              # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
              :pr -> true
              # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
              :pb -> true
              # 金は成れません
              # :pg
              # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
              :ps -> false
              # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
              :pn -> false
              # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
              :pl -> false
              # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
              :pp -> false
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
  end


  # 南側のマス
  #
  # │
  # Ｖ
  #
  defp is_sucide_move_in_south(pos, src_sq, direction_of \\ :south_of) do
    # 先手視点で定義しろだぜ
    #
    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

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
              :s -> false
              # ナイト（kNight；桂）
              :n -> false
              # ランス（Lance；香）
              :l -> false
              # ポーン（Pawn；歩）
              :p -> false
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
  end
end
