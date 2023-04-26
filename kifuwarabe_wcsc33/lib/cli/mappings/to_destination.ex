defmodule KifuwarabeWcsc33.CLI.Mappings.ToDestination do
  @moduledoc """
  
    移動先マス番地
  
  """

  @doc """
    変換
  
  ## Parameters
  
    * `turn` - ターン（Turn；手番）
    * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
    * `direction_of` - ディレクション・オブ（Direction of；向き）
  
  """
  @spec from_turn_and_source(atom, integer, atom) :: integer
  def from_turn_and_source(turn, src_sq, direction_of) do
    relative = KifuwarabeWcsc33.CLI.Models.Squares.relative_offset()[direction_of]

    dst_sq =
      case turn do
        :sente -> src_sq + relative
        :gote -> src_sq - relative
        _ -> raise "unexpected turn:#{turn}"
      end

    dst_sq
  end
end
