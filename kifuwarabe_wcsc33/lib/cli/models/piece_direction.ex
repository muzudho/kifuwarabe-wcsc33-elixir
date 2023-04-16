defmodule KifuwarabeWcsc33.CLI.Models.PieceDirection do
  defstruct turn: nil

  @doc """

  ## Parameters

    * `turn` - ターン（Turn；先後）
    * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  
  """
  def north_of(turn, src_sq) do
    relative = -10
    case turn do
      :sente -> src_sq + relative
      :gote -> src_sq - relative
    end
  end

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.PieceDirection)
  end
end
