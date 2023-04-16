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
    # |> 手番の駒だけ残す
    # |> ピース（Piece；先後付きの駒種類）から、先後を消し、ピース・タイプ（Piece Type；駒種類）に変換する
    # |> マス番地と先後付きの駒種類から、指し手生成
    # |> 指し手が nil なら除去
    # |> リストがネストしていたら、フラットにする
    move_sub_list = pos.board
      |> Enum.filter(fn{_sq,piece} -> piece != :sp end)
      |> Enum.filter(fn{_sq,piece} -> pos.turn == KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(piece) end)
      |> Enum.map(fn{sq,piece} -> {sq,KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece)} end)
      |> Enum.map(fn {sq,piece_type} -> pos|>make_move_list_by_piece(sq,piece_type) end)
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
  #   * `piece_type` - ピース・タイプ（Piece Type；先後付きの駒種類）
  #
  defp make_move_list_by_piece(pos, src_sq, piece_type) do
    case piece_type do
      # キング（King；玉）
      :k -> pos |> make_move_of_king(src_sq)
      # ルック（Rook；飛車）
      :r -> pos |> make_move_of_rook(src_sq)
      # ビショップ（Bishop；角）
      :b -> pos |> make_move_of_bishop(src_sq)
      # ゴールド（Gold；金）
      :g -> pos |> make_move_of_gold(src_sq)
      # シルバー（Silver；銀）
      :s -> pos |> make_move_of_silver(src_sq)
      # ナイト（kNight；桂）
      :n -> pos |> make_move_of_knight(src_sq)
      # ランス（Lance；香）
      :l -> pos |> make_move_of_lance(src_sq)
      # ポーン（Pawn；歩）
      :p -> pos |> make_move_of_pawn(src_sq)
      # 玉は成れません
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr -> pos |> make_move_of_promoted_rook(src_sq)
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb -> pos |> make_move_of_promoted_bishop(src_sq)
      # 金は成れません
      # :pg1
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps -> pos |> make_move_of_promoted_silver(src_sq)
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn -> pos |> make_move_of_promoted_knight(src_sq)
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl -> pos |> make_move_of_promoted_lance(src_sq)
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To Kin"；と金 is 金 cursive）
      :pp -> pos |> make_move_of_promoted_pawn(src_sq)
      #
      # それ以外はエラー
      # ==============
      #
      _ -> raise "unexpected piece_type:#{piece_type}"
    end

  end

  # 手番の、キング（King；玉）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_king(pos, src_sq) do
    [
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :north_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :north_east_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :east_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :south_east_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :south_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :south_west_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :west_of),
      KifuwarabeWcsc33.CLI.Models.ToDestination.from(src_sq, pos.turn, :north_west_of),
    ]
  end

  # 手番の、ルック（Rook；飛車）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_rook(_pos, _src_sq) do
    []
  end

  # 手番の、ビショップ（Bishop；角）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_bishop(_pos, _src_sq) do
    []
  end

  # 手番の、ゴールド（Gold；金）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_gold(_pos, _src_sq) do
    []
  end

  # 手番の、シルバー（Silver；銀）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_silver(_pos, _src_sq) do
    []
  end

  # 手番の、ナイト（kNight；桂）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_knight(_pos, _src_sq) do
    []
  end

  # 手番の、ランス（Lance；香）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_lance(_pos, _src_sq) do
    []
  end

  # 手番の、ポーン（Pawn；歩）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_pawn(_pos, _src_sq) do
    []
  end

  # 手番の、It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_rook(_pos, _src_sq) do
    []
  end

  # 手番の、It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_bishop(_pos, _src_sq) do
    []
  end

  # 手番の、プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_silver(_pos, _src_sq) do
    []
  end

  # 手番の、プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_knight(_pos, _src_sq) do
    []
  end

  # 手番の、プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_lance(_pos, _src_sq) do
    []
  end

  # 手番の、It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To Kin"；と金 is 金 cursive）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_pawn(_pos, _src_sq) do
    []
  end

end
