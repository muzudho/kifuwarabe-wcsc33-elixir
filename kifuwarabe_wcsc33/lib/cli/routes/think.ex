defmodule KifuwarabeWcsc33.CLI.Routes.Think do
  @moduledoc """
    思考部
  """

  @doc """
    思考開始

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. ベストムーブ（Best move；最善手）

  """
  def go(pos) do

    # IO.puts("[think go] pos.turn:#{pos.turn}")

    # とりあえず、現局面で指せる手（合法手）を全部列挙しようぜ
    move_list = KifuwarabeWcsc33.CLI.Routes.MoveGeneration.make_move_list(pos)
    # IO.inspect(move_list, label: "[Think go] raw move_list")
    # Enum.map(move_list, fn(move) ->
    #     move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
    #     IO.puts("[Think go] move list: (#{move_code})")
    #   end)

    #
    # 自殺手を除去したい
    # ================
    #

    # 自玉
    friend_king_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.turn, :k)
    friend_king_sq = pos.location_of_kings[friend_king_pc]

    # TODO デバッグ消す
    searched_friend_king_sq = KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, pos.turn)
    IO.puts("[think go] DEBUG king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}")
    if friend_king_sq != searched_friend_king_sq do
      raise "[think go] error king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}"
    end

    {move_list, pos} =
      if friend_king_sq == nil do
        # 指す前の自玉がいないケース（詰将棋でもやっているのだろう）では、自殺手判定はやらない
        IO.puts("[think go] there is not friend king")
        {move_list, pos}
      else
        IO.puts("[think go] there is friend king. sq:#{friend_king_sq} pc:#{friend_king_pc}")
        #
        # 自殺手の除去ルーチン
        # =================
        #
        {rest_move_list, pos, cleanup_move_list} = KifuwarabeWcsc33.CLI.Routes.MoveElimination.reduce_suicide_move(move_list, pos)
        IO.puts("[think go] rest_move_list.length:#{rest_move_list |> length()} (Expected: 0)")

        {cleanup_move_list, pos}
      end

    #
    # 指し手一覧
    # =========
    #

    Enum.map(move_list, fn(move) ->
        move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
        IO.puts("[Think go] move list: (#{move_code})")
      end)

    # シャッフルする
    move_list = move_list |> Enum.shuffle()

    # IO.puts(
    #   """
    #   [think go] Current position.
    #
    #   """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

    # 最善手を選ぶ（投了でなければ、詰んでいないということ）
    {_pos, _move_list, best_move} = pos |> choice_any(move_list)

    best_move =
      if best_move == nil do
        # 合法手が無ければ投了
        resign_move = KifuwarabeWcsc33.CLI.Models.Move.new()
        resign_move
      else
        best_move
      end

    IO.puts("[Think go] best_move:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(best_move)}")
    best_move
  end

  # 最善手（その手を指すと詰む手以外）を選ぶ。無ければ投了を返す
  #
  # - 候補手は１つずつ減らしていく
  #
  # ## Parameters
  #
  # * `pos` - ポジション（Position；局面）
  # * `move_list` - ムーブ・リスト（Move List；指し手のリスト）
  #
  # ## Returns
  #
  # 0. ポジション（Position；局面）
  # 1. ムーブ・リスト（Move List；指し手のリスト）
  # 2. ベスト・ムーブ（Best Move；最善手）
  #
  defp choice_any(pos, move_list) do

    # {pos, move_list, best_move}
    if move_list |> length() < 1 do
      # 合法手が無ければ計算停止
      IO.puts("[think choice_any] empty move list. stop")

      {pos, move_list, nil}
    else
      # 合法手が１つ以上あれば、先頭の手を選ぶ。先頭の手は削除する
      best_move = hd(move_list)
      move_list = move_list |> List.delete_at(0)

      #
      # 候補手が、本当にダメでないか検討する
      # ===============================
      #

      if best_move.destination == nil do
        # 投了なら、再帰
        IO.puts("[think choice_any] no destination. it is a resign")

        #
        # Recursive
        # =========
        #
        choice_any(pos, move_list)

      else
        ## TODO もし、歩を打ったときで、かつ、そこが相手の玉頭なら、打ち歩詰めチェックをしたい
        #if best_move.drop_piece_type == :p do
        #  opponent_king_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.opponent_turn, :k)
        #  opponent_king_sq = pos.location_of_kings[opponent_king_pc]
        #  opponent_king_north_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, opponent_king_sq, :north_of)
        #  if best_move.destination == opponent_king_north_sq do
        #    IO.puts("[Think go] TODO Uchifudume check")
        #
        #    # TODO さらに相手の局面で指し手生成、全部の手を指してみて、１つでも指せる手があるか調べる
        #    _second_move_list = KifuwarabeWcsc33.CLI.Routes.MoveGeneration.make_move_list(pos)
        #    # TODO 自殺手を除去
        #
        #  else
        #    # 打ち歩詰めではない
        #  end
        #else
        #  # 打ち歩詰めではない
        #end

        #
        # Base case
        # =========
        #

        # 再帰せず、これで確定します
        {pos, move_list, best_move}
      end
    end
  end
end
