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
    {move_list, pos} = KifuwarabeWcsc33.CLI.Routes.MoveElimination.reduce_suicide_move(move_list, pos)

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
