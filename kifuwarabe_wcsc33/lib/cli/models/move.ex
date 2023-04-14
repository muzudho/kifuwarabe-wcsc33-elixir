defmodule KifuwarabeWcsc33.CLI.Models.Move do
  @moduledoc """
    指し手
  """

  # 移動元マス
  defstruct source: nil,
            # 移動先マス。
            #
            # - nil なら、リザイン（Resign；投了）とする
            destination: nil,
            # （あれば）打つ駒の種類（先後の情報は持たない）
            drop_piece_type: nil,
            # 移動後に成るか？
            promote?: false

  # ## 雑談
  #
  # move = %KifuwarabeWcsc33.CLI.Models.Move{}
  #
  # のように書いても同じだが、この関数を使って
  #
  # move = KifuwarabeWcsc33.CLI.Models.Move.new()
  #
  # と書けば、呼び出される側に初期化処理を含めることができるというメリットがある
  #
  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.Move)
  end
end
