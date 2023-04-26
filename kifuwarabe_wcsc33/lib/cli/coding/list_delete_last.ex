defmodule KifuwarabeWcsc33.CLI.Coding.ListDeleteLast do
  @moduledoc """
  
    リストの最後の要素を削除する
  
    References:
    📖 [Elixirで速度を追い求めるときのプログラミングスタイル](https://qiita.com/zacky1972/items/5963a8bf5f2a34c67d88)
  
  """

  @doc """
  
  ## Parameters
  
    * `list` - リスト（List；一覧）
  
  ## Returns
  
    0. リスト（List；一覧）
  
  """
  def do_it(list) do
    # |> 逆順にする
    # |> ２つ目以降の要素のリストを取る
    # |> また逆順にする
    list
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
  end
end
