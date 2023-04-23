defmodule KifuwarabeWcsc33.CLI.MoveGeneration.MakeList do
  @moduledoc """
    指し手生成
  """

  @doc """

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. ムーブ・リスト（Move List；指し手のリスト） - 投了を含まない

  """
  def do_it(pos) do
    # 盤上の自駒
    # =========
    #
    # |> スペース（:sp；空マス）は除去。かつ、手番の駒だけ残す
    # |> ピース（Piece；先後付きの駒種類）から、先後を消し、ピース・タイプ（Piece Type；駒種類）に変換する
    # |> マス番地と駒種類から、指し手生成
    # |> リストがネストしていたら、フラットにする
    # |> 指し手が nil なら除去
    move_list_on_board =
      pos.board
        |> Enum.filter(fn{_sq,piece} -> piece != :sp and pos.turn == KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(piece) end)
        |> Enum.map(fn{sq,piece} -> {sq, KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece)} end)
        |> Enum.map(fn {sq,piece_type} -> pos|>make_move_list_by_piece_on_board(sq,piece_type) end)
        |> List.flatten()
        |> Enum.filter(fn(move) -> !is_nil(move) end)
        # 難しい書き方 |> Enum.filter(& !is_nil(&1))

    #
    # 打つ手のリスト
    # ============
    #
    # |> 手番側、かつ、１つ以上持っている駒種類だけ残す
    # |> 駒の数を消す。ピース（Piece；先後付きの駒種類）から、先後を消し、ピース・タイプ（Piece Type；駒種類）に変換する。駒種類から、指し手生成
    # |> リストがネストしていたら、フラットにする
    # |> 指し手が nil なら除去
    move_list_on_hand =
      pos.hand_pieces
        |> Enum.filter(fn{piece,num} -> pos.turn == KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(piece) and 0 < num end)
        |> Enum.map(fn{piece,_num} ->
            KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece)
              |> make_move_list_on_hand(pos)
          end)
        |> List.flatten()
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # IO.inspect(move_list_on_hand, label: "[MakeList do_it] move_list_on_hand")

    move_list_on_board ++ move_list_on_hand
  end

  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #   * `piece_type` - ピース・タイプ（Piece Type；先後付きの駒種類）
  #
  defp make_move_list_by_piece_on_board(pos, src_sq, piece_type) do
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
      # 成り玉なんて無いぜ
      # :pk1
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr -> pos |> make_move_of_promoted_rook(src_sq)
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb -> pos |> make_move_of_promoted_bishop(src_sq)
      # 裏返った金なんて無いぜ
      # :pg1
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps -> pos |> make_move_of_gold(src_sq)
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn -> pos |> make_move_of_gold(src_sq)
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl -> pos |> make_move_of_gold(src_sq)
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To Kin"；と金 is 金 cursive）
      :pp -> pos |> make_move_of_gold(src_sq)
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
    # IO.puts("[move_generation make_move_of_king] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 先手視点で定義しろだぜ
    [
      # ∧
      # │
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
      # 　─┐
      # ／
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_east_of),
      # ──＞
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :east_of),
      # ＼
      # 　─┘
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_east_of),
      # │
      # Ｖ
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_of),
      # 　／
      # └─
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_west_of),
      # ＜──
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :west_of),
      # ┌─
      # 　＼
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_west_of),
    ]
  end

  # 手番の、ルック（Rook；飛車）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_rook(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_rook] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 成らず
    move_list_without_promote =
      [
        # ∧ Long
        # │
        # │
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_of),
        # ────＞ Long
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :east_of),
        # │
        # │
        # Ｖ Long
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :south_of),
        # ＜──── Long
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :west_of),
      ]
        # 長い利きは複数あるかも
        |> List.flatten()
        # （成る手を追加する前に）進めない動きを省く
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # （あれば）成る手を追加
    move_list_with_promote =
      move_list_without_promote
        |> Enum.filter(fn (move) -> !move.promote? and KifuwarabeWcsc33.CLI.Thesis.Promotion.can_promote?(pos, move.source, move.destination) end)
        |> Enum.map(fn (move) -> KifuwarabeWcsc33.CLI.Mappings.ToPromote.promote(move) end)
        |> List.flatten()

    move_list_without_promote ++ move_list_with_promote
  end

  # 手番の、ビショップ（Bishop；角）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_bishop(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_bishop] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 成らず
    move_list_without_promote =
      [
        # 　　─┐ Long
        # 　／
        # ／
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_east_of),
        # ＼
        # 　＼
        # 　　─┘ Long
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :south_east_of),
        # 　　／
        # 　／
        # └─ Long
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :south_west_of),
        # ┌─ Long
        # 　＼
        # 　　＼
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_west_of),
      ]
        # 長い利きは複数あるかも
        |> List.flatten()
        # （成る手を追加する前に）進めない動きを省く
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # （あれば）成る手を追加
    move_list_with_promote =
      move_list_without_promote
        |> Enum.filter(fn (move) -> !move.promote? and KifuwarabeWcsc33.CLI.Thesis.Promotion.can_promote?(pos, move.source, move.destination) end)
        |> Enum.map(fn (move) -> KifuwarabeWcsc33.CLI.Mappings.ToPromote.promote(move) end)
        |> List.flatten()

    move_list_without_promote ++ move_list_with_promote
  end

  # 手番の、ゴールド（Gold；金）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_gold(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_gold] pos.turn:#{pos.turn} src_sq:#{src_sq}")
    [
      # ∧
      # │
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
      # 　─┐
      # ／
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_east_of),
      # ──＞
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :east_of),
      # │
      # Ｖ
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_of),
      # ＜──
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :west_of),
      # ┌─
      # 　＼
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_west_of),
    ]
  end

  # 手番の、シルバー（Silver；銀）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_silver(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_silver] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 成らず
    move_list_without_promote =
      [
        # ∧
        # │
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
        # 　─┐
        # ／
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_east_of),
        # ＼
        # 　─┘
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_east_of),
        # 　／
        # └─
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_west_of),
        # ┌─
        # 　＼
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_west_of),
      ]
        # （成る手を追加する前に）進めない動きを省く
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # （あれば）成る手を追加
    move_list_with_promote =
      move_list_without_promote
        |> Enum.filter(fn (move) -> !move.promote? and KifuwarabeWcsc33.CLI.Thesis.Promotion.can_promote?(pos, move.source, move.destination) end)
        |> Enum.map(fn (move) -> KifuwarabeWcsc33.CLI.Mappings.ToPromote.promote(move) end)
        |> List.flatten()

    move_list_without_promote ++ move_list_with_promote
  end

  # 手番の、ナイト（kNight；桂）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_knight(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_knight] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 成らずの手を生成（行き先の無い駒を含む）
    move_list_without_promote =
      [
        # 　─┐
        # ／
        # │
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_north_east_of),
        # ┌─
        # 　＼
        # 　　│
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_north_west_of),
      ]
        # （成る手を追加する前に）進めない動きを省く
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # 行き先のない駒は、成り駒に変換したい
    move_list_without_promote =
      move_list_without_promote
        |> Enum.map(fn (move) ->
            if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_opponent_rank1_and_2?(pos, move.destination) do
              %{ move | promote?: true }
            else
              move
            end
          end)

    # （あれば）成る手を追加
    move_list_with_promote =
      move_list_without_promote
        |> Enum.filter(fn (move) -> !move.promote? and KifuwarabeWcsc33.CLI.Thesis.Promotion.can_promote?(pos, move.source, move.destination) end)
        |> Enum.map(fn (move) -> KifuwarabeWcsc33.CLI.Mappings.ToPromote.promote(move) end)
        |> List.flatten()

    move_list_without_promote ++ move_list_with_promote
  end

  # 手番の、ランス（Lance；香）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_lance(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_lance] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 成らず（行き先の無い駒を含む）
    move_list_without_promote =
      [
        # ∧ Long
        # │
        # │
        KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_of),
      ]
        # 長い利きは複数あるかも
        |> List.flatten()
        # （成る手を追加する前に）進めない動きを省く
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # 行き先のない駒は、成り駒に変換したい
    move_list_without_promote =
      move_list_without_promote
        |> Enum.map(fn (move) ->
            if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_opponent_rank1?(pos, move.destination) do
              %{ move | promote?: true }
            else
              move
            end
          end)

    # （あれば）成る手を追加
    move_list_with_promote =
      move_list_without_promote
        |> Enum.filter(fn (move) -> !move.promote? and KifuwarabeWcsc33.CLI.Thesis.Promotion.can_promote?(pos, move.source, move.destination) end)
        |> Enum.map(fn (move) -> KifuwarabeWcsc33.CLI.Mappings.ToPromote.promote(move) end)
        |> List.flatten()

    move_list_without_promote ++ move_list_with_promote
  end

  # 手番の、ポーン（Pawn；歩）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_pawn(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_pawn] pos.turn:#{pos.turn} src_sq:#{src_sq}")

    # 成らずの動き（行き先の無い駒を含む）
    move_list_without_promote =
      [
        # ∧
        # │
        KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
      ]
        # （成る手を追加する前に）進めない動きを省く
        |> Enum.filter(fn(move) -> !is_nil(move) end)

    # 行き先のない駒は、成り駒に変換したい
    move_list_without_promote =
      move_list_without_promote
        |> Enum.map(fn (move) ->
            if KifuwarabeWcsc33.CLI.Thesis.Board.is_in_opponent_rank1?(pos, move.destination) do
              %{ move | promote?: true }
            else
              move
            end
          end)

    # （あれば）成る手を追加
    move_list_with_promote =
      move_list_without_promote
        |> Enum.filter(fn (move) -> !move.promote? and KifuwarabeWcsc33.CLI.Thesis.Promotion.can_promote?(pos, move.source, move.destination) end)
        |> Enum.map(fn (move) -> KifuwarabeWcsc33.CLI.Mappings.ToPromote.promote(move) end)
        |> List.flatten()

    move_list_without_promote ++ move_list_with_promote
  end

  # 手番の、It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_rook(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_promoted_rook] pos.turn:#{pos.turn} src_sq:#{src_sq}")
    short_effect = [
      # 　─┐
      # ／
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_east_of),
      # ＼
      # 　─┘
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_east_of),
      # 　／
      # └─
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_west_of),
      # ┌─
      # 　＼
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_west_of),
    ]
    
    long_effect = [
      # ∧ Long
      # │
      # │
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_of),
      # ────＞ Long
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :east_of),
      # │
      # │
      # Ｖ Long
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :south_of),
      # ＜──── Long
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :west_of),
    ] |> List.flatten()
    
    short_effect ++ long_effect
  end

  # 手番の、It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
  #
  # ## Parameters
  #
  #   * `pos` - ポジション（Position；局面）
  #   * `src_sq` - ソース・スクウェア（SouRCe SQuare：マス番地）
  #
  defp make_move_of_promoted_bishop(pos, src_sq) do
    # IO.puts("[move_generation make_move_of_promoted_bishop] pos.turn:#{pos.turn} src_sq:#{src_sq}")
    short_effect = [
      # ∧
      # │
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :north_of),
      # ──＞
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :east_of),
      # │
      # Ｖ
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :south_of),
      # ＜──
      KifuwarabeWcsc33.CLI.Mappings.ToMove.from(src_sq, pos, :west_of),
    ]
    
    long_effect = [
      # 　　─┐ Long
      # 　／
      # ／
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_east_of),
      # ＼
      # 　＼
      # 　　─┘ Long
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :south_east_of),
      # 　　／
      # 　／
      # └─ Long
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :south_west_of),
      # ┌─ Long
      # 　＼
      # 　　＼
      KifuwarabeWcsc33.CLI.Mappings.ToMove.list_from(src_sq, pos, :north_west_of),
    ] |> List.flatten()
    
    short_effect ++ long_effect
  end

  # 持ち駒の指し手生成
  #
  # ## Parameters
  #
  #   * `piece_type` - ピース・タイプ（Piece Type；先後付きの駒種類）
  #   * `pos` - ポジション（Position；局面）
  #
  # ## Returns
  #
  # 0. ムーブ・リスト
  #
  defp make_move_list_on_hand(piece_type, pos) do
    # デスティネーション・スクウェアーズ（Destination Squares；移動先のマスのリスト）
    destination_squares =
      case piece_type do
        # 対局中は、玉は打てません
        # :k
        # ルック（Rook；飛車）
        :r -> KifuwarabeWcsc33.CLI.Models.Squares.all_squares
        # ビショップ（Bishop；角）
        :b -> KifuwarabeWcsc33.CLI.Models.Squares.all_squares
        # ゴールド（Gold；金）
        :g -> KifuwarabeWcsc33.CLI.Models.Squares.all_squares
        # シルバー（Silver；銀）
        :s -> KifuwarabeWcsc33.CLI.Models.Squares.all_squares
        # ナイト（kNight；桂）
        :n -> KifuwarabeWcsc33.CLI.Models.Squares.get_list_of_squares_where_i_can_place_knight(pos)
        # ランス（Lance；香）
        :l -> KifuwarabeWcsc33.CLI.Models.Squares.get_list_of_squares_where_i_can_place_lance(pos)
        # ポーン（Pawn；歩）
        :p -> KifuwarabeWcsc33.CLI.Models.Squares.get_list_of_squares_where_i_can_place_pawn(pos)
        #
        # それ以外はエラー
        # ==============
        #
        _ -> raise "unexpected piece_type:(#{piece_type})"
      end

    destination_squares =
      destination_squares
        # スペース（Space；空マス）にしか打てない（駒が置いてあるところには打てない）
        |> Enum.filter( fn (sq) -> pos.board[sq] == :sp end)

    destination_squares
      |> Enum.map(fn (dst_sq) ->
            move = KifuwarabeWcsc33.CLI.Models.Move.new()
            %{ move | drop_piece_type: piece_type, destination: dst_sq}
          end)
  end

end
