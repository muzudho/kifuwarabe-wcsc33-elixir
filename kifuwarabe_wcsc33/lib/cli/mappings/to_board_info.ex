defmodule KifuwarabeWcsc33.CLI.Mappings.ToBoardInfo do
  # 指定マスが、盤上かどうか判定する
  #
  # ## Parameters
  #
  #   * `sq` - スクウェア（Square；マス番地）。11～99
  #
  def in_board(sq) do
    cond do
      sq < 11 ->
        false
      99 < sq ->
        false
      sq |> rem(10) == 0 ->
        # 0列はない
        false
      true ->
        true
    end
  end
end
