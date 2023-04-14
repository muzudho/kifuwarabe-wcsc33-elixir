defmodule KifuwarabeWcsc33.CLI.Views.BoardAddress do
  @doc """
    描画

  ## Parameters

    * `source` - 移動元。２桁の数。十の位がファイル（File；筋）、一の位がランク（Rank；段）

  ## Examples

    "76" -> "7g"

  """
  def as_code(source) do
    file = source |> div(10) |> rem(10)
    rank = source |> rem(10)

    rank_alphabet =
      case rank do
        1 -> "a"
        2 -> "b"
        3 -> "c"
        4 -> "d"
        5 -> "e"
        6 -> "f"
        7 -> "g"
        8 -> "h"
        9 -> "i"
      end

    "#{file}#{rank_alphabet}"
  end
end
