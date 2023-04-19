defmodule KifuwarabeWcsc33.CLI.Models.Squares do
  # 全マス
  @fn_data for file <- 1..9, rank <- 1..9, do: 10*file+rank
  def all_squares, do: @fn_data

  # 持ち駒の先手桂馬の置けるマス
  @fn_data for file <- 1..9, rank <- 1..7, do: 10*file+rank
  def sente_knight_drop_squares, do: @fn_data

  # 持ち駒の後手桂馬の置けるマス
  @fn_data for file <- 1..9, rank <- 3..9, do: 10*file+rank
  def gote_knight_drop_squares, do: @fn_data

  # 持ち駒の先手香と歩の置けるマス
  @fn_data for file <- 1..9, rank <- 1..8, do: 10*file+rank
  def sente_lance_and_pawn_drop_squares, do: @fn_data

  # 持ち駒の後手香と歩の置けるマス
  @fn_data for file <- 1..9, rank <- 2..9, do: 10*file+rank
  def gote_lance_and_pawn_drop_squares, do: @fn_data

  # マップ定数の定義
  # 先手から見た数にしろだぜ。
  # 将棋盤は反時計回りに９０°回転すると考えれば、マス番地は読みやすくなるだろう。
  @fn_data %{
    # 54
    # ∧
    # │
    # 55
    north_of: -1,
    # 　　　44
    # 　　─┐
    # 　／
    # 55
    north_east_of: -11,
    # 55 ──＞ 45
    east_of: -10,
    # 55
    # 　＼
    # 　　─┘
    # 　　　46
    south_east_of: -9,
    # 55
    # │
    # Ｖ
    # 54
    south_of: -1,
    # 　　　55
    # 　　／
    # 　└─
    # 66
    south_west_of: 11,
    # 65 ＜── 55
    west_of: 10,
    # 64
    # 　┌─
    # 　　＼
    # 　　　55
    north_west_of: 9,
    # 先手桂馬
    # 　　　43
    # 　　─┐
    # 　／
    #  │
    # 55
    north_north_east_of: -12,
    # 後手桂馬
    # 63
    # 　┌─
    # 　　＼
    #  　　│
    # 　　55
    north_north_west_of: 8,
  }
  def relative_offset, do: @fn_data

end
