defmodule KifuwarabeWcsc33.CLI.Routes.Think do
  @moduledoc """
    思考部
  """

  @doc """
    思考開始

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. ベストムーブ（Best move；最善手）

  """
  def go(pos) do

    # IO.puts("[think go] pos.turn:#{pos.turn}")

    # とりあえず、現局面で指せる手（合法手）を全部列挙しようぜ
    move_list = KifuwarabeWcsc33.CLI.Routes.MoveGeneration.make_move_list(pos)
    # IO.inspect(move_list, label: "[Think go] raw move_list")
    Enum.map(move_list, fn(move) ->
        move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
        IO.puts("[Think go] move list: (#{move_code})")
      end)

    # シャッフルする
    move_list = move_list |> Enum.shuffle()

    # TODO 相手玉の場所
    #
    # - 打ち歩詰めチェックに使う
    # opponent_king_sq = KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos, pos.opponent_turn)

    # IO.puts(
    #   """
    #   [think go] Current position.
    #
    #   """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

    # 最善手を選ぶ（投了でなければ、詰んでいないということ）
    {_pos, _move_list, best_move} = pos |> choice(move_list)

    # TODO もし、歩を打ったときで、かつ、そこが相手の玉頭なら、打ち歩詰めチェックをしたい
    if best_move.drop_piece_type == :p do
      IO.puts("[Think go] TODO Uchifudume check")
    end

    # IO.puts("[Think go] best_move:#{KifuwarabeWcsc33.CLI.Views.Move.as_code(best_move)}")
    best_move
  end

  # 最善手（その手を指すと詰む手以外）を選ぶ。無ければ投了を返す
  #
  # - 候補手は１つずつ減らしていく
  #
  # ## Parameters
  #
  # * `pos` - ポジション（Position；局面）
  # * `move_list` - ムーブ・リスト（Move List；指し手のリスト）
  #
  # ## Returns
  #
  # 0. ポジション（Position；局面）
  # 1. ムーブ・リスト（Move List；指し手のリスト）
  # 2. ベスト・ムーブ（Best Move；最善手）
  #
  defp choice(pos, move_list) do

    {move_list, best_move} =
      if move_list |> length() < 1 do
        # 合法手が無ければ投了
        resign_move = KifuwarabeWcsc33.CLI.Models.Move.new()
        {move_list, resign_move}
      else
        # 合法手が１つ以上あれば、先頭の手を選ぶ。先頭の手は削除する
        best_move = hd(move_list)
        {move_list |> List.delete_at(0), best_move}
      end

    if best_move.destination == nil do
      # 投了なら、おわり
      {pos, move_list, best_move}

    else
      # とりあえず、指してみる
      best_move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(best_move)
      pos = pos |> KifuwarabeWcsc33.CLI.Routes.DoMove.do_it(best_move)
      # 手番がひっくり返ったことに注意
      #IO.puts(
      #  """
      #  [think choice] Done #{best_move_code}.
      #
      #  """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

      # 一手指したあとの、自玉の位置を検索（ここでは相手番なので、さっきの手番は逆側）
      king_sq = pos |> KifuwarabeWcsc33.CLI.Finder.Square.find_king_on_board(pos.opponent_turn)
      IO.puts("[think choice] king_sq:#{king_sq}")

      if king_sq != nil do

        # TODO 自分から相手の利きへ飛び込む手（自殺手）は除外したい
        # （ここでは相手番なので、さっきの手番は逆側）
        if pos |> KifuwarabeWcsc33.CLI.Thesis.IsMated.is_mated?(king_sq) do
          # 自殺手だ
          # 戻す
          pos = pos |> KifuwarabeWcsc33.CLI.Routes.UndoMove.do_it()
          # TODO 消す。盤表示
          #IO.puts(
          #  """
          #  [think choice] Undone #{best_move_code}. It is suicide move.
          #
          #  """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

          # Recursive
          # =========
          #
          # - ベストムーブか、投了のどちらかを取得するまで続ける
          pos |> choice(move_list)
        else
          IO.puts("[think choice] #{best_move_code} is no suicide move. Ok")
          {pos, move_list, best_move}
        end
      else
        {pos, move_list, best_move}
      end
    end
  end
end
