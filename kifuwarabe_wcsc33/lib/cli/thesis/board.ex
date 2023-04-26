defmodule KifuwarabeWcsc33.CLI.Thesis.Board do
  @moduledoc """
  
    将棋盤

  """

  @doc """

    指定マスが、盤上かどうか判定する

  ## Parameters
  
    * `sq` - スクウェア（Square；マス番地）。11～99
  
  """
  @spec is_in_board?(integer) :: bool
  def is_in_board?(sq) do
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

  @doc """

    相手の陣地のマス番地か？

  ## Parameters
  
    * `pos` - ポジション（Position；局面）
    * `sq` - スクウェア（Square；マス番地）。11～99

  """
  def is_in_teban_territory?(pos, sq) do
    if pos.turn == :sente do
      7 <= KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq)
    else
      KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq) < 4
    end
  end

  @doc """

    相手の陣地のマス番地か？

  ## Parameters
  
    * `pos` - ポジション（Position；局面）
    * `sq` - スクウェア（Square；マス番地）。11～99

  """
  def is_in_opponent_territory?(pos, sq) do
    if pos.turn == :sente do
      KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq) < 4
    else
      7 <= KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq)
    end
  end

  @doc """

    相手の陣地のマス番地か？

    - 桂の成れない段

  ## Parameters
  
    * `pos` - ポジション（Position；局面）
    * `sq` - スクウェア（Square；マス番地）。11～99

  """
  def is_in_opponent_rank1_and_2?(pos, sq) do
    if pos.turn == :sente do
      KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq) < 3
    else
      8 <= KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq)
    end
  end

  @doc """

    相手の陣地のマス番地か？

    - 香、歩の成れない段

  ## Parameters
  
    * `pos` - ポジション（Position；局面）
    * `sq` - スクウェア（Square；マス番地）。11～99

  """
  def is_in_opponent_rank1?(pos, sq) do
    if pos.turn == :sente do
      KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq) < 2
    else
      9 <= KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(sq)
    end
  end

  #
  # 指定マスに、指定の駒があるか？
  #
  def is_there_piece?(squares, piece, board) do
    squares |> Enum.any?(fn (sq) -> board[sq]==piece end)
  end

end
