defmodule KifuwarabeWcsc33.CLI.Thesis.IsSuicideMove do
  @moduledoc """

  玉の自殺手ですか？

  """

  # 玉の自殺手ですか？
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #
  # ## 雑談
  #
  #   論理値型は関数名の末尾に ? を付ける？
  #
  def is_suicide_move?(_pos) do
    # TODO 玉の利き、飛車の利き、角の利き、桂の前後逆の利きを調べる
    false
  end
end
