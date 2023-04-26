# References

## Elixir & VSCode

📖 [VSCodeで最強のElixir開発環境を構築する](https://qiita.com/y_tochukaso/items/c909bac9411a4b4c5a16)  

## Struct

📖 [Elixirの虜になったPythonプログラマが、6か月後にたどり着いた、Classを使わないプログラム](https://qiita.com/GeekMasahiro/items/e1354b9920760c49e679)  

## type

📖 [Types and their syntax](https://hexdocs.pm/elixir/typespecs.html#types-and-their-syntax)  

## flow

📖 [Elixir Flowでlazyな並列分散処理](https://qiita.com/shufo/items/59d1c3b0baac6751777f)  
📖 [hex flow](https://hex.pm/packages/flow)  

👇 📄 `kifuwarabe_wcsc33/mix.exs`:  

```elixir
  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # ...
      {:flow, "~> 1.2"}
    ]
  end
```

```shell
mix deps.get
```

Hex のインストールを尋ねられたら、インストールする  
