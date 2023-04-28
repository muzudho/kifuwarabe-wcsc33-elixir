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

    # デバッグ表示
    if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
      # 盤表示
      IO.puts(
        """
        [ReduceSuicideMove] DEBUG
        """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos)
      )

      # 自玉の場所（を確認）
      searched_friend_king_sq =
        KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, pos.turn)

      IO.puts(
        "[ReduceSuicideMove] DEBUG king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}"
      )

      if friend_king_sq != searched_friend_king_sq do
        raise "[ReduceSuicideMove] DEBUG error king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}"
      end
    end

    if friend_king_sq == nil do
      # 指す前の自玉がいないケース（詰将棋でもやっているのだろう）では、自殺手判定はやらない
      if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
        IO.puts("[ReduceSuicideMove] DEBUG there is not friend king")
      end

      {move_list, pos}
    else
      if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
        IO.puts(
          "[ReduceSuicideMove] DEBUG there is friend king. sq:#{friend_king_sq} pc:#{friend_king_pc} move_list.length:#{move_list |> length()}"
        )
      end

      #
      # 自殺手の除去ルーチン
      # =================
      #
      {rest_move_list_is_empty, pos, cleanup_move_list} =
        reduce_suicide_move_2(move_list, pos, [])

      if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
        IO.puts(
          "[ReduceSuicideMove] DEBUG Reduce suicide move ... done. rest_move_list.length:#{rest_move_list_is_empty |> length()} (Expected: 0), cleanup_move_list:#{cleanup_move_list |> length()}"
        )

        IO.inspect(cleanup_move_list, label: "[ReduceSuicideMove] DEBUG cleanup_move_list")
      end

      {cleanup_move_list, pos}
    end
  end

  #
  # パターンマッチ
  #
  defp reduce_suicide_move_2(rest_move_list, pos, cleanup_move_list)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  defp reduce_suicide_move_2([], pos, cleanup_move_list) do
    if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
      IO.puts("[reduce_suicide_move_2] DEBUG empty move list. (Base case)")
    end

    # 入力をそのまま返す
    {[], pos, cleanup_move_list}
  end

  #
  #  指し手のリストから、自殺手を除去
  #
  # ## Parameters
  #
  #  * `move | rest_move_list]` - move は先頭の要素、 レスト・ムーブ・リスト（Rest Move List；残りの指し手のリスト）は、まだ判定していない残りの指し手
  #  * `pos` - ポジション（Position；局面）
  #  * `cleanup_move_list` - クリーンナップ・ムーブ・リスト（Clean-up Move List；掃除済みの指し手のリスト） - 自殺手を除去済み
  #
  # ## Returns
  #
  #  0. レスト・ムーブ・リスト（Rest Move List；残りの指し手のリスト） - まだ判定していない残りの指し手
  #  1. クリーンナップ・ムーブ・リスト（Clean-up Move List；掃除済みの指し手のリスト） - 自殺手を除去済み
  #
  defp reduce_suicide_move_2([move | rest_move_list], pos, cleanup_move_list) do
    # 指す前の自玉がいないケース（詰将棋でもやっているのだろう）ではない前提として、存在判定を省く

    # とりあえず、１手指してみる
    pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.DoMove.do_it(move)

    if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
      move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)

      IO.puts(
        """
        [reduce_suicide_move_2] Done #{move_code}. trn:#{pos.turn} mat_val:#{pos.materials_value}"
        
        """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos)
      )
    end

    #
    # 手番がひっくり返ったことに注意
    # ==========================
    #
    # - 移動後の自玉
    #
    opponent_king_pc =
      KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.opponent_turn, :k)

    opponent_king_sq = pos.location_of_kings[opponent_king_pc]

    if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
      IO.puts("[reduce_suicide_move_2] king sq:#{opponent_king_sq} pc:#{opponent_king_pc}")
    end

    # 自玉は今 opponent_turn 側
    #
    # 詰んでいるか判定
    #
    {cleanup_move_list} =
      if pos
         |> KifuwarabeWcsc33.CLI.Thesis.IsMated.is_mated?(pos.opponent_turn, opponent_king_sq) do
        #
        # 自殺手だ
        #

        if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
          move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)

          IO.puts(
            "[reduce_suicide_move_2] KO. #{move_code} is suicide move. king trn:#{pos.opponent_turn} pc:#{opponent_king_pc} sq:#{opponent_king_sq}"
          )
        end

        {cleanup_move_list}
      else
        #
        # 自殺手ではない手だ
        #
        if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
          move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)

          IO.puts(
            "[reduce_suicide_move_2] Ok. Because #{move_code} is no suicide move. king trn:#{pos.opponent_turn} pc:#{opponent_king_pc} sq:#{opponent_king_sq}"
          )
        end

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
    if KifuwarabeWcsc33.CLI.Config.is_debug_suicide_move_check?() do
      move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)

      IO.puts(
        """
        [reduce_suicide_move_2] Undone #{move_code}.
        
        """ <>
          KifuwarabeWcsc33.CLI.Views.Position.stringify(pos) <>
          """
          [reduce_suicide_move_2] Recursive rest_move_list.length:#{rest_move_list |> length()}
          """
      )
    end

    # Recursive
    # =========
    #
    # - 消去法を続ける
    {rest_move_list, pos, cleanup_move_list} =
      reduce_suicide_move_2(rest_move_list, pos, cleanup_move_list)

    # 再帰の帰り道
    {rest_move_list, pos, cleanup_move_list}
  end
end
