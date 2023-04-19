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

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_north? = fn (target_pt)->
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
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_north_east? = fn (target_pt)->
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
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_east? = fn (target_pt)->
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
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_south_east? = fn (target_pt)->
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
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_north_north_east? = fn (target_pt)->
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
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_south? = fn (target_pt) ->
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
      end

    is_suicide_move =
      cond do
        # ∧
        # │
        pos |> in_north(src_sq, :north_of, is_effect_in_north?) -> true
        # 　─┐
        # ／
        pos |> in_north_east(src_sq, :north_east_of, is_effect_in_north_east?) -> true
        #
        # ──＞
        pos |> in_east(src_sq, :east_of, is_effect_in_east?) -> true
        # ＼
        # 　─┘
        pos |> in_south_east(src_sq, :south_east_of, is_effect_in_south_east?) -> true
        # │
        # Ｖ
        pos |> in_south(src_sq, :south_of, is_effect_in_south?) -> true
        # 　／
        # └─
        pos |> in_south_east(src_sq, :south_west_of, is_effect_in_south_east?) -> true
        #
        # ＜──
        pos |> in_east(src_sq, :west_of, is_effect_in_east?) -> true
        # ┌─
        # 　＼
        pos |> in_north_east(src_sq, :north_west_of, is_effect_in_north_east?) -> true
        # 　─┐
        # ／
        # │
        pos |> in_north_north_east(src_sq, :north_north_east_of, is_effect_in_north_north_east?) -> true
        # ┌─
        # 　＼
        # 　　│
        pos |> in_north_north_east(src_sq, :north_north_west_of, is_effect_in_north_north_east?) -> true
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
  defp in_north(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, :north_of)
    IO.write("[is_suicide_move in_north] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_north(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 北東側のマス、または北西側のマス（共用）
  #
  # 　─┐　┌─
  # ／　，　 ＼
  #
  defp in_north_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move in_north_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_north_east(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 東側のマス、または西側のマス（共用）
  #
  # ──＞，　＜──
  #
  defp in_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move in_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_east(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 南東側のマス、または南西側のマス（共用）
  #
  # ＼　　　　 ／
  # 　─┘，　└─
  defp in_south_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move in_south_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_south_east(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end


  # 南側のマス
  #
  # │
  # Ｖ
  #
  defp in_south(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move in_south] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_south(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 北北東側のマス、または北北西側のマス（共用）
  #
  # 　─┐　┌─
  # ／　　　 ＼
  # │　， 　　│
  #
  defp in_north_north_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move in_north_north_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          # （空きマスなら）桂馬に長い利きはない
          false
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end


  # 北側の遠くのマス
  #
  # ∧ Long
  # │
  # │
  #
  defp far_to_north(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move far_to_north] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # IO.puts("[is_suicide_move far_to_north] direction_of:#{direction_of} target_sq:#{target_sq} target_pc:#{target_pc} target_turn:#{target_turn} target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect?.(target_pt)
            # 利きに飛び込むか？　先手視点で定義しろだぜ
            case target_pt do
              # ルック（Rook；飛車）
              :r -> true
              # ランス（Lance；香）
              :l -> true
              # それ以外の駒
              _ -> false
            end

          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_north(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 北東側のマス、または北西側のマス（共用）
  #
  # 　 　─┐ Long　　Long ┌─
  # 　 ／　　　 　　　 　　　＼
  # ／　　　　　　，　　 　　　 ＼
  #
  defp far_to_north_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move far_to_north_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # IO.puts("[is_suicide_move far_to_north_east] direction_of:#{direction_of} target_sq:#{target_sq} target_pc:#{target_pc} target_turn:#{target_turn} target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect?.(target_pt)
            # 利きに飛び込むか？　先手視点で定義しろだぜ
            case target_pt do
              # ビショップ（Bishop；角）
              :b -> true
              # それ以外の駒
              _ -> false
            end

          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_north_east(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 東側のマス、または西側のマス（共用）
  #
  # ────＞ Long，　Long ＜────
  #
  defp far_to_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move far_to_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # IO.puts("[is_suicide_move far_to_east] direction_of:#{direction_of} target_sq:#{target_sq} target_pc:#{target_pc} target_turn:#{target_turn} target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect?.(target_pt)
            # 利きに飛び込むか？　先手視点で定義しろだぜ
            case target_pt do
              # ルック（Rook；飛車）
              :r -> true
              # それ以外の駒
              _ -> false
            end

          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_east(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 南東側のマス、または南西側のマス（共用）
  #
  # ＼　　　　　　 　　 ／
  # 　＼　　　　 　　 ／
  # 　　─┘ Long，　└─ Long
  #
  defp far_to_south_east(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move far_to_south_east] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # IO.puts("[is_suicide_move far_to_south_east] direction_of:#{direction_of} target_sq:#{target_sq} target_pc:#{target_pc} target_turn:#{target_turn} target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect?.(target_pt)
            # 利きに飛び込むか？　先手視点で定義しろだぜ
            case target_pt do
              # ビショップ（Bishop；角）
              :b -> true
              # それ以外の駒
              _ -> false
            end

          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to_south_east(
            # （１手指してる想定なので、反対側が手番）
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  # 南側のマス
  #
  # │
  # │
  # Ｖ Long
  #
  defp far_to_south(pos, src_sq, direction_of, is_effect?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move far_to_south] target_sq:#{target_sq}")

    is_suicide_move =
      # 盤内で
      if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(target_sq) do
        # その駒は
        target_pc = pos.board[target_sq]
        IO.write(" target_pc:#{target_pc}")

        # 空マスではなく
        if target_pc != :sp do
          # 先後が
          target_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          IO.write(" target_turn:#{target_turn}")

          # 相手番で（一手指した後を想定し、手番は相手）
          if target_turn == pos.turn do
            # 駒種類は
            target_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # IO.puts("[is_suicide_move far_to_south] direction_of:#{direction_of} target_sq:#{target_sq} target_pc:#{target_pc} target_turn:#{target_turn} target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect?.(target_pt)
            # 利きに飛び込むか？　先手視点で定義しろだぜ
            case target_pt do
              # ルック（Rook；飛車）
              :r -> true
              # それ以外の駒
              _ -> false
            end

          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き（１手指してる想定なので、反対側が手番）
          pos |> far_to_south(
            KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of),
            direction_of,
            is_effect?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

end
