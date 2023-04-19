defmodule KifuwarabeWcsc33.CLI.Routes.DoMove do
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
  
  """
  def move(pos, move) do
    pos =
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

        pos
      else
        # 移動先にある駒。無ければ空マス
        target = pos.board[move.destination]

        # 駒があれば取る
        move =
          if target != :sp do
            # 指し手更新
            %{ move | captured: KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target)}
          else
            move
          end

        # 局面更新
        pos = %{ pos |
          # 将棋盤更新
          board: %{ pos.board |
            # 移動元マスは、空マスになる
            move.source => :sp,
            # 移動先マスへ、移動元マスの駒を置く
            move.destination => if move.promote? do
              # TODO （成るなら）成る
              KifuwarabeWcsc33.CLI.Mappings.ToPiece.promote(pos.board[move.source])
            else
              pos.board[move.source]
            end
          }
        }

        pos
      end

    # 局面更新
    pos = %{pos |
            turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn),
            opponent_turn: pos.turn,
            moves: pos.moves ++ [move]}

    pos
  end
end
