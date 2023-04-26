defmodule KifuwarabeWcsc33.CLI.Coding.ListPopLast do
  @moduledoc """
  
    リストの最後の要素を取得、かつリストから削除する
  
    References:
    📖 [Elixirで速度を追い求めるときのプログラミングスタイル](https://qiita.com/zacky1972/items/5963a8bf5f2a34c67d88)
  
  """

  @doc """
  
  ## Parameters
  
    * `list` - リスト（List；一覧）
  
  ## Returns
  
    0. リスト（List；一覧）
    1. ラスト（Last；最後） - の、要素
  
  """
  def do_it(list) do
    # |> 逆順にする
    list = list |> Enum.reverse()

    # 最後の要素
    last_element = hd(list)

    # |> ２つ目以降の要素のリストを取る
    # |> また逆順にする
    list =
      list
      |> tl()
      |> Enum.reverse()

    {list, last_element}
  end
end
