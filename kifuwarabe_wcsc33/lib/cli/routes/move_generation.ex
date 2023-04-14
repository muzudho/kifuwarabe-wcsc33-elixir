defmodule KifuwarabeWcsc33.CLI.Routes.MoveGeneration do
  @moduledoc """
    指し手生成
  """

  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  """
  def make_move_list(pos) do
    move_list = []

    # TODO 盤上の自分の駒と、持っている駒の数だけ、合法手が生成できる
    # |> スペース（:sp；空マス）は除去
    # |> マス番地と先後付きの駒種類から、指し手生成
    # |> 指し手が nil なら除去
    # |> リストがネストしていたら、フラットにする
    move_sub_list = pos.board
      |> Enum.filter(fn{_sq,piece} -> piece != :sp end)
      |> Enum.map(fn {sq,piece} -> pos|>make_move_list_by_piece(sq,piece) end)
      |> Enum.filter(& !is_nil(&1))
      |> List.flatten()

    move_list = move_list ++ move_sub_list

    # move_list = move_list ++ [KifuwarabeWcsc33.CLI.Models.Move.new()]

    move_list
  end

  # ## 引数
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `sq` - スクウェア（Square：マス番地）
  #   * `piece` - ピース（Piece；先後付きの駒種類）
  #
  defp make_move_list_by_piece(pos, sq, piece) do
    # IO.puts("pos.turn:#{pos.turn} sq:#{sq} piece:#{piece}")
    turn_of_piece = KifuwarabeWcsc33.CLI.Mediators.ToTurn.from_piece(piece)

    # 手番側の駒だけ見ろ
    if turn_of_piece == pos.turn do

      # IO.puts("pos.turn:#{pos.turn} sq:#{sq} piece:#{piece} turn_of_piece:#{turn_of_piece}")

      # TODO 駒の種類ごとに動きの方向が違う
      piece_type = KifuwarabeWcsc33.CLI.Mediators.ToPieceType.from_piece(piece)
      IO.puts("pos.turn:#{pos.turn} sq:#{sq} piece_type:#{piece_type}")

      case piece_type do
        # キング（King；玉）
        :k -> []
        # ルック（Rook；飛車）
        :r -> []
        # ビショップ（Bishop；角）
        :b -> []
        # ゴールド（Gold；金）
        :g -> []
        # シルバー（Silver；銀）
        :s -> []
        # ナイト（kNight；桂）
        :n -> []
        # ランス（Lance；香）
        :l -> []
        # ポーン（Pawn；歩）
        :p -> []
        # 玉は成れません
        # :pk1
        # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
        :pr -> []
        # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
        :pb -> []
        # 金は成れません
        # :pg1
        # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
        :ps -> []
        # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
        :pn -> []
        # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
        :pl -> []
        # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
        :pp -> []
        #
        # それ以外はエラー
        # ==============
        #
        _ -> raise "unexpected piece_type:#{piece_type}"
      end

    else
      # 対象外
      nil
    end
  end
end
