defmodule KifuwarabeWcsc33.CLI.Config do
  @moduledoc """
  
    設定
  
  """

  # - depth=1 は Ok。すいすい指す。しかしランダム性がなく、同じ動きを反復し出す
  # - depth=2 で待ち時間が生じる。序盤で１手 1～16秒（持ち駒を持っていると、とたんに遅くなる）
  @depth 1
  def depth, do: @depth
end
