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

    ## TODO デバッグ消す
    #searched_friend_king_sq = KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, pos.turn)
    #IO.puts("[think go] DEBUG king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}")
    #if friend_king_sq != searched_friend_king_sq do
    #  raise "[think go] error king sq. friend_king_sq:#{friend_king_sq} searched_friend_king_sq:#{searched_friend_king_sq}"
    #end

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
    {_pos, _move_list, best_move} = pos |> KifuwarabeWcsc33.CLI.Routes.MoveChoice.choice_any(move_list)

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

end
