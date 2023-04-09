defmodule KifuwarabeWcsc33.CLI do
  # コンソール・アプリケーションのエントリー・ポイント
  def start(_type, _args) do
    # Elixirのロガーが気に入らないので、正常時には出ないようにする
    Logger.configure(level: :error)

    IO.puts("Hi! I am a Kifuwarabe. It's start!")

    # 何だかよく分からない
    {:ok, self()}
  end
end
