defmodule KifuwarabeWcsc33.CLI.Models.Position do
  # TODO map に整形したいぜ
  defstruct piece_map:[
    rank1: %{91 => :l2,81 => :n2,71 => :s2,61 => :g2,51 => :k2,41 => :g2,31 => :s2,21 => :n2,11 => :l2},
    rank2: %{92 => :em,82 => :b2,72 => :em,62 => :em,52 => :em,42 => :em,32 => :em,22 => :r2,12 => :em},
    rank3: %{93 => :p2,83 => :p2,73 => :p2,63 => :p2,53 => :p2,43 => :p2,33 => :p2,23 => :p2,13 => :p2},
    rank4: %{94 => :em,84 => :em,74 => :em,64 => :em,54 => :em,44 => :em,34 => :em,24 => :em,14 => :em},
    rank5: %{95 => :em,85 => :em,75 => :em,65 => :em,55 => :em,45 => :em,35 => :em,25 => :em,15 => :em},
    rank6: %{96 => :em,86 => :em,76 => :em,66 => :em,56 => :em,46 => :em,36 => :em,26 => :em,16 => :em},
    rank7: %{97 => :P2,87 => :P2,77 => :P2,67 => :P2,57 => :P2,47 => :P2,37 => :P2,27 => :P2,17 => :P2},
    rank8: %{98 => :em,88 => :B2,78 => :em,68 => :em,58 => :em,48 => :em,38 => :em,28 => :R2,18 => :em},
    rank9: %{99 => :L2,89 => :N2,79 => :S2,69 => :G2,59 => :K2,49 => :G2,39 => :S2,29 => :N2,19 => :L2},
  ]

  # Auto Format 融通きかねーっ
  # defstruct piece_map:
  #             %{} ++
  #               %{
  #                 91 => :l2,
  #                 81 => :n2,
  #                 71 => :s2,
  #                 61 => :g2,
  #                 51 => :k2,
  #                 41 => :g2,
  #                 31 => :s2,
  #                 21 => :n2,
  #                 11 => :l2
  #               } ++
  #               %{
  #                 92 => :em,
  #                 82 => :b2,
  #                 72 => :em,
  #                 62 => :em,
  #                 52 => :em,
  #                 42 => :em,
  #                 32 => :em,
  #                 22 => :r2,
  #                 12 => :em
  #               }

  # Elixir のリスト、リンクドリストだ、ランダム・アクセス遅そう、使いたくねー
  # defstruct piece_list:
  #             [] ++
  #               [:l2, :n2, :s2, :g2, :k2, :g2, :s2, :n2, :l2] ++
  #               [:em, :b2, :em, :em, :em, :em, :em, :r2, :em] ++
  #               [:p2, :p2, :p2, :p2, :p2, :p2, :p2, :p2, :p2] ++
  #               [:em, :em, :em, :em, :em, :em, :em, :em, :em] ++
  #               [:em, :em, :em, :em, :em, :em, :em, :em, :em] ++
  #               [:em, :em, :em, :em, :em, :em, :em, :em, :em] ++
  #               [:p1, :p1, :p1, :p1, :p1, :p1, :p1, :p1, :p1] ++
  #               [:em, :b1, :em, :em, :em, :em, :em, :r1, :em] ++
  #               [:l1, :n1, :s1, :g1, :k1, :g1, :s1, :n1, :l1]

  def(new()) do
    struct!(KifuwarabeWcsc33.CLI.Models.Position)
  end
end
