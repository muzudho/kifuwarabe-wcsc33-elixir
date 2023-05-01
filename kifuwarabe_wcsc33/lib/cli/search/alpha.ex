defmodule KifuwarabeWcsc33.CLI.Search.Alpha do
  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    o. ベスト・ムーブ（Best Move；指し手） - 無ければニル

  """
  def do_it(pos, depth, nodes_num_searched \\ 0) do
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
    # デバッグ：指し手一覧表示
    # =====================
    #
    KifuwarabeWcsc33.CLI.Debug.MoveGenList.print(move_list)

    #
    # デバッグ：指し手のシャッフル
    # ========================
    #
    #   - 同じ手ばかり指していては、他の手のチェックができないので
    #
    move_list =
      if KifuwarabeWcsc33.CLI.Config.is_debug_utifudume_check?() do
        # シャッフル
        move_list |> Enum.shuffle()
      else
        move_list
      end

    # IO.puts(
    #   """
    #   [think go] Current position.
    #
    #   """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos))

    # 最善手を選ぶ（投了ならニル）
    {pos, best_move, value, nodes_num_searched} = choice_best(pos, move_list, nil, -32768, depth, nodes_num_searched)

    {pos, best_move, value, nodes_num_searched}
  end

  #
  # 関数シグニチャーのパターンマッチの定義
  #
  defp choice_best(pos, move_list, sibling_best_move, sibling_best_value, depth, nodes_num_searched)

  #
  # ベース・ケース（Base case；基本形） - 再帰関数の繰り返し回数が０回のときの処理
  #
  # - 同局面の最後の兄弟がいなくなったとき
  # - 葉局面ではない
  #
  defp choice_best(pos, [], sibling_best_move, sibling_best_value, _depth, nodes_num_searched) do
    # 再帰の帰り道
    {pos, sibling_best_move, sibling_best_value, nodes_num_searched}
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
  defp choice_best(pos, [move | move_list], sibling_best_move, sibling_best_value, depth, nodes_num_searched) do
    #
    # とりあえず、１手指してみる
    # ======================
    #
    # - 手番がひっくり返ることに注意
    #
    # move_code = KifuwarabeWcsc33.CLI.Views.Move.as_code(move)
    # IO.puts("[Alpha choice_best] move:#{move_code} pre_value:#{pos.materials_value}")

    pos = pos |> KifuwarabeWcsc33.CLI.MoveOperation.DoMove.do_it(move)

    #
    # - 探索ノード数（訪問ノード数ではない）を１増やす
    # - 単純に、Do move したら１増やす
    #
    nodes_num_searched = nodes_num_searched + 1

    {pos, opponent_value, nodes_num_searched} =
      if depth < 1 do
        #
        #
        # TODO 葉ノードでの局面評価（したいなあ）
        # ====================================
        #

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
        opponent_value = lets_position_value(pos)

        # IO.puts("[Alpha choice_best] value:#{value}")
        {pos, opponent_value, nodes_num_searched}
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
        {pos, _best_move, opponent_value, nodes_num_searched} = do_it(pos, depth - 1, nodes_num_searched)

        {pos, opponent_value, nodes_num_searched}
      end

    #
    # 局面評価値の反転
    # ===============
    #
    # - 相手の評価値が返ってきた
    # - 相手番局面の高評価は、自分にとって低評価。正負を逆転する
    #
    value = -opponent_value

    #
    # アルファー・アップデート
    # ======================
    #
    # - アルファー（α；甲）は、自分（手番）の局面の評価値
    # - 相手番局面の評価が低ければ、手番局面の評価は高くなる
    # - 手番局面の評価（アルファー）が、いままでの兄弟局面より良ければ、記憶を更新（アップデート）する
    #
    # ## 雑談
    #
    #   アルファー（α；甲）は、バリュー（Value；わたしの番の評価値）、
    #   ベーター（β；乙）は、オポネント・バリュー（Opponent Value；あなたの番の評価値）を指すのに使う。
    #   再帰の１回目（奇数回目）がアルファー、２回目（偶数回目）がベーターになる。
    #   だから、選んだアルゴリズムや、コーディングの仕方によっては、アルファーとベーターの違いは無くなる
    #
    {sibling_best_move, sibling_best_value} =
      if is_alpha_update?(value, sibling_best_value) do
        #
        # (__UchifuDumeCheck__) 採用する前に、打ち歩詰めチェックする
        # =======================================================
        #
        #   - もし、歩を打ったときで、かつ、そこが相手の玉頭なら、打ち歩詰めチェックをしたい
        #   - チェックする度に余分に思考時間が減るので、避けたい。そこでアルファー・アップデートのとき（手の採用に一考されるとき）にチェックする
        #
        is_uchifu_dume? = KifuwarabeWcsc33.CLI.Thesis.IsUchifuDume.is_uchifu_dume?(move, pos)

        if is_uchifu_dume? do
          # アルファー・アップデートを却下する
          {sibling_best_move, sibling_best_value}
        else
          # アルファー・アップデートする
          {move, value}
        end
      else
        # アルファー・アップデート対象外
        {sibling_best_move, sibling_best_value}
      end

    #
    # 忘れずに、１手戻す
    # ===============
    #
    # - 手番がひっくり返ることに注意
    #
    pos = pos |> KifuwarabeWcsc33.CLI.MoveOperation.UndoMove.do_it()

    if move_list |> length() < 1 do
      #
      # Base case
      # =========
      #
      # - 合法手が残ってなければ停止
      #
      # IO.puts("[Alpha choice_best] empty move list. stop")

      # 再帰の帰り道
      {pos, sibling_best_move, sibling_best_value, nodes_num_searched}
    else
      #
      # Recursive
      # =========
      #
      choice_best(pos, move_list, sibling_best_move, sibling_best_value, depth, nodes_num_searched)
    end
  end

  #
  # アルファー・アップデートが起こるか確認
  # ===================================
  #
  defp is_alpha_update?(value, sibling_best_value) do
    sibling_best_value < value
  end

  #
  # 局面評価値（相手から見た評価値）を返す
  #
  defp lets_position_value(pos) do
    pos.materials_value
  end
end
