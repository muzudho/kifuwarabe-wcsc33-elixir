defmodule KifuwarabeWcsc33.CLI do
  # For ".exe" file build
  def main(args \\ []) do
    # TODO: 実装
    args |> IO.inspect()
    # args
    # |> parse_args
    # |> response
    # |> IO.puts()
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean])

    {opts, List.to_string(word)}
  end

  defp response({opts, word}) do
    if opts[:upcase], do: String.upcase(word), else: word
  end
end
