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
        # TODO 平手初期局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        String.slice(line, String.length("position startpos")..-1) |> String.trim_leading()
      else
        # pass
        line
      end

    IO.puts("parse-2 rest:#{rest}")

    rest =
      if String.starts_with?(rest, "position sfen") do
        # TODO 途中局面をセット

        # `position startpos` を除去 |> あれば、続くスペースを削除
        rest = String.slice(line, String.length("position sfen")..-1) |> String.trim_leading()

        IO.puts("parse-3 rest:#{rest}")

        # TODO 盤面部分を解析
        parse_board(rest)
      else
        # pass
        rest
      end

    IO.puts("parse-4 rest:#{rest}")
  end

  # 盤面部分を解析
  #
  # ## 例
  #
  # lnsgkgsnl/9/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL
  #
  # ## 雑談
  #
  # デービッド・フォーサイスさんの発案したチェスの盤面の記録方法（１行ごとに縦線 | で区切る）を、
  # スティーブン・J・エドワーズさんがコンピューター・チェスのメーリングリストで１０年がかりで意見を取り入れてコンピューター向けに仕様を決めたもの
  defp parse_board(rest) do
    # こうやって、１文字ずつ取っていけるけど……
    rest = parse_piece_on_board(rest)
    rest = parse_piece_on_board(rest)

    rest
  end

  # 盤面部分の駒を解析
  defp parse_piece_on_board(rest) do
    # こうやって、１文字ずつ取っていけるけど……
    char = rest |> String.at(0)
    IO.puts("parse_board char:#{char}")

    rest |> String.slice(1..-1)
  end
end
