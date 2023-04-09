defmodule KifuwarabeWcsc33.CLI do
  # このメソッドは、コンソール・アプリケーションのエントリー・ポイントではなく、
  # 本来はスーパーバイザーの開始を書くメソッドだが、Elixirのスーパーバイザーが気に入らないので書かない。
  def start(_type, _args) do
    # Elixirのロガーが気に入らないので、正常時には出ないようにする
    Logger.configure(level: :error)

    # 標準入力を受け取る |> 末尾の改行を削除するために trim() を使う
    input = IO.gets("") |> String.trim()

    # Elixirに if～else-if～else 構造はない。 case文かcond文を使う
    cond do
      input == "usi" ->
        IO.puts("id name Kifuwarabe")
        IO.puts("id author TAKAHASHI satoshi")
        IO.puts("usiok")

      # Otherwise
      true ->
        IO.puts("Hi! I am a Kifuwarabe. It's start! " <> input)
    end

    # 本来は、スーパーバイザーのPIDを返却する
    {:ok, self()}
  end

  # Elixirに複数行コメントは無い。 関数の中では @doc、モジュールの中では @moduledoc を使う。マクロの中ではコメントは書けない
  @moduledoc """
  # if～else文の使い方
  if input = "usi" do
    IO.puts("id name Kifuwarabe")
    IO.puts("id author TAKAHASHI satoshi")
    IO.puts("usiok")
  else
    IO.puts("Hi! I am a Kifuwarabe. It's start! " <> input)
  end
  """
end
