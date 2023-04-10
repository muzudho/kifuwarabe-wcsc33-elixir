defmodule KifuwarabeWcsc33.CLI.Helpers.PositionParser do
  @doc """
  
    解析
  
  ## 引数
  
    * `line` - 一行の文字列。例参考
  
  ## 例
  
    position startpos moves 7g7f 3c3d 2g2f
    position sfen lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL w - 1 moves 5a6b 7g7f 3a3b
  
  """
  def parse(line) do
    IO.puts("parse-1 line:#{line}")

    rest =
      if String.starts_with?(line, "position startpos") do
        # `position startpos` で始まる |> 続くスペースを削除
        String.slice(line, String.length("position startpos")..-1) |> String.trim_leading()
      else
        line
      end

    IO.puts("parse-2 rest:#{rest}")
  end
end
