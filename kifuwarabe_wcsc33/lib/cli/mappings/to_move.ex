defmodule KifuwarabeWcsc33.CLI.Models.ToMove do
  # マップ定数の定義
  @relative_offset %{
    north_of: -10,
    north_east_of: -9,
    east_of: 1,
    south_east_of: 11,
    south_of: 10,
    south_west_of: 9,
    west_of: -1,
    north_west_of: -11,
    # 先手桂馬
    north_north_east_of: -19,
    north_north_west_of: -21,
  }

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
    relative = @relative_offset[direction_of]
    dst_sq =
      case pos.turn do
        :sente -> src_sq + relative
        :gote -> src_sq - relative
      end

    if KifuwarabeWcsc33.CLI.Models.ToBoardInfo.in_board(dst_sq) do
      # 盤上なら
      # ターゲット・ピース（Target Piece；移動先の駒）を調べる
      # IO.puts("[to_destination move_list_from] in_board src_sq:#{src_sq} dst_sq:#{dst_sq} direction_of:#{direction_of} step:#{step} relative:#{relative} pos.turn:#{pos.turn}")
      target_pc = pos.board[dst_sq]

      target_turn_or_nil =
        cond do
          target_pc == :sp ->
            nil

          true ->
            KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
        end

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
      relative = @relative_offset[direction_of]
      dst_sq =
        case pos.turn do
          :sente -> src_sq + step * relative
          :gote -> src_sq - step * relative
        end

      if KifuwarabeWcsc33.CLI.Models.ToBoardInfo.in_board(dst_sq) do
        # 盤上なら
        # ターゲット・ピース（Target Piece；移動先の駒）を調べる
        # IO.puts("[to_destination move_list_from] in_board src_sq:#{src_sq} dst_sq:#{dst_sq} direction_of:#{direction_of} step:#{step} relative:#{relative} pos.turn:#{pos.turn}")
        target_pc = pos.board[dst_sq]

        target_turn_or_nil =
          cond do
            target_pc == :sp ->
              nil

            true ->
              KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(target_pc)
          end

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
