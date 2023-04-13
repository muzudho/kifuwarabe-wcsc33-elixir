defmodule KifuwarabeWcsc33.CLI.Models.Sequence do
  @moduledoc """
    数列
  """

  #
  # 盤の符号 ９一、８一、７一 …と読んでいく。１九が最後。
  # 10ずつ減っていき、十の位が無くなったら一の位が増える。
  #
  # ## Examples
  #
  # 盤の符号 ９一、８一、７一 …と読んでいく。１九が最後。
  # 10ずつ減っていき、十の位が無くなったら一の位が増える。
  #
  # TODO こんなん毎回生成したくないぞ
  # sequence = KifuwarabeWcsc33.CLI.Models.Sequence.new()
  #
  # show_sq = fn sq -> IO.puts("sq:#{sq}") end
  #
  # sequence.address_list
  # |> Enum.map(show_sq)
  #
  defstruct address_list: [
              # １段目
              91,
              81,
              71,
              61,
              51,
              41,
              31,
              21,
              11,
              # ２段目
              92,
              82,
              72,
              62,
              52,
              42,
              32,
              22,
              12,
              # ３段目
              93,
              83,
              73,
              63,
              53,
              43,
              33,
              23,
              13,
              # ４段目
              94,
              84,
              74,
              64,
              54,
              44,
              34,
              24,
              14,
              # ５段目
              95,
              85,
              75,
              65,
              55,
              45,
              35,
              25,
              15,
              # ６段目
              96,
              86,
              76,
              66,
              56,
              46,
              36,
              26,
              16,
              # ７段目
              97,
              87,
              77,
              67,
              57,
              47,
              37,
              27,
              17,
              # ８段目
              98,
              88,
              78,
              68,
              58,
              48,
              38,
              28,
              18,
              # ９段目
              99,
              89,
              79,
              69,
              59,
              49,
              39,
              29,
              19
            ]

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.Sequence)
  end
end
