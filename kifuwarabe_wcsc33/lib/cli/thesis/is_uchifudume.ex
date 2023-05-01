defmodule KifuwarabeWcsc33.CLI.Thesis.IsUchifuDume do
  @moduledoc """

    打ち歩詰めチェック

  """

  @doc """

    - もし、歩を打ったときで、かつ、そこが相手の玉頭なら、打ち歩詰めチェックをしたい

  """
  def is_uchifu_dume?(move, pos) do
    is_uchifu_dume? =
      if move.drop_piece_type == :p do
        #
        # 歩打だ
        #
        IO.puts(
          "[is_uchifu_dume] Uchifudume check, Drop a pawn #{KifuwarabeWcsc33.CLI.Views.Move.as_code(move)}"
        )

        opponent_king_pc =
          KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(
            pos.opponent_turn,
            :k
          )

        opponent_king_sq = pos.location_of_kings[opponent_king_pc]

        opponent_king_north_sq =
          KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(
            pos.opponent_turn,
            opponent_king_sq,
            :north_of
          )

        if move.destination == opponent_king_north_sq do
          #
          # 玉頭だ
          #
          IO.puts("[is_uchifu_dume] Uchifudume check, King head")
          #
          # さらに相手の局面で指し手生成、全部の手を指してみて、１つでも指せる手があるか調べる
          # TODO １個あれば、指し手生成を止めたい
          second_move_list = KifuwarabeWcsc33.CLI.MoveGeneration.MakeList.do_it(pos)
          #
          # TODO 自殺手の除去（ができてない？）
          #
          {second_move_list, _pos} =
            KifuwarabeWcsc33.CLI.MoveList.ReduceSuicideMove.do_it(second_move_list, pos, :aiteban)

          moves_count = length(second_move_list)
          IO.puts("[is_uchifu_dume] Uchifudume check, moves_count:#{moves_count}")
          IO.inspect(second_move_list, label: "[is_uchifu_dume] second_move_list")

          if moves_count < 1 do
            #
            # 指し手がない、詰みだ、打ち歩詰めだ
            #
            true
          else
            # 打ち歩詰めではない
            false
          end
        else
          # 打ち歩詰めではない
          false
        end
      else
        # 打ち歩詰めではない
        false
      end

    is_uchifu_dume?
  end
end
