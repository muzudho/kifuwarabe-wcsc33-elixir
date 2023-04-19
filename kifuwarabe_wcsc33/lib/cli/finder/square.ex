defmodule KifuwarabeWcsc33.CLI.Finder.Square do

  @doc """
    玉のいるマス番地を検索

    - 盤上にあるものとする

  ## Returns

    0. 玉のいるマス、またはニル
    
  """
  def find_king_on_board(pos, king_sengo) do
    tuple = pos.board |> Enum.find(fn {_sq, piece} ->
        # 空白ではなく
        piece != :sp and
        # キング
        KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece) == :k and
        # 指す前の手番か
        KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(piece) == king_sengo
      end)

    # IO.inspect(tuple, label: "[KifuwarabeWcsc33.CLI.Finder.Square find_king_on_board] tuple")

    if tuple != nil do
      tuple |> elem(0)
    else
      nil
    end
  end
end
