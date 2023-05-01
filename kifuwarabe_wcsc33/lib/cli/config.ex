defmodule KifuwarabeWcsc33.CLI.Config do
  @moduledoc """

    設定

  """

  # デバッグ・モード
  @is_debug? true
  def is_debug?, do: @is_debug?

  # デバッグ・モード . 自殺手チェック
  @is_debug_suicide_move_check? false
  def is_debug_suicide_move_check?, do: is_debug?() && @is_debug_suicide_move_check?

  # デバッグ・モード . 打ち歩詰めチェック
  @is_debug_utifudume_check? false
  def is_debug_utifudume_check?, do: is_debug?() && @is_debug_utifudume_check?

  # デバッグ・モード . 指し手生成チェック
  @is_debug_move_generation? true
  def is_debug_move_generation?, do: is_debug?() && @is_debug_move_generation?

  # 何手読みか
  # =========
  #
  # - depth=1 は、平手初期局面の初手で 30 局面読む。駒をただ突いているだけ。ランダム性がなく、同じ動きを反復して千日手になってしまう。打ち歩詰めチェックなどで 1 にすることがある
  # - depth=2 は、平手初期局面の初手で 930 局面読む。すいすい指す。駒を取り返される損が見えない？
  # - depth=3 は、平手初期局面の初手で 26352 局面読む。長考に沈んでゲームにならない。駒が取り返されるのを恐れるような手を指す？
  @depth 2
  def depth() do
    if is_debug_utifudume_check?() do
      # 打ち歩詰めチェックは、１手読み（１度も駒を動かさない）で行う
      1
    else
      @depth
    end
  end
end
