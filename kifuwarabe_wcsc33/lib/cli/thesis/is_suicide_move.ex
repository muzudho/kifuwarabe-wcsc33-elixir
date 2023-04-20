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
    is_effect_in_north_2? = fn (target_pt) ->
        case target_pt do
          # ルック（Rook；飛車）
          :r -> true
          # ランス（Lance；香）
          :l -> true
          # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
          :pr -> true
          # それ以外の駒
          _ -> false
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

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_north_east_2? = fn (target_pt) ->
        case target_pt do
          # ビショップ（Bishop；角）
          :b -> true
          # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
          :pb -> true
          # それ以外の駒
          _ -> false
        end
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_east_2? = fn (target_pt) ->
        case target_pt do
          # ルック（Rook；飛車）
          :r -> true
          # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
          :pr -> true
          # それ以外の駒
          _ -> false
        end
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_south_east_2? = fn (target_pt) ->
        case target_pt do
          # ビショップ（Bishop；角）
          :b -> true
          # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
          :pb -> true
          # それ以外の駒
          _ -> false
        end
      end

    # 利きに飛び込むか？　先手視点で定義しろだぜ
    is_effect_in_south_2? = fn (target_pt) ->
        case target_pt do
          # ルック（Rook；飛車）
          :r -> true
          # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
          :pr -> true
          # それ以外の駒
          _ -> false
        end
      end

    is_suicide_move =
      cond do
        # 北側のマス
        # ∧
        # │
        pos |> adjacent(src_sq, :north_of, is_effect_in_north?, true, is_effect_in_north_2?) -> true
        # 北東側のマス
        # 　─┐
        # ／
        pos |> adjacent(src_sq, :north_east_of, is_effect_in_north_east?, true, is_effect_in_north_east_2?) -> true
        # 東側のマス
        #
        # ──＞
        pos |> adjacent(src_sq, :east_of, is_effect_in_east?, true, is_effect_in_east_2?) -> true
        # 南東側のマス
        # ＼
        # 　─┘
        pos |> adjacent(src_sq, :south_east_of, is_effect_in_south_east?, true, is_effect_in_south_east_2?) -> true
        # 南側のマス
        # │
        # Ｖ
        pos |> adjacent(src_sq, :south_of, is_effect_in_south?, true, is_effect_in_south_2?) -> true
        # 南西側のマス
        # 　／
        # └─
        pos |> adjacent(src_sq, :south_west_of, is_effect_in_south_east?, true, is_effect_in_south_east_2?) -> true
        # 西側のマス
        #
        # ＜──
        pos |> adjacent(src_sq, :west_of, is_effect_in_east?, true, is_effect_in_east_2?) -> true
        # 北西側のマス
        # ┌─
        # 　＼
        pos |> adjacent(src_sq, :north_west_of, is_effect_in_north_east?, true, is_effect_in_north_east_2?) -> true
        # 北北東側のマス
        # 　─┐
        # ／
        # │
        pos |> adjacent(src_sq, :north_north_east_of, is_effect_in_north_north_east?, false, nil) -> true
        # 北北西側のマス
        # ┌─
        # 　＼
        # 　　│
        pos |> adjacent(src_sq, :north_north_west_of, is_effect_in_north_north_east?, false, nil) -> true
        #
        # その他
        true -> false
      end

    is_suicide_move
  end

  #
  # 指定の方向のマスを調べていく
  # ========================
  #
  defp adjacent(pos, src_sq, direction_of, is_effect?, is_long_effect, is_effect_2?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move adjacent] target_sq:#{target_sq}")

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
            IO.write(" target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect?.(target_pt)
          else
            # 自駒
            false
          end

        else
          if is_long_effect do
            # （空きマスなら）長い利き
            pos |> far_to(
              target_sq,
              direction_of,
              is_effect_2?)
          else
            # 桂馬に長い利きは無い
            false
          end
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

  #
  # 長い利きのマス
  # ============
  #
  defp far_to(pos, src_sq, direction_of, is_effect_2?) do
    # 対象のマスが（１手指してる想定なので、反対側が手番）
    target_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, src_sq, direction_of)
    IO.write("[is_suicide_move far_to] target_sq:#{target_sq}")

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
            IO.write(" target_pt:#{target_pt}")

            # 利きに飛び込むか？
            is_effect_2?.(target_pt)

          else
            # 自駒
            false
          end

        else
          # （空きマスなら）長い利き
          pos |> far_to(
            target_sq,
            direction_of,
            is_effect_2?)
        end

      else
        # 盤外なら自殺手にはならない
        false
      end

    IO.puts(" is_suicide_move:#{is_suicide_move}")

    is_suicide_move
  end

end
