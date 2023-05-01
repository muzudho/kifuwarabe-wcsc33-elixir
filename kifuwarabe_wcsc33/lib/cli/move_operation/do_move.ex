defmodule KifuwarabeWcsc33.CLI.MoveOperation.DoMove do
  @moduledoc """
    一手指す
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
        drop_piece =
          KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(
            pos.turn,
            move.drop_piece_type
          )

        # IO.puts("[do_move] drop_piece:#{drop_piece} old_num:#{pos.hand_pieces[drop_piece]}")
        num = pos.hand_pieces[drop_piece] - 1

        # ## 雑談
        #
        # 駒を打っても、駒得評価値は変わらない
        #

        # 局面更新
        #   将棋盤更新
        #     持ち駒を置く
        #   駒台更新
        #     枚数を１減らす
        pos = %{
          pos
          | board: %{
              pos.board
              | move.destination => drop_piece
            },
            hand_pieces: %{
              pos.hand_pieces
              | drop_piece => num
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

        # * `captured_pt` - 取ったピース・タイプ（Piece Type；駒の種類）
        {pos, captured_pt} =
          if target_pc != :sp do
            #
            # 駒を取った
            # =========
            #

            # 取った駒種類（成りの情報を含む）
            captured_pt = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(target_pc)

            # ## 雑談
            #
            # 駒を取ると、駒得評価値が動く
            #
            # - 駒を取れば必ず駒得だから、正の数（加算）になるはず
            #

            # 変動した評価値を加算
            new_materials_value =
              pos.materials_value +
                KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.get_value_by_piece_type(
                  captured_pt
                )

            # IO.puts("[do_move do_it] captured piece. m:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(move)} mat_val:#{pos.materials_value} new_mat_val:#{new_materials_value}")

            # 持ち駒種類（先後付き）（成りの情報を含まない）
            hand_pc = KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_captured_piece_to_hand(target_pc)

            # IO.puts("[do_move] hand_pc:#{hand_pc} old_num:#{pos.hand_pieces[hand_pc]}")
            num = pos.hand_pieces[hand_pc] + 1

            # 局面更新
            pos = %{
              pos
              | hand_pieces: %{pos.hand_pieces | hand_pc => num},
                materials_value: new_materials_value
            }

            {pos, captured_pt}
          else
            {pos, nil}
          end

        #
        # 動かす前の駒
        # ==========
        #
        piece_before_play = pos.board[move.source]

        #
        # 動かした後の駒
        # ============
        #
        {piece_after_play, new_materials_value} =
          if move.promote? do
            # （成るなら）成る
            piece_after_play = KifuwarabeWcsc33.CLI.Mappings.ToPiece.promote(piece_before_play)

            # ## 雑談
            #
            # 駒を成ると、駒得評価値が動く
            #
            # - 駒を成っても「駒得」ではないが、評価値として加算するのは、よくある
            #
            materials_value_difference =
              KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.get_value_by_piece_type(
                KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece_after_play)
              ) -
                KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.get_value_by_piece_type(
                  KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece_before_play)
                )

            new_materials_value = pos.materials_value + materials_value_difference

            # IO.puts("[do_move do_it] promotion. move:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(move)} pos.materials_value:#{pos.materials_value} new_materials_value")

            {piece_after_play, new_materials_value}
          else
            {piece_before_play, pos.materials_value}
          end

        #
        # 動かした駒が玉なら
        # ===============
        #
        pos =
          if piece_before_play == :k1 or piece_before_play == :k2 do
            # 玉のいるマス更新
            %{
              pos
              | location_of_kings: %{
                  pos.location_of_kings
                  | piece_before_play => move.destination
                }
            }
          else
            pos
          end

        # 局面更新
        pos = %{
          pos
          | # 将棋盤更新
            board: %{
              pos.board
              | # 移動元マスは、空マスになる
                move.source => :sp,
                # 移動先マスへ、移動元マスの駒を置く
                move.destination => piece_after_play
            },
            materials_value: new_materials_value
        }

        {pos, captured_pt}
      end

    # 局面更新
    #
    # - 手番がひっくり返る
    #
    pos = %{
      pos
      | turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn),
        opponent_turn: pos.turn,
        moves_num: pos.moves_num + 1,
        # リストのサイズを合わせたいので、 captured_piece_types にはニルでも入れる
        moves: pos.moves ++ [move],
        captured_piece_types: pos.captured_piece_types ++ [captured_pt],
        # 正負を逆転する
        materials_value: -pos.materials_value
    }

    #
    # 手番（または相手番）は負けか？
    # ==========================
    #
    # TODO is_checked? ではなくて、 is_checkmated? を使う必要がある
    #
    pos = %{
      pos
      | teban_is_lose?: KifuwarabeWcsc33.CLI.Thesis.IsChecked.is_checked?(pos, :teban),
        aiteban_is_lose?: KifuwarabeWcsc33.CLI.Thesis.IsChecked.is_checked?(pos, :aiteban)
    }

    pos
  end
end
