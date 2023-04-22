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
  def do_it(pos, move) do
    {pos, captured_pt} =
      if move.drop_piece_type != nil do
        #
        # 打った
        # =====
        #
        # 打つ駒と、減った枚数
        drop_piece = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.turn, move.drop_piece_type)
        num = pos.hand_pieces[drop_piece] - 1
        # 局面更新
        pos =
          %{ pos |
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

        {pos, nil}
      else
        #
        # 盤上の駒を動かした
        # ===============
        #

        # （移動先にある）ピース（PieCe；先後付きの駒種類）。無ければ空マス
        target_pc = pos.board[move.destination]
        IO.puts("[do_move] move.destination #{move.destination} square.")

        # * `captured_pt` - 取ったピース・タイプ（Piece Type；駒の種類）
        {pos, captured_pt} =
          if target_pc != :sp do
            #
            # 駒を取った
            # =========
            #

            # 取った駒種類（成りの情報を含む）
            captured_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)
            # 持ち駒種類（先後付き）（成りの情報を含まない）
            hand_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_captured_piece_to_hand(target_pc)

            # 局面更新
            IO.puts("[do_move] Captured #{target_pc} piece to #{hand_pc} piece.")
            IO.puts("[do_move] How many #{hand_pc} pieces? It is #{pos.hand_pieces[hand_pc]} pieces.")
            num = pos.hand_pieces[hand_pc] + 1
            pos = %{ pos |
                    hand_pieces: %{ pos.hand_pieces |
                                    hand_pc => num
                                  }
                  }

            {pos, captured_pt}

          else
            {pos, nil}
          end

        # 動かした駒が玉なら
        played_piece = pos.board[move.source]
        pos =
          if played_piece == :k1 or played_piece == :k2 do
            # 玉のいるマス更新
            %{ pos |
              location_of_kings: %{ pos.location_of_kings |
                played_piece => move.destination
              }
            }
          else
            pos
          end

        # 局面更新
        pos =
          %{ pos |
            # 将棋盤更新
            board: %{ pos.board |
              # 移動元マスは、空マスになる
              move.source => :sp,
              # 移動先マスへ、移動元マスの駒を置く
              move.destination => if move.promote? do
                # TODO （成るなら）成る
                KifuwarabeWcsc33.CLI.Mappings.ToPiece.promote(played_piece)
              else
                pos.board[move.source]
              end
            }
          }

        {pos, captured_pt}

      end

    # 局面更新
    pos = %{pos |
            turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn),
            opponent_turn: pos.turn,
            moves: pos.moves ++ [move],
            captured_piece_types: pos.captured_piece_types ++ [captured_pt]}

    pos
  end
end
