defmodule KifuwarabeWcsc33.CLI.Models.ToPosition do
  @moduledoc """
    局面ができる
  """

  @doc """

    駒を動かす

  ## Parameters

    * `pos` - ポジション（Position；局面）
    * `move` - ムーブ（Move；指し手）
  
  ## Returns

    0. ポジション（Position；局面）
    1. （あれば）キャプチャード・ピース（Captured Piece；取った駒）
  
  """
  def move(pos, move) do
    # 移動先マスにある駒。無ければ空マス
    captured = pos.board[move.destination]

    {pos, captured} =
      if move.drop_piece_type != nil do
        # 打つ駒と、減った枚数
        drop_piece = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.turn, move.drop_piece_type)
        num = pos.hand_pieces[drop_piece] - 1
        # 局面更新
        pos = %{ pos |
          # 将棋盤更新
          board: %{ pos.board |
            # 持ち駒を置く
            move.destination => drop_piece
          },
          # 駒台更新
          hand_pieces: %{ pos.hand_pieces |
            # 枚数を１減らす
            drop_piece => num
          }
        }

        {pos, captured}
      else
        # 局面更新
        pos = %{ pos |
          # 将棋盤更新
          board: %{ pos.board |
            # 移動元マスは、空マスになる
            move.source => :sp,
            # 移動先マスへ、移動元マスの駒を置く
            move.destination => pos.board[move.source]
          }
        }

        {pos, captured}
      end

    # 局面更新
    pos = %{pos |
            turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn),
            moves: pos.moves ++ [move]}

    # TODO 取った駒を、棋譜に記録したい
    {pos, captured}
  end
end
