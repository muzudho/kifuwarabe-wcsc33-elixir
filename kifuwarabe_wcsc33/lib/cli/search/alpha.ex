defmodule KifuwarabeWcsc33.CLI.Search.Alpha do
  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    o. ベスト・ムーブ（Best Move；指し手） - 無ければニル

  """
  def do_it(pos, depth) do
    # IO.puts("[think go] pos.turn:#{pos.turn}")

    #
    # メーク・ムーブ
    # ============
    #
    # - とりあえず、現局面で指せる手（合法手）を全部列挙しようぜ
    #
    move_list = KifuwarabeWcsc33.CLI.MoveGeneration.MakeList.do_it(pos)
    # IO.inspect(move_list, label: "[Think go] raw move_list")
    # Enum.map(move_list, fn(move) ->
    #     move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
    #     IO.puts("[Think go] move list: (#{move_code})")
    #   end)

    #
    # 以下、分かりやすい弱い手を除去していく
    # ================================
    #
    # - ポジション（Position；局面）データはサイズが大きいので、複製せず、差分更新したい
    #

    # 自殺手の除去
    {move_list, pos} = KifuwarabeWcsc33.CLI.MoveList.ReduceSuicideMove.do_it(move_list, pos)

    #
    # 指し手一覧
    # =========
    #

    # IO.puts("[Think go] BELOW, MOVE LIST")
    # move_list |> Enum.map(fn(move) ->
    #     move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
    #     IO.puts("[Think go] move list: (#{move_code})")
    #   end)

    # TODO シャッフルする
    # move_list = move_list |> Enum.shuffle()

    # IO.puts(
    #   """
    #   [think go] Current position.
    #
    #   """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

    # 最善手を選ぶ（投了ならニル）
    {pos, best_move, value} = choice_best(pos, move_list, nil, -32768, depth)

    {pos, best_move, value}
  end

  #
  # 関数シグニチャーのパターンマッチの定義
  #
  defp choice_best(pos, move_list \\ [], sibling_best_move, sibling_best_value, depth)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  defp choice_best(pos, [], sibling_best_move, sibling_best_value, _depth) do
    # 再帰の帰り道
    {pos, sibling_best_move, sibling_best_value}
  end

  # 最善手を返す
  #
  # - 候補手は再帰的に減らしていく
  #
  # ## Parameters
  #
  # * `pos` - ポジション（Position；局面）
  # * `[move | move_list]` - リストの先頭要素を、ムーブ（Move；指し手）、残りの要素を ムーブ・リスト（Move List；指し手のリスト）とする書き方。レデュース（Reduce；減らす）という技法
  # * `sibling_best_move` - シブリング・ベスト・ムーブ（Sibling Best Move；兄弟局面の中での最善手）
  # * `sibling_best_value` - シブリング・ベスト・バリュー（Sibling Best Value；兄弟局面の中での最高点）
  #
  # ## Returns
  #
  # 0. ポジション（Position；局面）
  # 1. ムーブ・リスト（Move List；指し手のリスト） - 投了は含まない
  # 2. ベスト・ムーブ（Best Move；最善手） - 無ければニル
  #
  defp choice_best(pos, [move | move_list], sibling_best_move, sibling_best_value, depth) do

    if move == nil do
      #
      # Base case
      # =========
      #
      # - 指し手が無ければ停止
      #
      # IO.puts("[Alpha choice_best] move is nil. stop")

      # 再帰の帰り道
      {pos, sibling_best_move, sibling_best_value}
    else

      #
      # とりあえず、１手指してみる
      # ======================
      #
      # - 手番がひっくり返ることに注意
      #
      # move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
      # IO.puts("[Alpha choice_best] move:#{move_code} pre_value:#{pos.materials_value}")

      pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.DoMove.do_it(move)

      {pos, value} =
        if depth < 1 do
          #
          # 候補手を指した後の局面に、バリュー（Value；局面評価値）を付ける
          # =======================================================
          #
          #   - 相手から見た局面になっているので、相手から見た局面評価を行い、その正負を逆転（負数にする）すれば、自分から見た局面になる
          #
          # ## 雑談
          #
          #   - 古典的には、歩１個の価値を 100 とする。これを 1 センチポーン（centipawn；一厘歩） と言う。
          #     この尺度を使う場合、整数を使う（実数を使わない）
          #
          value = - lets_position_value(pos)
          # IO.puts("[Alpha choice_best] value:#{value}")
          {pos, value}
        else
          #
          # TODO ２手目を読みたい
          # ===================
          #
          # - 何手目で打ち止めにするか決めないと、帰ってこれない。 depth を 1 減らす
          # - この pos は、結局、現在の pos と同じはずだが
          # - この best_move （ベスト・ムーブ）は、相手の次の手
          # - この value （評価値）は、葉局面から帰ってくる
          #
          {pos, _best_move, value} = do_it(pos, depth - 1)

          {pos, value}
        end

      #
      # 忘れずに、１手戻す
      # ===============
      #
      # - 手番がひっくり返ることに注意
      #
      pos = pos |> KifuwarabeWcsc33.CLI.MoveGeneration.UndoMove.do_it()

      #
      # アルファー・アップデート
      # =====================
      #
      #   兄弟局面の中の最高局面評価値を更新したなら、最善手を更新する
      #
      # ## 雑談
      #
      #   アルファー（α；甲）は、わたしの番という意味。ベーター（β；乙）は、あなたの番という意味
      #
      {sibling_best_move, sibling_best_value} =
        if sibling_best_value < value do
          {move, value}
        else
          {sibling_best_move, sibling_best_value}
        end

      if move_list |> length() < 1 do
        #
        # Base case
        # =========
        #
        # - 合法手が残ってなければ停止
        #
        # IO.puts("[Alpha choice_best] empty move list. stop")

        # 再帰の帰り道
        {pos, sibling_best_move, sibling_best_value}
      else
        #
        # Recursive
        # =========
        #
        choice_best(pos, move_list, sibling_best_move, sibling_best_value, depth)
      end
    end
  end

  #
  # 局面評価値（相手から見た評価値）を返す
  #
  defp lets_position_value(pos) do
    pos.materials_value
  end
end
