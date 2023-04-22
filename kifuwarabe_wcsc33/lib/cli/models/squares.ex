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

  # 持ち駒の先手香の置けるマス
  @fn_data for file <- 1..9, rank <- 1..8, do: 10*file+rank
  def sente_lance_drop_squares, do: @fn_data

  # 持ち駒の後手香の置けるマス
  @fn_data for file <- 1..9, rank <- 2..9, do: 10*file+rank
  def gote_lance_drop_squares, do: @fn_data

  # 持ち駒の先手歩の置けるマス
  # TODO 二歩チェックしたい
  @fn_data for file <- 1..9, rank <- 1..8, do: 10*file+rank
  def get_sente_pawn_drop_squares() do
    @fn_data
  end

  # 持ち駒の後手歩の置けるマス
  # TODO 二歩チェックしたい
  @fn_data for file <- 1..9, rank <- 2..9, do: 10*file+rank
  def get_gote_pawn_drop_squares() do
    @fn_data
  end

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
    # 56
    south_of: 1,
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

  #
  # 桂を置けるマスのリストを取得
  #
  def get_list_of_squares_where_i_can_place_knight(pos) do
    if pos.turn == :sente do
      KifuwarabeWcsc33.CLI.Models.Squares.sente_knight_drop_squares
    else
      KifuwarabeWcsc33.CLI.Models.Squares.gote_knight_drop_squares
    end
  end

  #
  # 香を置けるマスのリストを取得
  #
  def get_list_of_squares_where_i_can_place_lance(pos) do
    if pos.turn == :sente do
      KifuwarabeWcsc33.CLI.Models.Squares.sente_lance_drop_squares
    else
      KifuwarabeWcsc33.CLI.Models.Squares.gote_lance_drop_squares
    end
  end

  #
  # 歩を置けるマスのリストを取得
  #
  # TODO 二歩チェックを付けたい
  #
  def get_list_of_squares_where_i_can_place_pawn(pos) do
    if pos.turn == :sente do
      KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares()
    else
      KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares()
    end
  end

end
