defmodule KifuwarabeWcsc33.CLI.MoveList.ChoiceAny do
  @moduledoc """
  
    指し手のリストから１手選ぶ
  
  """

  #
  # パターンマッチ
  #
  def do_it(move_list, pos)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  def do_it([], pos) do
    # 合法手が無ければ計算停止
    IO.puts("[ChoiceAny do_it] empty move list. stop")
    {pos, [], nil}
  end

  # 最善手（その手を指すと詰む手以外）を選ぶ。無ければ投了を返す
  #
  # - 候補手は１つずつ減らしていく
  #
  # ## Parameters
  #
  # * `[best_move | move_list]` - best_move は先頭の要素、ムーブ・リスト（Move List；指し手のリスト）は残りの要素のリスト
  # * `pos` - ポジション（Position；局面）
  #
  # ## Returns
  #
  # 0. ポジション（Position；局面）
  # 1. ムーブ・リスト（Move List；指し手のリスト）
  # 2. ベスト・ムーブ（Best Move；最善手）
  #
  def do_it([best_move | move_list], pos) do
    #
    # 候補手が、本当にダメでないか検討する
    # ===============================
    #

    if best_move.destination == nil do
      # 投了なら、再帰
      IO.puts("[ChoiceAny do_it] no destination. it is a resign")

      #
      # Recursive
      # =========
      #
      do_it(move_list, pos)
    else
      #
      # Base case
      # =========
      #

      # 再帰せず、これで確定します
      {pos, move_list, best_move}
    end
  end
end
