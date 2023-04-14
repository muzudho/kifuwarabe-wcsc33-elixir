defmodule KifuwarabeWcsc33.CLI.Views.Move do
  def as_code(move) do
    # 移動元
    # ======
    source_as_str =
      if move.drop_piece_type != nil do
        KifuwarabeWcsc33.CLI.Views.DropPiece.as_code(move.drop_piece_type)
      else
        KifuwarabeWcsc33.CLI.Views.BoardAddress.as_code(move.source)
      end

    # 移動先
    # =====
    destination_as_str = KifuwarabeWcsc33.CLI.Views.BoardAddress.as_code(move.destination)

    # 成り
    # ====
    promote_as_str =
      if move.promote? do
        "+"
      else
        ""
      end

    "#{source_as_str}#{destination_as_str}#{promote_as_str}"
  end
end
