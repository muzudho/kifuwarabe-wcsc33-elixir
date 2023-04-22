defmodule KifuwarabeWcsc33.CLI.Views.DropPiece do
  def as_code_filter_hand(piece_type) do
      case piece_type do
        # キング（King；玉）. 対局中は使わない
        :k -> "K*"
        # ルック（Rook；飛）
        :r -> "R*"
        # ビショップ（Bishop；角）
        :b -> "B*"
        # ゴールド（Gold；金）
        :g -> "G*"
        # シルバー（Silver；銀）
        :s -> "S*"
        # ナイト（kNight；桂）
        :n -> "N*"
        # ランス（Lance；香）
        :l -> "L*"
        # ポーン（Pawn；歩）
        :p -> "P*"
        _ -> raise "unexpected drop piece type:#{piece_type}"
      end
  end
end
