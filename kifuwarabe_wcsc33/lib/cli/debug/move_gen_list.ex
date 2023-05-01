defmodule KifuwarabeWcsc33.CLI.Debug.MoveGenList do
  @moduledoc """
    指し手の一覧表示
  """

  @doc """
    表示
  """
  def print(move_list, label \\ "") do
    if KifuwarabeWcsc33.CLI.Config.is_debug_move_generation?() do
      IO.write("""

      [debug move_gen_list] BELOW, MOVE LIST #{label}
      ======================================
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
