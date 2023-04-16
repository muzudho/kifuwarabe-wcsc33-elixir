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

    # とりあえず、現局面で指せる手（合法手）を全部列挙しようぜ
    move_list = KifuwarabeWcsc33.CLI.Routes.MoveGeneration.make_move_list(pos)
    # IO.inspect(move_list, label: "[Think go] move_list")

    best_move =
      if move_list |> length() < 1 do
        # 合法手が無ければ投了
        best_move = KifuwarabeWcsc33.CLI.Models.Move.new()
        best_move
      else
        # 合法手が１つ以上あれば、どれか適当に選ぶ
        best_move = Enum.random(move_list)
        best_move
      end

    # IO.puts("[Think go] best_move:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(best_move)}")
    best_move
  end
end
