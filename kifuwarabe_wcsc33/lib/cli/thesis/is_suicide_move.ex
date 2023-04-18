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
        pos |> in_north(src_sq) -> true
        # 　─┐
        # ／
        pos |> in_north_east(src_sq) -> true
        #
        # ──＞
        pos |> in_east(src_sq) -> true
        # ＼
        # 　─┘
        pos |> in_south_east(src_sq) -> true
        # │
        # Ｖ
        pos |> in_south(src_sq) -> true
        # 　／
        # └─
        pos |> in_south_east(src_sq, :south_west_of) -> true
        #
        # ＜──
        pos |> in_east(src_sq, :west_of) -> true
        # ┌─
        # 　＼
        pos |> in_north_east(src_sq, :north_west_of) -> true
        # 　─┐
        # ／
        # │
        pos |> in_north_north_east(src_sq) -> true
        # ┌─
        # 　＼
        # 　　│
        pos |> in_north_north_east(src_sq, :north_north_west_of) -> true
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
  defp in_north(pos, src_sq, direction_of \\ :north_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, :north_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            # 先手視点で定義しろだぜ
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
          # 長い利き
          pos |> far_to_north(
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of),
            direction_of)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    is_suicide_move
  end

  # 北東側のマス、または北西側のマス（共用）
  #
  # 　─┐　┌─
  # ／　，　 ＼
  #
  defp in_north_east(pos, src_sq, direction_of \\ :north_east_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            # 先手視点で定義しろだぜ
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
          # 長い利き
          pos |> far_to_north_east(
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of),
            direction_of)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    is_suicide_move
  end

  # 東側のマス、または西側のマス（共用）
  #
  # ──＞，　＜──
  #
  defp in_east(pos, src_sq, direction_of \\ :east_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            # 先手視点で定義しろだぜ
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
          # 長い利き
          pos |> far_to_east(
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of),
            direction_of)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    is_suicide_move
  end

  # 南東側のマス、または南西側のマス（共用）
  #
  # ＼　　　　 ／
  # 　─┘，　└─
  defp in_south_east(pos, src_sq, direction_of \\ :south_east_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            # 先手視点で定義しろだぜ
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
          # 長い利き
          pos |> far_to_south_east(
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of),
            direction_of)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    is_suicide_move
  end


  # 南側のマス
  #
  # │
  # Ｖ
  #
  defp in_south(pos, src_sq, direction_of \\ :south_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            # 先手視点で定義しろだぜ
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
          # 長い利き
          pos |> far_to_south(
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of),
            direction_of)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    is_suicide_move
  end

  # 北北東側のマス、または北北西側のマス（共用）
  #
  # 　─┐　┌─
  # ／　　　 ＼
  # │　， 　　│
  #
  defp in_north_north_east(pos, src_sq, direction_of \\ :north_north_east_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    # 対象のマスが
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(teban_turn, src_sq, direction_of)

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_sengo = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)

          # 相手の盤で（一手指した後を想定し、手番は相手）
          if target_sengo == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 自殺手になるか？
            # 先手視点で定義しろだぜ
            case target_pt do
              # キング（King；玉）
              :k -> false
              # ルック（Rook；飛車）
              :r -> false
              # ビショップ（Bishop；角）
              :b -> false
              # ゴールド（Gold；金）
              :g -> false
              # シルバー（Silver；銀）
              :s -> false
              # ナイト（kNight；桂）
              :n -> true
              # ランス（Lance；香）
              :l -> false
              # ポーン（Pawn；歩）
              :p -> false
              # 玉は成れません
              # :pk
              # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
              :pr -> false
              # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
              :pb -> false
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
          # 桂馬に長い利きはない
          false
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    is_suicide_move
  end


  # 北側の遠くのマス
  #
  # ∧ Long
  # │
  # │
  #
  defp far_to_north(pos, _src_sq, direction_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    IO.puts("[is_suicide_move far_to_north] teban_turn:#{teban_turn} direction_of:#{direction_of}")
    # TODO 長い利き
    # TODO 空白なら再帰
    # TODO 香、飛なら利きに飛び込む。それ以外の駒なら自殺手ではない
    false
  end

  # 北東側のマス、または北西側のマス（共用）
  #
  # 　 　─┐ Long　　Long ┌─
  # 　 ／　　　 　　　 　　　＼
  # ／　　　　　　，　　 　　　 ＼
  #
  defp far_to_north_east(pos, _src_sq, direction_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    IO.puts("[is_suicide_move far_to_north_east] teban_turn:#{teban_turn} direction_of:#{direction_of}")
    # TODO 長い利き
    # TODO 空白なら再帰
    # TODO 香、飛なら利きに飛び込む。それ以外の駒なら自殺手ではない
    false
  end

  # 東側のマス、または西側のマス（共用）
  #
  # ────＞ Long，　Long ＜────
  #
  defp far_to_east(pos, _src_sq, direction_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    IO.puts("[is_suicide_move far_to_east] teban_turn:#{teban_turn} direction_of:#{direction_of}")
    # TODO 長い利き
    # TODO 空白なら再帰
    # TODO 香、飛なら利きに飛び込む。それ以外の駒なら自殺手ではない
    false
  end

  # 南東側のマス、または南西側のマス（共用）
  #
  # ＼　　　　　　 　　 ／
  # 　＼　　　　 　　 ／
  # 　　─┘ Long，　└─ Long
  #
  defp far_to_south_east(pos, _src_sq, direction_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    IO.puts("[is_suicide_move far_to_south_east] teban_turn:#{teban_turn} direction_of:#{direction_of}")
    # TODO 長い利き
    # TODO 空白なら再帰
    # TODO 香、飛なら利きに飛び込む。それ以外の駒なら自殺手ではない
    false
  end

  # 南側のマス
  #
  # │
  # │
  # Ｖ Long
  #
  defp far_to_south(pos, _src_sq, direction_of) do
    # 手番側の先後（１手指してる想定なので、反対側が手番）
    teban_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn)

    IO.puts("[is_suicide_move far_to_south] teban_turn:#{teban_turn} direction_of:#{direction_of}")
    # TODO 長い利き
    # TODO 空白なら再帰
    # TODO 香、飛なら利きに飛び込む。それ以外の駒なら自殺手ではない
    false
  end

end
