defmodule KifuwarabeWcsc33.CLI.Mappings.ToSquares do
    @doc """
      81マス
    """
    def on_board(top_rank \\ 1, bottom_rank \\ 9) do
        # コンプリヘンション（Comprehension；内包表記）で、マス番号を作成
        for file <- 1..9, rank <- top_rank..bottom_rank, do: 10*file+rank
    end
end
