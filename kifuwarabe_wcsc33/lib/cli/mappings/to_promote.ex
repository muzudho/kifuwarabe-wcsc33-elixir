defmodule KifuwarabeWcsc33.CLI.Mappings.ToPromote do
  def promote(move) do
    %{move | promote?: true}
  end

  def demote(move) do
    %{move | promote?: false}
  end
end
