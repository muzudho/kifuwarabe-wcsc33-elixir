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

    #
    # 探索
    # ====
    #
    # - depth=1 は Ok。すいすい指す
    # - depth=2 で待ち時間が生じる。序盤で１手 1～16秒（持ち駒を持っていると、とたんに遅くなる）
    #
    # depth = 1
    depth = 2
    {pos, best_move, value} = KifuwarabeWcsc33.CLI.Search.Alpha.do_it(pos, depth)

    IO.puts("[Go do_it] value:#{value}")

    best_move =
      if best_move == nil do
        # 合法手が無ければ投了
        KifuwarabeWcsc33.CLI.Models.Move.new()
      else
        best_move
      end

    {pos, best_move}
  end
end
