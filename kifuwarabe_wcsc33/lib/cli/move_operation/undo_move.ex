defmodule KifuwarabeWcsc33.CLI.MoveOperation.UndoMove do
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

    - アンドゥする場面の例：自殺手

  """
  def do_it(pos) do
    # 最後の指し手をリストから引っこ抜く
    {new_moves, move} =
      pos.moves
      |> KifuwarabeWcsc33.CLI.Coding.ListPopLast.do_it()

    # (あれば)最後の取った駒をリストから引っこ抜く
    {new_captured_piece_types, captured_pt} =
      pos.captured_piece_types
      |> KifuwarabeWcsc33.CLI.Coding.ListPopLast.do_it()

    # 局面更新
    #
    # - ターン反転
    # - 指し手のリスト更新（最後の指し手を削除）
    #
    pos = %{
      pos
      | turn: KifuwarabeWcsc33.CLI.Mappings.ToTurn.flip(pos.turn),
        opponent_turn: pos.turn,
        moves_num: pos.moves_num - 1,
        # 下記２つのリストの長さは揃えろ
        moves: new_moves,
        captured_piece_types: new_captured_piece_types,
        # 正負を反転
        materials_value: -pos.materials_value
    }

    #
    # 手番は負けなはずがない
    # ===================
    #
    # - 負けたあとに続けて指すことは無い前提
    #
    pos = %{pos | teban_is_lose?: false}

    # 更新された局面を返す
    if move.drop_piece_type != nil do
      #
      # 打った駒を戻す
      # ============
      #
      # 打った駒と、減る前の枚数
      drop_piece =
        KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(
          pos.turn,
          move.drop_piece_type
        )

      # IO.puts("[undo_move] drop_piece:#{drop_piece} old_num:#{pos.hand_pieces[drop_piece]}")
      num = pos.hand_pieces[drop_piece] + 1

      # ## 雑談
      #
      # 打った駒を戻しても、駒得評価値は変わらない
      #

      # 局面更新
      %{
        pos
        | # 将棋盤更新
          board: %{
            pos.board
            | # 置いた先を、空マスにする
              move.destination => :sp
          },
          # 駒台更新
          hand_pieces: %{
            pos.hand_pieces
            | # 枚数を１増やす
              drop_piece => num
          }
      }
    else
      #
      # 盤上で動かした駒を戻す
      # ===================
      #
      #

      # ## 雑談
      #
      # 取った駒を戻すと、駒得評価値が動く
      #
      # - 取った駒を返せば必ず駒損だから、負の数（減算）になるはず
      #

      #
      # 取った駒の価値
      #
      pos =
        if captured_pt != nil do
          # 持ち駒種類（先後付き）（成りの情報を含まない）
          hand_pc =
            KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_captured_piece_type_to_hand(
              pos.opponent_turn,
              captured_pt
            )

          # IO.puts("[undo_move] hand_pc:#{hand_pc} old_num:#{pos.hand_pieces[hand_pc]}")
          num = pos.hand_pieces[hand_pc] - 1

          captured_material_value =
            KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.get_value_by_piece_type(captured_pt)

          # IO.puts("[undo_move do_it] captured piece. m:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(move)} mat_val=#{pos.materials_value} cap_val:#{captured_material_value}")
          %{
            pos
            | hand_pieces: %{pos.hand_pieces | hand_pc => num},
              materials_value: pos.materials_value - captured_material_value
          }
        else
          pos
        end

      # ## 雑談
      #
      # TODO 成った駒を戻すと、駒得評価値が動く
      #

      #
      # 動かしたあとの駒
      # ==============
      #
      piece_after_play = pos.board[move.destination]

      #
      # 動かす前の駒
      # ==========
      #
      {piece_before_play, new_materials_value} =
        if move.promote? do
          # （成った駒は）成らずに戻す
          piece_before_play = KifuwarabeWcsc33.CLI.Mappings.ToPiece.demote(piece_after_play)

          # ## 雑談
          #
          # 駒が成ったのを戻すと、駒得評価値が動く
          #
          # - 成った駒を成らずに戻しても「駒損」ではないが、評価値として減算するのは、よくある
          #
          materials_value_difference =
            KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.get_value_by_piece_type(
              KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece_after_play)
            ) -
              KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc.get_value_by_piece_type(
                KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece_before_play)
              )

          new_materials_value = pos.materials_value - materials_value_difference

          # IO.puts("[undo_move do_it] demotion. move:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(move)} pos.materials_value=#{pos.materials_value} new_materials_value:#{new_materials_value}")

          {piece_before_play, new_materials_value}
        else
          piece_before_play = pos.board[move.destination]
          {piece_before_play, pos.materials_value}
        end

      #
      # 局面更新
      #
      pos = %{
        pos
        | # 将棋盤更新
          board: %{
            pos.board
            | # 移動元マスは、動かす前の駒になる
              move.source => piece_before_play,

              # 移動先マスは、取った駒（なければ空マス）になる
              move.destination =>
                if captured_pt != nil do
                  # 取った駒種類に先後を付ける
                  KifuwarabeWcsc33.CLI.Mappings.ToPiece.from_turn_and_piece_type(
                    pos.opponent_turn,
                    captured_pt
                  )
                else
                  :sp
                end
          },
          materials_value: new_materials_value
      }

      # 局面更新
      pos =
        if piece_before_play == :k1 or piece_before_play == :k2 do
          # 玉のいるマスを（移動元マスへ）更新
          %{pos | location_of_kings: %{pos.location_of_kings | piece_before_play => move.source}}
        else
          pos
        end

      pos
    end
  end
end
