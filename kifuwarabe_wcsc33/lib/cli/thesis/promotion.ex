defmodule KifuwarabeWcsc33.CLI.Thesis.Promotion do
  @moduledoc """
  
    成り判定
  
  """

  @doc """
  
    成れるか？
  
    - 玉、金、成り駒は、この関数を使うな（成っていない駒だけが成れる）
  
  ## Parameters
  
    * `pos` - ポジション（Position；局面）
    * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
    * `dst_sq` - デスティネーション・スクウェア（DeSTination SQuare：移動先のマス番地）
  
  """
  def can_promote?(pos, src_sq, dst_sq) do
    dst_rank = KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(dst_sq)
    src_rank = KifuwarabeWcsc33.CLI.Mappings.ToSquare.rank(src_sq)

    can_promote =
      if pos.turn == :sente do
        # 先手で
        cond do
          # 相手の陣地に入れば、成れる
          dst_rank < 4 -> true
          # 相手の陣地に入ったかどうかに関わらず、相手の陣地から移動したら、成れる
          src_rank < 4 -> true
          # それ以外だと成れない
          true -> false
        end
      else
        # 後手で
        cond do
          # 相手の陣地に入れば、成れる
          7 <= dst_rank -> true
          # 相手の陣地に入ったかどうかに関わらず、相手の陣地から移動したら、成れる
          7 <= src_rank -> true
          # それ以外だと成れない
          true -> false
        end
      end

    # 相手の陣地から出るとき、成れる
    can_promote
  end
end
