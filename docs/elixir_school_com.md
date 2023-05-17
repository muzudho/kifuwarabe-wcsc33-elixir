# elixirschool.com

📖 [実行ファイル](https://elixirschool.com/ja/lessons/intermediate/escripts)  
📖 [Windowsでescriptするときにちょっぴり幸せになれる Tips](https://qiita.com/ShozF/items/14a8df28fedde9043750)  

```elixir
  def project do
    [
      app: :kifuwarabe_wcsc33,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # For ".exe" file build
      escript: escript()
    ]
  end

  # For ".exe" file build
  defp escript do
    [main_module: KifuwarabeWcsc33.CLI]

    # app_name = "kifuwarabe_wcsc33"
    #
    # [
    #   main_module: KifuwarabeWcsc33.CLI,
    #   shebang: "#! escript \"%~f0\"\n",
    #   path: "#{app_name}.bat"
    # ]
  end
```

🏠📖 [トップページへ戻る](../README.md)  
