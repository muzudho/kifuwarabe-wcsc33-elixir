defmodule KifuwarabeWcsc33.CLI.Debug.MoveGenList do
  @moduledoc """
    指し手の一覧表示
  """

  @doc """
    表示
  """
  def print(move_list) do
    if KifuwarabeWcsc33.CLI.Config do
      IO.write("""
      
      [Think go] BELOW, MOVE LIST
      ===========================
      """)

      move_list
      |> Enum.map(fn move ->
        move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
        IO.puts("> (#{move_code})")
      end)

      # 空行
      IO.puts("")
    end
  end
end
