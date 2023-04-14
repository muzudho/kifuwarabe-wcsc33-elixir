defmodule KifuwarabeWcsc33.CLI.Routes.MoveGeneration do
  @moduledoc """
    指し手生成
  """

  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  """
  def make_move_list(pos) do
    move_list = []

    # TODO 盤上の自分の駒と、持っている駒の数だけ、合法手が生成できる
    # nil は除去
    move_sub_list = Enum.map(pos.board, fn {sq,piece} -> pos|>make_move_list_by_piece(sq,piece) end) |> Enum.filter(& !is_nil(&1))

    move_list = move_list ++ move_sub_list

    # move_list = move_list ++ [KifuwarabeWcsc33.CLI.Models.Move.new()]

    move_list
  end

  # ## 引数
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `sq` - スクウェア（Square：マス番地）
  #   * `piece` - ピース（Piece；先後付きの駒種類）
  #
  defp make_move_list_by_piece(pos, sq, piece) do
    IO.puts("turn:#{pos.turn} sq:#{sq} piece:#{piece}")
    nil
  end
end
