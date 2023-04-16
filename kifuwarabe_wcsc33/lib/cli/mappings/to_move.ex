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

    if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(dst_sq) do
      # 盤上なら

      # 移動先の駒の先後を調べる（なければニル）
      target_turn_or_nil = pos |> KifuwarabeWcsc33.CLI.Mappings.ToPieceType.get_it_or_nil_from_destination(dst_sq)

      if target_turn_or_nil == pos.turn do
        # 自駒とぶつかるなら
        nil
      else
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
    * `step` - ステップ（Step；何回目）。1～8。繰り返し回数
    * `move_list` - ムーブ・リスト（Move List；指し手のリスト）

  ## Returns

    0. ムーブ・リスト（Move List；指し手のリスト）

  """
  def list_from(src_sq, pos, direction_of, step \\ 1, move_list \\ []) do
    # - 盤を8マス以上まっすぐ進むと盤外に飛び出るので、おわり
    if 8<step do
      move_list
    else
      dst_sq = KifuwarabeWcsc33.CLI.Mappings.ToDestination.from_turn_and_source(pos.turn, src_sq, direction_of)

      if KifuwarabeWcsc33.CLI.Thesis.Board.in_board(dst_sq) do
        # 盤上なら

        # 移動先の駒の先後を調べる（なければニル）
        target_turn_or_nil = pos |> KifuwarabeWcsc33.CLI.Mappings.ToPieceType.get_it_or_nil_from_destination(dst_sq)

        if target_turn_or_nil == nil || target_turn_or_nil != pos.turn do
          # 空マス、または、相手駒にぶつかったら、指し手は生成する
          move = KifuwarabeWcsc33.CLI.Models.Move.new()
          move = %{ move | source: src_sq, destination: dst_sq}

          move_list = move_list ++ [move]
          # IO.inspect(move_list, label: "[to_destination move_list_from] move_list")

          if target_turn_or_nil == nil do
            # 空マスなら、まだ指し手を増やす
            list_from(src_sq, pos, direction_of, step+1, move_list)
          else
            # 相手駒にぶつかったら、指し手は増やさない
            move_list
          end

        else
          # 自駒にぶつかったら、指し手は増やさない
          move_list
        end
      else
        # 盤外なら
        move_list
      end

    end
  end

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.PieceDirection)
  end
end
