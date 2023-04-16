defmodule KifuwarabeWcsc33.CLI.Models.ToDestination do
  # マップ定数の定義
  @relative_offset %{
    north_of: -10,
    north_east_of: -9,
    east_of: 1,
    south_east_of: 11,
    south_of: 10,
    south_west_of: 9,
    west_of: -1,
    north_west_of: -11
  }

  @doc """

    移動元マス番地と、先後から、指定方向の移動先マス番地を取得

  ## Parameters

    * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
    * `turn` - ターン（Turn；先後）
    * `direction_of` - ディレクション・オブ（Direction of；向き）
  
  """
  def from(src_sq, turn, direction_of) do
    relative = @relative_offset[direction_of]
    destination =
      case turn do
        :sente -> src_sq + relative
        :gote -> src_sq - relative
      end

    move = KifuwarabeWcsc33.CLI.Models.Move.new()
    move = %{ move | source: src_sq, destination: destination}
    move
  end

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.PieceDirection)
  end
end
