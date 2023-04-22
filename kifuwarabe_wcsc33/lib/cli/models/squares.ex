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

  # 持ち駒の先手歩の置けるマス（列ごと）
  #
  # ## 雑談
  #
  #   Elixirのワンライナーの書き方、ワケ分かんないからやらない
  #
  @file1 for rank <- 1..8, do: 1*10+rank
  @file2 for rank <- 1..8, do: 2*10+rank
  @file3 for rank <- 1..8, do: 3*10+rank
  @file4 for rank <- 1..8, do: 4*10+rank
  @file5 for rank <- 1..8, do: 5*10+rank
  @file6 for rank <- 1..8, do: 6*10+rank
  @file7 for rank <- 1..8, do: 7*10+rank
  @file8 for rank <- 1..8, do: 8*10+rank
  @file9 for rank <- 1..8, do: 9*10+rank
  def get_sente_pawn_drop_squares_by_file(file) do
    case file do
      1 -> @file1
      2 -> @file2
      3 -> @file3
      4 -> @file4
      5 -> @file5
      6 -> @file6
      7 -> @file7
      8 -> @file8
      9 -> @file9
    end
  end

  # 持ち駒の後手歩の置けるマス（列ごと）
  @file1 for rank <- 2..9, do: 1*10+rank
  @file2 for rank <- 2..9, do: 2*10+rank
  @file3 for rank <- 2..9, do: 3*10+rank
  @file4 for rank <- 2..9, do: 4*10+rank
  @file5 for rank <- 2..9, do: 5*10+rank
  @file6 for rank <- 2..9, do: 6*10+rank
  @file7 for rank <- 2..9, do: 7*10+rank
  @file8 for rank <- 2..9, do: 8*10+rank
  @file9 for rank <- 2..9, do: 9*10+rank
  def get_gote_pawn_drop_squares_by_file(file) do
    case file do
      1 -> @file1
      2 -> @file2
      3 -> @file3
      4 -> @file4
      5 -> @file5
      6 -> @file6
      7 -> @file7
      8 -> @file8
      9 -> @file9
    end
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
      [] ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(1) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(2) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(3) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(4) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(5) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(6) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(7) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(8) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_sente_pawn_drop_squares_by_file(9)
    else
      [] ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(1) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(2) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(3) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(4) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(5) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(6) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(7) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(8) ++
        KifuwarabeWcsc33.CLI.Models.Squares.get_gote_pawn_drop_squares_by_file(9) 
    end
  end

end
