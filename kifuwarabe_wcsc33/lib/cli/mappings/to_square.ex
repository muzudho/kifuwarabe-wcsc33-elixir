defmodule KifuwarabeWcsc33.CLI.Mappings.ToSquare do
  @moduledoc """
  
    マス番地に関する関数

  """

  @doc """

    何列目か

  ## Parameters

    * `sq` - スクウェア（Square；マス番地）。11～99

  """
  def file(sq) do
    sq |> div(10)
  end

  @doc """

    何段目か

  ## Parameters

    * `sq` - スクウェア（Square；マス番地）。11～99

  """
  def rank(sq) do
    # 剰余
    sq |> rem(10)
  end

end