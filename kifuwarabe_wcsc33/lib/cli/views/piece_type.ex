defmodule KifuwarabeWcsc33.CLI.Views.PieceType do
  @moduledoc """

    （先後の付いていない）駒種類

  """

  @doc """

    文字列化（大文字）

  """
  @spec stringify_upper_case(atom) :: String.t
  def stringify_upper_case(piece_type) do
    case piece_type do
      # キング（King；玉）
      :k -> "K"
      # ルック（Rook；飛車）
      :r -> "R"
      # ビショップ（Bishop；角）
      :b -> "B"
      # ゴールド（Gold；金）
      :g -> "G"
      # シルバー（Silver；銀）
      :s -> "S"
      # ナイト（kNight；桂）
      :n -> "N"
      # ランス（Lance；香）
      :l -> "L"
      # ポーン（Pawn；歩）
      :p -> "P"
      # 成り玉なんて無いぜ
      # :pk
      # It's reasonably a プロモーテッド・ルック（Promoted Rook；成飛）. It's actually ドラゴン（Dragon；竜）
      :pr -> "+R"
      # It's reasonably a プロモーテッド・ビショップ（Promoted Bishop；成角）.  It's actually ホース（Horse；馬）. Ponanza calls ペガサス（Pegasus；天馬）
      :pb -> "+B"
      # 裏返った金なんて無いぜ
      # :pg
      # プロモーテッド・シルバー（Promoted Silver；成銀. Or 全 in one letter）
      :ps -> "+S"
      # プロモーテッド・ナイト（Promoted kNight；成桂. Or 圭 in one letter）
      :pn -> "+N"
      # プロモーテッド・ランス（Promoted Lance；成香. Or 杏 in one letter）
      :pl -> "+L"
      # It's reasonably a プロモーテッド・ポーン（Promoted Pawn；成歩）. It's actually と（"To"；と is 金 cursive）
      :pp -> "+P"
      # その他
      _ -> raise "undefined piece type:#{piece_type}"
    end
  end
end
