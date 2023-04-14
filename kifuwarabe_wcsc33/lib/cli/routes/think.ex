defmodule KifuwarabeWcsc33.CLI.Routes.Think do
  @doc """
    思考開始

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. ベストムーブ（Best move；最善手）

  """
  def go(_pos) do
    best_move = KifuwarabeWcsc33.CLI.Models.Move.new()
    best_move
  end
end
