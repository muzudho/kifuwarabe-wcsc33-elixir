defmodule KifuwarabeWcsc33.CLI.Search.Alpha do
  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    o. ベスト・ムーブ（Best Move；指し手） - 無ければニル

  """
  def do_it(pos) do
    # IO.puts("[think go] pos.turn:#{pos.turn}")

    # とりあえず、現局面で指せる手（合法手）を全部列挙しようぜ
    move_list = KifuwarabeWcsc33.CLI.MoveGeneration.MakeList.do_it(pos)
    # IO.inspect(move_list, label: "[Think go] raw move_list")
    # Enum.map(move_list, fn(move) ->
    #     move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
    #     IO.puts("[Think go] move list: (#{move_code})")
    #   end)

    #
    # 自殺手を除去したい
    # ================
    #
    {move_list, pos} = KifuwarabeWcsc33.CLI.MoveList.ReduceSuicideMove.do_it(move_list, pos)

    #
    # 指し手一覧
    # =========
    #

    move_list |> Enum.map(fn(move) ->
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
    {_pos, _move_list, best_move} = pos |> KifuwarabeWcsc33.CLI.MoveList.ChoiceAny.do_it(move_list)

    # 最善手だけ返却
    best_move
  end

end
