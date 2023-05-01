defmodule KifuwarabeWcsc33.CLI.USI.Go do
  @moduledoc """
    思考部
  """

  @doc """
    思考開始

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. ベスト・ムーブ（Best move；最善手）

  """
  def do_it(pos) do
    # 盤表示
    IO.puts(
      """
      [Go do_it] value:#{pos.materials_value}

      """ <> KifuwarabeWcsc33.CLI.Views.Position.stringify(pos)
    )

    divided = 10
    remain = rem(pos.moves_num, divided)
    if remain == 5 or remain == 6 do
      #
      # GPUへアクセス
      # ============
      #
      # TODO 消す
      #
      # - ネタ勢
      # - きふわらべがGPUへアクセスしているという実績（キャラクター付け）を付けるために、GPUへアクセスするだけ
      # - 計算結果は使ってない
      # - 計算時間は一瞬。思っているより遅くない
      # - エラーが出て止まるリスクもある
      #
      KifuwarabeWcsc33.CLI.CallPython.HelloGpu.hello_gpu()
    end

    #
    # 探索
    # ====
    #
    depth = KifuwarabeWcsc33.CLI.Config.depth()
    {pos, best_move, value, nodes_num_searched} = KifuwarabeWcsc33.CLI.Search.Alpha.do_it(pos, depth)

    # IO.puts("[Go do_it] value:#{value}")

    best_move =
      if best_move == nil do
        # 合法手が無ければ投了
        KifuwarabeWcsc33.CLI.Models.Move.new()
      else
        best_move
      end

    {pos, best_move, value, nodes_num_searched}
  end
end
