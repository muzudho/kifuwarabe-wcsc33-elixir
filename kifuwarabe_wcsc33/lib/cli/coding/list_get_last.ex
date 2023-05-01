defmodule KifuwarabeWcsc33.CLI.Coding.ListGetLast do
  @moduledoc """

    リストの最後の要素を取得

    References:
    📖 [Elixirで速度を追い求めるときのプログラミングスタイル](https://qiita.com/zacky1972/items/5963a8bf5f2a34c67d88)

  """

  @doc """

  ## Parameters

    * `list` - リスト（List；一覧）

  ## Returns

    o. ラスト（Last；最後） - の、要素

  """
  def do_it(list) do
    # |> 逆順にする
    # |> 最後の要素
    list |> Enum.reverse() |> hd()
  end
end
