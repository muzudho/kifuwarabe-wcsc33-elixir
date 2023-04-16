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

  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #   * `piece` - ピース（Piece；先後付きの駒種類）
  #
  defp make_move_list_by_piece(pos, src_sq, piece) do
    # IO.puts("pos.turn:#{pos.turn} sq:#{sq} piece:#{piece}")
    turn_of_piece = KifuwarabeWcsc33.CLI.Mediators.ToTurn.from_piece(piece)

    # 手番側の駒だけ見ろ
    if turn_of_piece == pos.turn do

      # IO.puts("pos.turn:#{pos.turn} sq:#{sq} piece:#{piece} turn_of_piece:#{turn_of_piece}")

      # TODO 駒の種類ごとに動きの方向が違う
      piece_type = KifuwarabeWcsc33.CLI.Mediators.ToPieceType.from_piece(piece)
      # IO.puts("pos.turn:#{pos.turn} src_sq:#{src_sq} piece_type:#{piece_type}")

      case piece_type do
        # キング（King；玉）
        :k -> pos |> make_king_move(src_sq)
        # ルック（Rook；飛車）
        :r -> pos |> make_rook_move(src_sq)
        # ビショップ（Bishop；角）
        :b -> pos |> make_bishop_move(src_sq)
        # ゴールド（Gold；金）
        :g -> pos |> make_gold_move(src_sq)
        # シルバー（Silver；銀）
        :s -> pos |> make_silver_move(src_sq)
        # ナイト（kNight；桂）
        :n -> pos |> make_knight_move(src_sq)
        # ランス（Lance；香）
        :l -> pos |> make_lance_move(src_sq)
        # ポーン（Pawn；歩）
        :p -> pos |> make_pawn_move(src_sq)
        # 玉は成れません
        # :pk1
        # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
        :pr -> pos |> make_promoted_rook_move(src_sq)
        # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
        :pb -> pos |> make_promoted_bishop_move(src_sq)
        # 金は成れません
        # :pg1
        # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
        :ps -> pos |> make_promoted_silver_move(src_sq)
        # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
        :pn -> pos |> make_promoted_knight_move(src_sq)
        # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
        :pl -> pos |> make_promoted_lance_move(src_sq)
        # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To Kin"；と金 is 金 cursive）
        :pp -> pos |> make_promoted_pawn_move(src_sq)
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

  # キング（King；玉）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_king_move(_pos, _src_sq) do
    []
  end

  # ルック（Rook；飛車）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_rook_move(_pos, _src_sq) do
    []
  end

  # ビショップ（Bishop；角）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_bishop_move(_pos, _src_sq) do
    []
  end

  # ゴールド（Gold；金）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_gold_move(_pos, _src_sq) do
    []
  end

  # シルバー（Silver；銀）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_silver_move(_pos, _src_sq) do
    []
  end

  # ナイト（kNight；桂）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_knight_move(_pos, _src_sq) do
    []
  end

  # ランス（Lance；香）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_lance_move(_pos, _src_sq) do
    []
  end

  # ポーン（Pawn；歩）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_pawn_move(_pos, _src_sq) do
    []
  end

  # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_promoted_rook_move(_pos, _src_sq) do
    []
  end

  # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_promoted_bishop_move(_pos, _src_sq) do
    []
  end

  # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_promoted_silver_move(_pos, _src_sq) do
    []
  end

  # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_promoted_knight_move(_pos, _src_sq) do
    []
  end

  # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_promoted_lance_move(_pos, _src_sq) do
    []
  end

  # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To Kin"；と金 is 金 cursive）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_promoted_pawn_move(_pos, _src_sq) do
    []
  end

end
