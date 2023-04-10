defmodule KifuwarabeWcsc33.CLI.Helpers.PieceParser do
  @doc """
  
    解析
  
  ## 引数
  
    * `pt` - ピース・タイプ（Piece Type；駒種類）。例参照
  
  ## 例
  
    "l"
    "n"
    ...
  """
  def parse(pt) do
    case pt do
      #
      # ▲せんて（Sente；先手） or したて（Shitate；下手）
      # ============================================
      #
      "K" -> :k1
      #
      # ▽ごて（Gote；後手） or うわて（Uwate；上手）
      # =======================================
      #
      _ -> :otherwise
    end
  end
end
