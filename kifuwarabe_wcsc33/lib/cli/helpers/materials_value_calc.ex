defmodule KifuwarabeWcsc33.CLI.Helpers.MaterialsValueCalc do
  @moduledoc """

    駒得を数える

  """

  @doc """

    駒得を数える

  ## Parameters

    * `pos` - ポジション（Position；局面）

  ## Returns

    0. バリュー（Value；評価値）

  """
  def count(pos) do

    # 先手が良ければプラス、後手が良ければマイナスとする

    # 全てのマス番地について
    # |> 駒に変換
    # |> 空きマスを除去
    # |> 駒を評価値に変換
    # |> すべてのマスの評価値を足して、１つの整数にする
    value_on_board =
      KifuwarabeWcsc33.CLI.Models.Squares.all_squares
        |> Enum.map(fn (sq) -> pos.board[sq] end)
        |> Enum.filter(fn (piece) -> piece != :sp end)
        |> Enum.map(fn (piece) ->
            piece_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(piece)
            sign = get_sign(piece_turn, pos)
            piece_type = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece)
            value = sign * get_value_by_piece_type(piece_type)
            # IO.puts("[materials_value_calc] piece_type:#{piece_type} value:#{value}")
            value
          end)
        |> Enum.reduce(0, fn (value, acc) -> acc + value end)

    # 全ての持ち駒について
    # |> 駒の数を、整数１つ分の評価値に変換
    # |> すべてのマスの評価値を足して、１つの整数にする
    value_on_hand =
      pos.hand_pieces
        |> Enum.map(fn (piece_and_num) ->
            num = elem(piece_and_num, 1)
            piece = elem(piece_and_num, 0)
            piece_turn = KifuwarabeWcsc33.CLI.Mappings.ToTurn.from_piece(piece)
            sign = get_sign(piece_turn, pos)
            piece_type = KifuwarabeWcsc33.CLI.Mappings.ToPieceType.from_piece(piece)
            unit_value = get_value_by_piece_type(piece_type)
            value = sign * num * unit_value
            # IO.puts("[materials_value_calc] num:#{num} value:#{value}")
            value
          end)
        |> Enum.reduce(0, fn (value, acc) -> acc + value end)

    value_on_board + value_on_hand
  end

  def get_sign(piece_turn, pos) do
    if pos.turn == :sente do
      if piece_turn == :sente do
        1
      else
        -1
      end
    else
      if piece_turn == :sente do
        -1
      else
        1
      end
    end
  end

  #
  # 先手から見た評価値
  #
  # ## 雑談
  #
  #   - この手法には、勝つことをそっちのけで「と金」をたくさん作ってしまう、という問題点がある。（数学的に言えば、線形だから）
  #   - 古典的には、歩を 100 にする想定（センチポーン）だが、一時期は 90 といった 100 未満に減らしたり、機械学習で自動的に点数付けられた時期を経て、 2023年現在では センチポーンは気にされなくなった
  #   - 駒の価値とは、アマチュア・レベルのゲームの話しとして、こっちが銀を取られても、すぐ角を取り返すから得だ、といったような、交換の場面を前提としている。
  #     これを バリュー・オブ・ザ・エクスチェンジ（Value of the exchange；駒の交換値）という。
  #     相手は駒の価値（交換値のタネ）分減り、自分は駒の価値（交換値のタネ）分増えるので、「ただ取り」されると、思っているより２倍の差が開くが、本来は取り返すことを考えている。
  #     だから、駒に付けられた価値の差が重要だ
  #   - （特に決まりはないが、考えれば分かるが）玉の評価値は、それ以外の全ての駒を取ったときより大きくしておくこと
  #
  #     Pro.Rook   Pro.Bishop  Gold      Silver    Pro.Knight   Pro.Lance   Pro.Pawn
  #     2 * 1000 + 2 * 900 +   4 * 500 + 4 * 400 + 4 * 500    + 4 * 500   + 18 * 150 = 14100
  #
  #   - 問題点：持ち駒だからといって高い評価値になるわけではない。かといって、持ち駒の評価を高くすると、打たない方へ働く
  #   - 下記の数値は、開発者の Muzudho が適当に付けた
  #
  @king 15000
  @rook 900
  @bishop 800
  @gold 500
  @silver 400
  @knight 200
  @lance 200
  @pawn 100
  @promoted_rook 1000
  @promoted_bishop 900
  @promoted_silver 400
  @promoted_knight 500
  @promoted_lance 500
  @promoted_pawn 150
  @space 0
  def get_value_by_piece_type(piece_type) do
    case piece_type do
      # キング（King；玉）
      :k -> @king
      # ルック（Rook；飛車）
      :r -> @rook
      # ビショップ（Bishop；角）
      :b -> @bishop
      # ゴールド（Gold；金）
      :g -> @gold
      # シルバー（Silver；銀）
      :s -> @silver
      # ナイト（kNight；桂）
      :n -> @knight
      # ランス（Lance；香）
      :l -> @lance
      # ポーン（Pawn；歩）
      :p -> @pawn
      # 成り玉なんて無いぜ
      # :pk
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr -> @promoted_rook
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb -> @promoted_bishop
      # 裏返った金なんて無いぜ
      # :pg
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps -> @promoted_silver
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn -> @promoted_knight
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl -> @promoted_lance
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp -> @promoted_pawn
      #
      # 空マス
      # =====
      #
      :sp -> @space
      #
      # それ以外はエラー
      # ==============
      #
      _ -> raise "unexpected piece_type:(#{piece_type})"
    end
  end
end
