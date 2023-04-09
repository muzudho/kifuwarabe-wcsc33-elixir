defmodule KifuwarabeWcsc33.CLI do
  # このメソッドは、コンソール・アプリケーションのエントリー・ポイントではなく、
  # 本来はスーパーバイザーの開始を書くメソッドだが、Elixirのスーパーバイザーが気に入らないので書かない。
  def start(_type, _args) do
    # Elixirのロガーが気に入らないので、正常時には出ないようにする
    Logger.configure(level: :error)

    IO.puts("Hi! I am a Kifuwarabe. It's start!")

    # 本来は、スーパーバイザーのPIDを返却する
    {:ok, self()}
  end
end
