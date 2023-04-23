defmodule KifuwarabeWcsc33.CLI.MoveList.ReduceSuicideMove do

  @doc """

    指し手のリストから、自殺手を除去

  ## Parameters

    * `move_list` - ムーブ・リスト（Move List；指し手のリスト）
    * `pos` - ポジション（Position；局面）

  ## Returns

    0. ムーブ・リスト（Move List；指し手のリスト）
    1. `pos` - ポジション（Position；局面）

  """
  def do_it(move_list, pos) do
    # 自玉
    friend_king_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.turn, :k)
    friend_king_sq = pos.location_of_kings[friend_king_pc]

    ## TODO デバッグ消す
    #searched_friend_king_sq = KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, pos.turn)
    #IO.puts("[think go] DEBUG king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}")
    #if friend_king_sq != searched_friend_king_sq do
    #  raise "[think go] error king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}"
    #end

    if friend_king_sq == nil do
      # 指す前の自玉がいないケース（詰将棋でもやっているのだろう）では、自殺手判定はやらない
      # IO.puts("[reduce_suicide_move] there is not friend king")
      {move_list, pos}
    else
      # IO.puts("[reduce_suicide_move] there is friend king. sq:#{friend_king_sq} pc:#{friend_king_pc}")
      #
      # 自殺手の除去ルーチン
      # =================
      #
      {_rest_move_list_is_empty, pos, cleanup_move_list} = reduce_suicide_move_2(move_list, pos)
      # IO.puts("[think go] rest_move_list.length:#{rest_move_list_is_empty |> length()} (Expected: 0)")

      {cleanup_move_list, pos}
    end
  end

  #
  #  指し手のリストから、自殺手を除去
  #
  # ## Parameters
  #
  #  * `rest_move_list` - レスト・ムーブ・リスト（Rest Move List；残りの指し手のリスト） - まだ判定していない残りの指し手
  #  * `pos` - ポジション（Position；局面）
  #  * `cleanup_move_list` - クリーンナップ・ムーブ・リスト（Clean-up Move List；掃除済みの指し手のリスト） - 自殺手を除去済み
  #
  # ## Returns
  #
  #  0. レスト・ムーブ・リスト（Rest Move List；残りの指し手のリスト） - まだ判定していない残りの指し手
  #  1. クリーンナップ・ムーブ・リスト（Clean-up Move List；掃除済みの指し手のリスト） - 自殺手を除去済み
  #
  defp reduce_suicide_move_2(rest_move_list, pos, cleanup_move_list \\ []) do

    {rest_move_list, pos, cleanup_move_list} =
      if rest_move_list |> length() < 1 do
        # 合法手が無ければ投了
        # IO.puts("[reduce_suicide_move] empty move list")
        {rest_move_list, pos, cleanup_move_list}
      else
        # 合法手が１つ以上あれば、先頭の手を選ぶ。先頭の手は削除する
        move = hd(rest_move_list)
        rest_move_list = rest_move_list |> List.delete_at(0)

        # 指す前の自玉がいないケース（詰将棋でもやっているのだろう）ではない前提として、存在判定を省く

        # とりあえず、１手指してみる
        # move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
        pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.DoMove.do_it(move)
        # IO.puts("[reduce_suicide_move] trn:#{pos.turn} mat_val:#{pos.materials_value}")

        #
        # 手番がひっくり返ったことに注意
        # ==========================
        #
        # - 移動後の自玉
        #
        opponent_king_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.opponent_turn, :k)
        opponent_king_sq = pos.location_of_kings[opponent_king_pc]
        # IO.puts("[reduce_suicide_move] king sq:#{opponent_king_sq} pc:#{opponent_king_pc}")

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
            # IO.puts("[reduce_suicide_move] Undo. Because #{move_code} is suicide move. king trn:#{pos.opponent_turn} pc:#{opponent_king_pc} sq:#{opponent_king_sq}")

            {cleanup_move_list}
          else
            #
            # 自殺手ではない手だ
            #
            # IO.puts("[reduce_suicide_move] Ok. Because #{move_code} is no suicide move. king trn:#{pos.opponent_turn} pc:#{opponent_king_pc} sq:#{opponent_king_sq}")
            cleanup_move_list = cleanup_move_list ++ [move]

            {cleanup_move_list}
          end

        # 手を戻す
        pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.UndoMove.do_it()

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
        {rest_move_list, pos, cleanup_move_list} = reduce_suicide_move_2(rest_move_list, pos, cleanup_move_list)

        # 再帰の帰り道
        {rest_move_list, pos, cleanup_move_list}
      end

    {rest_move_list, pos, cleanup_move_list}
  end
end
