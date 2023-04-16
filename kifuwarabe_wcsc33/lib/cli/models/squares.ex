defmodule KifuwarabeWcsc33.CLI.Models.Squares do
  # 全マス
  @squares for file <- 1..9, rank <- 1..9, do: 10*file+rank
  def all_squares, do: @squares

  # 持ち駒の先手桂馬の置けるマス
  @squares for file <- 1..9, rank <- 1..7, do: 10*file+rank
  def sente_knight_drop_squares, do: @squares

  # 持ち駒の後手桂馬の置けるマス
  @squares for file <- 1..9, rank <- 3..9, do: 10*file+rank
  def gote_knight_drop_squares, do: @squares

  # 持ち駒の先手香と歩の置けるマス
  @squares for file <- 1..9, rank <- 1..8, do: 10*file+rank
  def sente_lance_and_pawn_drop_squares, do: @squares

  # 持ち駒の後手香と歩の置けるマス
  @squares for file <- 1..9, rank <- 2..9, do: 10*file+rank
  def gote_lance_and_pawn_drop_squares, do: @squares
end
