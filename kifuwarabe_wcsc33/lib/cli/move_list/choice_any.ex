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
      ## TODO もし、歩を打ったときで、かつ、そこが相手の玉頭なら、打ち歩詰めチェックをしたい
      # if best_move.drop_piece_type == :p do
      #  opponent_king_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.opponent_turn, :k)
      #  opponent_king_sq = pos.location_of_kings[opponent_king_pc]
      #  opponent_king_north_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.opponent_turn, opponent_king_sq, :north_of)
      #  if best_move.destination == opponent_king_north_sq do
      #    IO.puts("[Think go] TODO Uchifudume check")
      #
      #    # TODO さらに相手の局面で指し手生成、全部の手を指してみて、１つでも指せる手があるか調べる
      #    _second_move_list = KifuwarabeWcsc33.CLI.MoveGeneration.MakeList.do_it(pos)
      #    # TODO 自殺手を除去
      #
      #  else
      #    # 打ち歩詰めではない
      #  end
      # else
      #  # 打ち歩詰めではない
      # end

      #
      # Base case
      # =========
      #

      # 再帰せず、これで確定します
      {pos, move_list, best_move}
    end
  end
end
