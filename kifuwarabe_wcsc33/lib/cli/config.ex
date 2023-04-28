defmodule KifuwarabeWcsc33.CLI.Config do
  @moduledoc """
  
    設定
  
  """

  # デバッグ・モード
  @is_debug? true
  def is_debug?, do: @is_debug?

  # デバッグ・モード . 自殺手チェック
  @is_debug_suicide_move_check? true
  def is_debug_suicide_move_check?, do: is_debug?() && @is_debug_suicide_move_check?

  # デバッグ・モード . 打ち歩詰めチェック
  @is_debug_utifudume_check? true
  def is_debug_utifudume_check?, do: is_debug?() && @is_debug_utifudume_check?

  # - depth=0 は、一度も駒を動かさずに次の１手を選ぶ。打ち歩詰めチェックなどで 0 にすることがある
  # - depth=1 は Ok。すいすい指す。しかしランダム性がなく、同じ動きを反復し出す
  # - depth=2 で待ち時間が生じる。序盤で１手 1～16秒（持ち駒を持っていると、とたんに遅くなる）
  @depth 2
  def depth() do
    if is_debug_utifudume_check?() do
      # 打ち歩詰めチェックは、０手読み（１度も駒を動かさない）で行う
      0
    else
      @depth
    end
  end
end
