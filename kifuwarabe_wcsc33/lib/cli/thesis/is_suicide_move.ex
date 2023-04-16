defmodule KifuwarabeWcsc33.CLI.Thesis.IsSuicideMove do
  @moduledoc """

  玉の自殺手ですか？

  """

  # 玉の自殺手ですか？
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  # ## 雑談
  #
  #   論理値型は関数名の末尾に ? を付ける？
  #
  def is_suicide_move?(_pos, _src_sq) do
    # TODO 玉の利き、飛車の利き、角の利き、桂の前後逆の利きを調べる

    # 先手視点で定義しろだぜ
    #
    # 北側のマスに
    #dst_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, :north_of)
#
    #is_suicide_move =
    #  if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(dst_sq) do
    #    target_pc = pos.board[dst_sq]
#
    #  else
    #    false
    #  end


    ## 玉の利き
    #[
    #  # ∧
    #  # │
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
    #  # 　─┐
    #  # ／
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_east_of),
    #  # ──＞
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :east_of),
    #  # ＼
    #  # 　─┘
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_east_of),
    #  # │
    #  # Ｖ
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_of),
    #  # 　／
    #  # └─
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_west_of),
    #  # ＜──
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :west_of),
    #  # ┌─
    #  # 　＼
    #  KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_west_of),
    #]

    false
  end
end
