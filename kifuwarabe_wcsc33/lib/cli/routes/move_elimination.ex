defmodule KifuwarabeWcsc33.CLI.Routes.MoveElimination do

  @doc """

    指し手のリストから、自殺手を除去

  ## Returns

    0. レスト・ムーブ・リスト（Rest Move List；残りの指し手のリスト） - まだ判定していない残りの指し手
    1. クリーンナップ・ムーブ・リスト（Clean-up Move List；掃除済みの指し手のリスト） - 自殺手を除去済み

  """
  def reduce_suicide_move(rest_move_list, pos, cleanup_move_list \\ []) do

    {rest_move_list, pos, cleanup_move_list} =
      if rest_move_list |> length() < 1 do
        # 合法手が無ければ投了
        IO.puts("[move_elimination reduce_suicide_move] empty move list")
        {rest_move_list, pos, cleanup_move_list}
      else
        # 合法手が１つ以上あれば、先頭の手を選ぶ。先頭の手は削除する
        move = hd(rest_move_list)
        rest_move_list = rest_move_list |> List.delete_at(0)

        # 指す前の自玉がいないケース（詰将棋でもやっているのだろう）ではない前提として、存在判定を省く

        # とりあえず、１手指してみる
        move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
        pos = pos |> KifuwarabeWcsc33.CLI.Routes.DoMove.do_it(move)

        #
        # 手番がひっくり返ったことに注意
        # ==========================
        #
        # - 移動後の自玉
        #
        opponent_king_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.opponent_turn, :k)
        opponent_king_sq = pos.location_of_kings[opponent_king_pc]
        # IO.puts("[move_elimination reduce_suicide_move] king sq:#{opponent_king_sq} pc:#{opponent_king_pc}")

        #IO.puts(
        #  """
        #  [think choice] Done #{move_code}.
        #
        #  """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

        {cleanup_move_list} =
          # 自玉は今 opponent_turn 側
          if pos |> KifuwarabeWcsc33.CLI.Thesis.IsMated.is_mated?(pos.opponent_turn, opponent_king_sq) do
            #
            # 自殺手だ
            #
            IO.puts("[think choice] Undo. Because #{move_code} is suicide move. king turn:#{pos.opponent_turn} pc:#{opponent_king_pc} sq:#{opponent_king_sq}")

            {cleanup_move_list}
          else
            #
            # 自殺手ではない手だ
            #
            IO.puts("[think choice] Ok. Because #{move_code} is no suicide move. king turn:#{pos.opponent_turn} pc:#{opponent_king_pc} sq:#{opponent_king_sq}")
            cleanup_move_list = cleanup_move_list ++ [move]

            {cleanup_move_list}
          end

        # 手を戻す
        pos = pos |> KifuwarabeWcsc33.CLI.Routes.UndoMove.do_it()

        #
        # ひっくり返っていた手番が元に戻っていることに注意
        # =========================================
        #

        # 盤表示
        #IO.puts(
        #  """
        #  [think choice] Undone #{best_move_code}. It is suicide move.
        #
        #  """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

        # Recursive
        # =========
        #
        # - 消去法を続ける
        {rest_move_list, pos, cleanup_move_list} = reduce_suicide_move(rest_move_list, pos, cleanup_move_list)

        # 再帰の帰り道
        {rest_move_list, pos, cleanup_move_list}
      end

    {rest_move_list, pos, cleanup_move_list}
  end
end
