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
    #
    # 盤の符号 ９一、８一、７一 …と読んでいく。１九が最後。
    # 10ずつ減っていき、十の位が無くなったら一の位が増える。
    #
    # KifuwarabeWcsc33.CLI.Models.Sequence.get_address_list()
    # |> Enum.map(fn sq ->
    #  IO.puts("sq:#{sq}")
    # end)
    #
    # TODO こんなん毎回生成したくないぞ
    sequence = KifuwarabeWcsc33.CLI.Models.Sequence.new()

    show_sq = fn sq -> IO.puts("sq:#{sq}") end

    # sequence.address_list
    # |> Enum.map(fn sq ->
    #   IO.puts("sq:#{sq}")
    # end)
    sequence.address_list
    |> Enum.map(show_sq)

    # こうやって、１文字ずつ取っていけるけど……
    tuple = parse_piece(rest)
    rest = elem(tuple, 0)
    pc = elem(tuple, 1)
    IO.puts("pc:#{pc}")

    case pc do
      :none ->
        # 盤終了
        nil

      :sp ->
        # TODO 盤に連続する空きマスを置く
        nil

      _ ->
        # TODO 盤に駒を置く
        nil
    end

    rest
  end

  # 字を解析して、駒または :none を返す
  defp parse_piece(rest) do
    if rest |> String.length() < 1 do
      # base case

      # ループ終了
      {rest, :none, 0}
    else
      # recursive

      # こうやって、１文字ずつ取っていけるけど……
      char = rest |> String.at(0)
      IO.puts("parse_board char:#{char}")
      rest = rest |> String.slice(1..-1)

      cond do
        # 本将棋の盤上の１行では、連続するスペースの数は最大で１桁に収まる
        is_integer(char) ->
          # 空きマスが何個連続するかの数
          space_num = String.to_integer(char)
          {rest, :sp, space_num}

        # 成り駒
        char == "+" ->
          char = rest |> String.at(0)
          promoted_piece = KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(char)
          rest = rest |> String.slice(1..-1)
          {rest, promoted_piece, 1}

        # それ以外
        true ->
          piece = KifuwarabeWcsc33.CLI.Helpers.PieceParser.parse(char)
          # TODO 駒を置く
          {rest, piece, 1}
      end
    end
  end
end
