defmodule KifuwarabeWcsc33.CLI.Mappings.ToMove do
  @doc """

    移動元マス番地と、先後から、指定方向の移動先マス番地を取得

  ## Parameters

    * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
    * `pos` - ポジション（Position；局面）
    * `direction_of` - ディレクション・オブ（Direction of；向き）
  
  ## Returns
  
    0. ムーブ（Move；指し手）

  """
  def from(src_sq, pos, direction_of) do
    dst_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

    if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(dst_sq) do
      # 盤上なら

      # 移動先の駒の先後を調べる（なければニル）
      target_turn_or_nil = pos |> KifuwarabeWcsc33.CLI.Mappings.ToPieceType.get_it_or_nil_from_destination(dst_sq)

      if target_turn_or_nil == pos.turn do
        # 自駒とぶつかるなら
        nil
      else
        # 進める
        move = KifuwarabeWcsc33.CLI.Models.Move.new()
        move = %{ move | source: src_sq, destination: dst_sq}
        move
      end
    else
      # 盤外なら
      nil
    end
  end

  @doc """

    移動元マス番地と、先後から、指定方向の移動先マス番地を取得

  ## Parameters

    * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
    * `pos` - ポジション（Position；局面）
    * `direction_of` - ディレクション・オブ（Direction of；向き）
    * `origin_src_sq` - （再帰をするときの）１番最初の移動元マス
    * `move_list` - ムーブ・リスト（Move List；指し手のリスト）

  ## Returns

    0. ムーブ・リスト（Move List；指し手のリスト）

  """
  def list_from(src_sq, pos, direction_of, origin_src_sq \\ nil, move_list \\ []) do
    # 盤外に出ると終わる
    dst_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

    if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_board?(dst_sq) do
      # 盤上なら

      # 移動先の駒の先後を調べる（なければニル）
      target_turn_or_nil = pos |> KifuwarabeWcsc33.CLI.Mappings.ToPieceType.get_it_or_nil_from_destination(dst_sq)

      if target_turn_or_nil == nil || target_turn_or_nil != pos.turn do
        # 空マス、または、相手駒にぶつかったら、指し手は生成する

        origin_src_sq = if origin_src_sq != nil do
            origin_src_sq
          else
            src_sq
          end

        move = KifuwarabeWcsc33.CLI.Models.Move.new()
        move = %{ move |
          source: origin_src_sq,
          destination: dst_sq
        }

        move_list = move_list ++ [move]
        # IO.inspect(move_list, label: "[to_destination move_list_from] move_list")

        if target_turn_or_nil == nil do
          # 移動先が空マスなら、移動先から続けて指し手を増やす
          list_from(dst_sq, pos, direction_of, origin_src_sq, move_list)
        else
          # 相手駒にぶつかったら、指し手は増やさない
          move_list
        end

      else
        # 自駒にぶつかったら、指し手は増やさない
        move_list
      end
    else
      # 盤外に出た（単調に進むから、いつか必ず盤外に出るから、再帰は必ず終わる）
      move_list
    end
  end

  @doc """

    コードから、ムーブ・オブジェクトを生成

  ## Parameters

    * `rest` - レスト（Rest；残り）の、文字列

  ## Returns

    0. レスト（Rest；残り） - の、文字列
    1. ムーブ（Move；指し手）

  """
  def from_code_line(rest) do
    IO.puts("[to_move from_code_line] rest:[#{rest}]")

    move = KifuwarabeWcsc33.CLI.Models.Move.new()

    # 移動元
    # =====
    #
    # * 最初の２文字は、「打った駒の種類」か、「移動元マス」
    #

    # １文字目は、「大文字英字」か、「筋の数字」
    # 先頭の１文字切り出し
    first_char = rest |> String.at(0)
    # IO.puts("parse_moves_string_and_update_position first_char:[#{first_char}]")
    rest = rest |> String.slice(1..-1)

    {rest, move} =
      cond do
        # 数字が出てきたら -> 「ファイル（File；筋）の数字」
        Regex.match?(~r/^\d$/, first_char) ->
          file = String.to_integer(first_char)

          # 「ランク（Rank；段）の小文字アルファベット」
          # 先頭の１文字切り出し
          second_char = rest |> String.at(0)
          # IO.puts("parse_moves_string_and_update_position second_char:[#{second_char}]")
          rest = rest |> String.slice(1..-1)

          rank =
            case second_char do
              "a" -> 1
              "b" -> 2
              "c" -> 3
              "d" -> 4
              "e" -> 5
              "f" -> 6
              "g" -> 7
              "h" -> 8
              "i" -> 9
            end

          move = %{move | source: 10 * file + rank}
          # IO.inspect(move, label: "parse(12) The move is")

          {rest, move}

        # それ以外は「打つ駒」
        true ->
          # 1文字目が駒だったら打
          move =
            case first_char do
              "R" -> %{move | drop_piece_type: :r}
              "B" -> %{move | drop_piece_type: :b}
              "G" -> %{move | drop_piece_type: :g}
              "S" -> %{move | drop_piece_type: :s}
              "N" -> %{move | drop_piece_type: :n}
              "L" -> %{move | drop_piece_type: :l}
              "P" -> %{move | drop_piece_type: :p}
              _ -> raise "unexpected first_char:#{first_char}"
            end

          # 2文字目は必ず「*」なはずなので読み飛ばす。
          second_char = rest |> String.at(0)

          if second_char != "*" do
            raise "unexpected second_char:#{second_char}"
          end

          # IO.puts("parse_piece_type_on_hands first_char:[#{first_char}]")
          rest = rest |> String.slice(1..-1)

          # IO.inspect(move, label: "parse(12) The move is")
          # IO.puts("parse_moves_string_and_update_position rest:[#{rest}]")

          {rest, move}
      end

    # 移動先
    # =====
    #
    # * ３文字目は「ファイル（File；筋）の数字」
    # * ４文字目は「ランク（Rank；段）のアルファベット」
    #

    # 先頭の１文字切り出し
    third_char = rest |> String.at(0)
    # IO.puts("parse_moves_string_and_update_position third_char:[#{third_char}]")
    rest = rest |> String.slice(1..-1)

    # きっと数字だろ
    file = String.to_integer(third_char)

    # 先頭の１文字切り出し
    fourth_char = rest |> String.at(0)
    # IO.puts("parse_moves_string_and_update_position fourth_char:[#{fourth_char}]")
    rest = rest |> String.slice(1..-1)

    # きっと英数字小文字だろ
    rank =
      case fourth_char do
        "a" -> 1
        "b" -> 2
        "c" -> 3
        "d" -> 4
        "e" -> 5
        "f" -> 6
        "g" -> 7
        "h" -> 8
        "i" -> 9
      end

    move = %{move | destination: 10 * file + rank}
    # IO.inspect(move, label: "parse(13) The move is")

    # 成り
    # ====
    #
    # * ５文字目に + があれば「プロモート（Promote；成り）
    #

    {rest, move} =
      if rest |> String.at(0) == "+" do
        # 先頭の１文字切り出し
        rest = rest |> String.slice(1..-1)
        move = %{move | promote?: true}

        {rest, move}
      else
        {rest, move}
      end

    {rest, move}
  end

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.PieceDirection)
  end
end
