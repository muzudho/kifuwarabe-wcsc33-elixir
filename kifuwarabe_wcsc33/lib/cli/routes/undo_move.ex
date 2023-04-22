defmodule KifuwarabeWcsc33.CLI.Routes.UndoMove do
  @moduledoc """
    局面ができる
  """

  @doc """

    駒を（逆向きに）動かす

  ## Parameters

    * `pos` - ポジション（Position；局面）
  
  ## Returns

    0. ポジション（Position；局面）
  
  ## 雑談

    - 自殺手のときアンドゥする

  """
  def do_it(pos) do
    # 相手のターン
    opponent_turn = pos.turn

    # 最後の要素を削除するために、インデックスを取得しておく
    last_index = Enum.count(pos.moves) - 1
    IO.puts("last_index:#{last_index} pos.moves.length:#{pos.moves|>length()}")

    # 最後の指し手を取得（リンクドリストなので効率が悪い）
    move = pos.moves |> List.last()

    # 局面更新
    #
    # - ターン反転
    # - 指し手のリスト更新（最後の指し手を削除）
    pos = %{pos |
            turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn),
            opponent_turn: pos.turn,
            moves: pos.moves |> List.delete_at(last_index)
          }

    # 更新された局面を返す
    if move.drop_piece_type != nil do
      # 打った駒と、減る前の枚数
      drop_piece = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(pos.turn, move.drop_piece_type)
      num = pos.hand_pieces[drop_piece] + 1
      # 局面更新
      %{ pos |
        # 将棋盤更新
        board: %{ pos.board |
            # 置いた先を、空マスにする
            move.destination => :sp
          },
        # 駒台更新
        hand_pieces: %{ pos.hand_pieces |
            # 枚数を１増やす
            drop_piece => num
          }
      }

    else
      # 局面更新
      %{ pos |
        # 将棋盤更新
        board: %{ pos.board |
          # 移動元マスは、動かした駒になる
          move.source => if move.promote? do
              # TODO （成った駒は）成らずに戻す
              KifuwarabeWcsc33.CLI.Mappings.ToPiece.demote(pos.board[move.destination])
            else
              pos.board[move.destination]
            end,
          # 移動先マスは、取った駒（なければ空マス）になる
          move.destination =>
            if move.captured != nil do
              KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(opponent_turn, move.captured)
            else
              :sp
            end
        }
      }

    end

  end
end