defmodule KifuwarabeWcsc33.CLI.Routes.MoveGeneration do
  @moduledoc """
    指し手生成
  """

  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  """
  def make_move_list(_pos) do
    move_list = []

    move_list = move_list ++ [KifuwarabeWcsc33.CLI.Models.Move.new()]

    move_list
  end
end
