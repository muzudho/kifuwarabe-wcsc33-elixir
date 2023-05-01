# バグ・チェック

## 自殺手が出る場面

```plaintext
position startpos moves 1i1h 1a1b 6i6h 4a3b 9g9f 8b7b 8h9g 7b6b 9i9h 5a4a 3i3h 2b1a 4i4h 4c4d 9g8f 6a5b 8f9g 7a8b 9g8f 1c1d 9h9g 1a2b 5g5f 2b1a 7i7h 1b1c 5i5h 7c7d 5h6i 7d7e 1g1f 9a9b 2i1g 1a2b 5f5e 2b1a 1g2e 1a2b 1h1g 3c3d 8f9e 8b9a 6g6f 5b4c 9e8d 6b5b 9f9e 1d1e 9g9f 2b3c 4h5g 3a2b 8g8f 1c1d 5e5d 4a4b 3g3f 7e7f 5d5c 2a1c 8d9c 5b5c 9c8d 9b9c 8d7c 1e1f 5g4f 5c5d 7c8d 5d5e
```

```plaintext
position startpos moves 2h3h 9a9b 1i1h 4a4b 3h4h 6a5b 6i6h 8b7b 5g5f 4b3b 9i9h 7a6b 4h5h 1a1b 1g1f 2b1a 5h5g 3c3d 1h1g 3a2b 7g7f 5a4a 3i2h 3b3c 8h7g 7c7d 7g8h 7d7e 6h7g 7b7c 5i6h 6b7a 4i5i 1c1d 6h7h 1d1e 7f7e 1b1c 8h9i 1c1d 7g7f 4a4b 9i8h 2c2d 5i4h 7c7d 1f1e 7a6b 8h9i 2b1c 2g2f 1d1e 7h7g 4c4d 9g9f 3c2c 9h9g 6c6d 7g6f 8c8d 8g8f 2c1d 2f2e 1a2b 2e2d 5b4c 7e7d 2b1a 9i8h 1c2d 8h7g 6b7a
```

## 飛んだ桂馬が成らないといけない局面

```plaintext
5skn1/1bs6/1pP1Ngrpl/l1GP2P1p/L4p3/1PS1pP1P1/2B1G4/3K2S1g/9 b N4Prnl3p 1
```

## 桂成で成れずにエラー

👇 `8e9g+` でエラー  

```plaintext
position startpos moves 4i4h 7c7d 2h3h 8b7b 9i9h 7b6b 1i1h 9c9d 3g3f 1a1b 6i6h 2b1a 3h3g 5a5b 5i5h 6a5a 4g4f 3c3d 8h9i 5c5d 3g4g 5b5c 9i8h 4a4b 8h9i 6b5b 3f3e 5c6b 2g2f 5b5c 8g8f 6b7c 3i2h 9a9b 9i8h 1a2b 8h9i 8a9c 9i8h 9c8e 6g6f 4b3b 2h3g
```

## と金が成ろうとした

👇 `1g1h+` を指して反則負け  

```plaintext
position startpos moves 1i1h 1a1b 2h3h 2b1a 3h2h 9a9b 7i7h 1c1d 2h3h 4a4b 8h7i 1b1c 6g6f 6a7b 7i6h 1a2b 5i4h 7b6b 6h7i 2b1a 7i8h 1a2b 3h2h 8b7b 2h3h 1d1e 8h7i 7b8b 7i8h 2b1a 8h7i 3a2b 9i9h 7a7b 7i6h 9c9d 6i7i 9b9c 7g7f 8c8d 7h6i 8b9b 3h2h 1c1d 4i3h 5a4a 6h5i 9b8b 6i7h 8b8c 5i6h 7b6a 4g4f 2a1c 6h5i 4a3a 9g9f 2c2d 4h4g 2b2c 5i4h 3a4a 8i9g 1a2b 3g3f 6b5b 7f7e 2b3a 9g8e 1e1f 4h3g 6a6b 9h9g 8d8e 3g2f 6b5a 7i8i 8c8d 2f3e 1d1e 7h6i 9d9e 8i8h 3a2b 7e7d 8d9d 3e4d 9d8d 4d3e 2b3a 3h4h 8d9d 3e4d 5a6b 4d5e 6b7a 8g8f 9e9f 2i3g 3a2b 5e4d 9d9e 2h3h 1f1g+ 4d5e 8e8f 8h7g 2b1a 7g8g 2d2e 7d7c 9e8e 3h2h
```

## 桂馬が成ったのに、局面データを見ると成ってない

👇 `2e3g+` を指す

```plaintext
position startpos moves 6g6f 9a9b 8g8f 8b7b 9i9h 7b8b 2h1h 8b7b 8h9i 1a1b 6i5h 7a8b 3g3f 7b7a 7i8h 4a3b 2g2f 6c6d 6f6e 2b1a 5g5f 3a4b 5i4h 8c8d 4h5i 6a6b 1h2h 1a2b 1i1h 7a6a 4i4h 8b7a 5i4i 2b3a 4h3h 6b6c 4i4h 6a6b 2h2g 3c3d 2g2h 5a6a 2h2g 3d3e 3h3g 2a3c 3i3h 3c2e 4g4f 6b5b 8h7i 3a2b 5h5i 5c5d 9i8h 5b6b 4h5h 2b3a 5i4i 3a2b 5h5i 7a7b 7i6h 2b3c 3g4g 6b5b 4g3g 4b3a 3h4g 3a4b 6h7i 2e3g+
```

## 何で持ち駒打たんの？

👇 指定局面の持ち駒は数えられる  

```plaintext
position sfen +L+P1+N5/6s1l/6g1n/2p4p1/5pk2/4PP1P1/+BS1p1G3/9/+b2KS3+p b RGSNL4Prgnl5p 1
```

👇 持ち駒無いと思ってる  

```plaintext
position startpos moves 8g8f 9c9d 4i3h 4a5b 7g7f 9a9b 5i6h 3c3d 8h5e 6c6d 6h7h 5b6b 5e4f 8c8d 1i1h 3a3b 2g2f 6b7b 7h6h 3b3c 9g9f 5a6b 8i9g 5c5d 5g5f 6b6c 9f9e 6a5a 4f2d 2c2d 6i5i 1a1b 2f2e 2b3a 6h5h 9d9e 6g6f 3c2b 7f7e 3a4b 3g3f 8a9c 6f6e 6c6b 3f3e 4b3c 2i3g 3c4d 5h4i 4d3c 4i4h 7c7d 2h2f 5a4a 3i2h 3c7g+ 3e3d 2d2e 2h2g 6b6a 4h4i 4a3a 3g4e 7b7c 3d3c+ 7g7f 5i5h 2b1a 3c2b 2e2f 2b3b 8b4b 2g1f 1c1d 1f1e 6a7b 4g4f 2f2g 9g8e 7f6f 3b2a 7b6c 5h5g 3a2b 3h3i 2b2a 7i6h 6c5b 6h7g 5b5a 3i2i 4b2b 4i3h 7d7e 1e1d 7c6c 8e7c+ 2b5b 7c8c 7e7f 3h3g 1b1d 5g6g 6f3i 9i9h 3i2h
```

## 持ってない歩を打った（先手が取った歩が、後手の駒台に乗ってる）

👇 `8g9g` が、先手が後手の歩を取る手  

```plaintext
position startpos moves 5i6h 6a7b 6i5i 4a5b 9g9f 9a9b 9i9g 4c4d 1i1h 5a4a 7g7f 4d4e 7i7h 4a4b 2h5h 4b4c 7h7g 7c7d 7g6f 7b7c 7f7e 5b5a 3g3f 7a7b 3i3h 9c9d 6h7i 7c8d 8h7g 8a9c 5h8h 7b6a 6f6e 5c5d 4i3i 4e4f 3i2h 5a5b 7i7h 4c3d 8g8f 5b4b 8f8e 8b6b 6e6d 3d4c 5i6h 6a7b 8e8d 8c8d 4g4f 3a3b 7g4d 6c6d 6h5h 6d6e P*8e P*4g 8h8f 8d8e G*6a 4b5b 6g6f S*8c 4d5c+ 4c3d 2g2f 9d9e 5h4g 6b6c 3h2g 5b6b 7h8h P*4e 5c5b 3b4c 1g1f 6b5c 8h7g 1c1d 6a6b 8c8d 8f7f 7b8a 7g8g 6c8c 2i1g 8c7c 6b6a 5c5b 4g5f B*7h 8g9h 7c7a 2g3h 4c3b 7f7g 3b4c 6a5a 1a1c 3h4g 2b3a P*8c 4e4f 4g4f 8a7b 7g8g 7h6i 3f3e 3d2d P*4b 6i4g 8c8b+ 5b6c 7e7d 8d7c 4f4e 3a2b 8b7b 7a9a S*7a 4g3f+ 7b6b 3f5h 2h2i 5d5e 5a4a 5h5g P*5h 6c5c 5f4f 5g3i 8g3g 5c4d 2i1i P*4g 8i7g 4c5b 4e3f P*7e 6f6e 4g4h+ 9h9i 4h3h 3f4g 3i1g P*8f N*8g 9i8i 5b6a 8i7h 5e5f 1i2h 3h3i 2h1g 3i2i 7a8b+ 5f5g+ B*4e 6a6b 4f5e P*5f 4e7b 6b6c 3g3f 4d5d 7b8c+ 7c6d 7h8g 5g6h 8b8a 6d5c N*4d 3c3d 3f3h 9e9f 3h3f 2i3i 4d3b+ 2b4d 8a9a 9f9g+ 8g9g
```

# 異常終了

👇 下図からの次の一手 `go` 。成り駒がちゃんと作れてない？  

```plaintext
position sfen 7lk/7l1/7lK/7r1/9/9/9/9/9 b Pr2b4g4s4nl17p 1 moves P*4g B*5e
```

# 王手放置

```plaintext
position sfen 1g1G4b/1s2+N+P3/+Pp3GNkl/2p1s1rp1/lPPP+bS2p/n3g3P/p2l4L/6+s2/3+n1PKP1 b R4Pp 1
```

```plaintext
position sfen lns1+B2n1/2gk2sbl/p1p6/3r3pp/1p2g2PP/1SP1ppP2/PP1RPPG1N/L2P5/1N1KG1S1L w Pp 1
```

# 異常終了_20230423

👇 サーチ部で強制終了 ----> サーチの Undo move 忘れ  

```plaintext
position startpos moves 7i7h 3c3d 6i7i 2b7g+ 5i6i 7g6g

# このあと
go
```

# 異常終了_20230423_2002

```plaintext
position startpos moves 2h7h 8b4b 6i6h 3a3b 1i1h 6a7b 2g2f 7b8b 5i5h 2c2d 7g7f 4c4d 4g4f 6c6d 8h5e 1c1d 1g1f 4b6b 5e7g 5a4b 4i3h 8c8d 4f4e 1d1e 3g3f 3c3d 7g4d 4a5b 3i2h 9c9d 3h4g 2b3c 5g5f 5b5a 4g4f 9a9c 4f5e 3b4c 6h5g 6d6e 4d5c+ 4b5c 5h6h B*4h 5g4f 4h3g 2h1g 1a1b 7f7e 3g1i+ 5e4d 4c4d 8i7g 3c2b 6h6i G*8h 2i3g 3d3e 7h3h 5c4c 3h6h 4c3d 6h8h 5a4b G*4a 6b7b 3g2e 1i4f 8h4h 4f4g 6i6h 2b1a 2e1c G*6d 3f3e 3d2c 4h2h 1a3c 8g8f 4g5f 4a5a P*4g 7i8h 9d9e 3e3d 7b6b 8f8e 5f5g 6h7h 5g4h 9i9h 4h2f P*5d P*5g 7h6h 2f3g 8h7i 4d4e 2h2f 4e5f 5a5b 5f6g+ 6h6g 4b4a 7e7d 4g4h P*2e 6b6c S*5a 2c3b 5a6b 6d7e 6b7a+ 3c5e 2f2i 3g4f S*8i 4a4b P*6b 6c6d 8i8h 4f4g 2e2d P*3e 7g6e 5e3g 2d2c+ 3b3a 5b5c 6d7d 1g2f P*6a P*2h 4b5c P*7g 4g4f 9g9f G*4a 2c2d 3g2f 1f1e 4h4i+ 2i4i S*1g 5d5c 1g1h 6e7c 4a5a 6g7h 3e3f 4i4h L*8f P*4e 8b7b 7h6h P*1g G*9a 7d5d 9a8a 7b6b 1e1d 6b7c N*6c 1h2g 9f9e P*4c P*6d 5d3d 2h2g 5g5h S*5g 2f4h 8h9i 4f1i 5g4h N*9f 5c5b R*7f B*9d 7c8c P*3h 9f8h+ 2g2f 8h9h 7g7f 5a4b 7i7h 3d5d 6h6i L*3c R*7c 1b1c 6i7i 8c9d 7c7b+ 1i1h 6c5a+ 4b3b 6d6c B*6g 7i6i 1h2i 5a6a 3b4b 8e8d 9d8d 2d3c 9h9i 4h5i P*7g L*8c 8d8c 3c3d S*7i P*8d 4b5c 8d8c L*6d 5i5h 9i8i 6c6b N*2d 5h6g P*5a G*5e 5d5e B*2c G*5h

# このあと
go
```

関数名が、

```plaintext
  def choice_best(pos, [move | move_list], sibling_best_move \\ nil, sibling_best_value \\ -32768) do
```

にマッチしないケースが出る。

# 歩を114枚持ってる？ ----> パーサー書き直したから

```plaintext
position sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/2P6/PP1PPPPPP/1B5R1/LNSGKGSNL w - 1
```

```plaintext
position startpos moves 7g7f

# のあと
go
```

```plaintext
position startpos moves 7g7f 3c3d

# のあと
go
```

# 分からん

undoで持ち駒減ってない  

```plaintext
position sfen lnsgk1snl/6B2/ppppppgpp/6p2/9/2P2P3/PP1PP1PPP/2S6/LN1bKGSNL w Rrg 1

go
```

```plaintext
position startpos moves 7g7f 3c3d 8h2b+ 8b2b B*1e 4a4b 1e3c 4b3c 7i7h B*4f 4g4f B*1d

go
```

# テストでバグ。わからん

```plaintext
>1:position startpos moves 1g1f 3c3d 2g2f 2b7g 8i7g 9c9d 7g6e
>1:go btime 880000 wtime 884000 binc 5000 winc 5000
<1:[1 moves / Gote / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  | 1|
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g| k| g| s| n| l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | r|  |  |  |  |  |  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | p| p| p| p| p|  | p| p| c
<1:+--+--+--+--+--+--+--+--+--+
<1:| p|  |  |  |  |  | p|  |  | d
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  | N|  |  |  |  |  | e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  | P| P| f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| P| P|  |  | g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | B|  |  |  |  |  | R|  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| L|  | S| G| K| G| S| N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  |  | 1|  |  |  |  |  |
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v51
<1:record  1g1f 3c3d 2g2f 2b7g<P> 8i7g<B> 9c9d 7g6e
<1:value seen from gote -1400
<1:[Go do_it] value:-1400
<1:[1 moves / Gote / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  | 1|
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g| k| g| s| n| l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | r|  |  |  |  |  |  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | p| p| p| p| p|  | p| p| c
<1:+--+--+--+--+--+--+--+--+--+
<1:| p|  |  |  |  |  | p|  |  | d
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  | N|  |  |  |  |  | e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  | P| P| f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| P| P|  |  | g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | B|  |  |  |  |  | R|  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| L|  | S| G| K| G| S| N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  |  | 1|  |  |  |  |  |
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v51
<1:record  1g1f 3c3d 2g2f 2b7g<P> 8i7g<B> 9c9d 7g6e
<1:value seen from gote -1400
<1:[Go do_it] value:1700
<1:bestmove N*1d
>T:-0014KE
<T:#ILLEGAL_MOVE
<T:#LOSE
>1:gameover lose
>T:%%GAME floodgate-900-5F *
<T:##[ERROR] unknown command: %%GAME floodgate-900-5F *
<1:[Go do_it] value:-600
<1:bestmove 9d9e
<1:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover lose
>1:quit
>T:LOGOUT
<T:LOGOUT:completed
```

# 分からん

```plaintext
>1:position startpos moves 7g7f 3c3d 8h2b+ 8b2b B*1e 2a3c 1e3c 2b4b N*1d 1c1d 3c4b+ 4a4b
>1:go btime 739000 wtime 870000 binc 5000 winc 5000
<1:info score cp 1500 string 
<1:bestmove 3c4b+
>1:gameover lose
>1:quit
>2:gameover win
>2:quit
<2:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover win
<1:[1 moves / Sente / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  | 2|  |  | 1|  |  |
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g| k|  | s|  | l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  | g|  |  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:| p| p| p| p| p| p|  | p|  | c
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  | p|  | p| d
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  | P|  |  |  |  |  |  | f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| P| P| P| P| g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  | R|  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| L| N| S| G| K| G| S| N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  | 1|  |  |  |  |  |  |
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v51
<1:record  7g7f 3c3d 8h2b+<B> 8b2b<+B> B*1e 2a3c 1e3c<N> 2b4b N*1d 1c1d<N> 3c4b+<R> 4a4b<+B>
<1:value seen from sente 200
<1:[Go do_it] value:200
<1:[1 moves / Sente / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  | 2|  |  | 1|  |  |
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g| k|  | s|  | l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  | g|  |  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:| p| p| p| p| p| p|  | p|  | c
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  | p|  | p| d
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  | P|  |  |  |  |  |  | f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| P| P| P| P| g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  | R|  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| L| N| S| G| K| G| S| N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  | 1|  |  |  |  |  |  |
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v51
<1:record  7g7f 3c3d 8h2b+<B> 8b2b<+B> B*1e 2a3c 1e3c<N> 2b4b N*1d 1c1d<N> 3c4b+<R> 4a4b<+B>
<1:value seen from sente 200
<1:info score cp 1100 string 
<1:bestmove R*1b
<1:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover lose
```

```plaintext
position sfen lnsgk1s1l/5g3/pppppp1p1/6p1p/9/2P6/PP1PPPPPP/7R1/LNSGKGSNL b R2bn 1

go
```

# 後手が先手の角を打ってしまう

```
position startpos moves 7g7f 3c3d 8h2b+ 8b2b B*8d B*1e 7i7h 8c8d 6g6f 9c9d 1i1h 9d9e 2g2f 1e2f 2h2f B*6g 2f2c

position sfen lnsgkgsnl/7r1/2pppp1Rp/1p4p2/p8/2PP5/PP1bPPP1P/2S5L/LN1GKGSN1 w BPp 1
```

```
>2:position startpos moves 7g7f 3c3d 8h2b+ 8b2b B*8d B*1e 7i7h 8c8d 6g6f 9c9d 1i1h 9d9e 2g2f 1e2f 2h2f B*6g 2f2c
>2:go btime 1197000 wtime 1177000 binc 2000 winc 2000
<2:[18 moves / Gote / 0 repeat(s)]
<2:  k  r  b  g  s  n  l  p
<2:+--+--+--+--+--+--+--+--+
<2:|  |  |  |  |  |  |  | 1|
<2:+--+--+--+--+--+--+--+--+
<2:  9  8  7  6  5  4  3  2  1
<2:+--+--+--+--+--+--+--+--+--+
<2:| l| n| s| g| k| g| s| n| l| a
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  |  |  |  |  |  | r|  | b
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  | p| p| p| p|  | R| p| c
<2:+--+--+--+--+--+--+--+--+--+
<2:|  | p|  |  |  |  | p|  |  | d
<2:+--+--+--+--+--+--+--+--+--+
<2:| p|  |  |  |  |  |  |  |  | e
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  | P| P|  |  |  |  |  | f
<2:+--+--+--+--+--+--+--+--+--+
<2:| P| P|  | b| P| P| P|  | P| g
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  | S|  |  |  |  |  | L| h
<2:+--+--+--+--+--+--+--+--+--+
<2:| L| N|  | G| K| G| S| N|  | i
<2:+--+--+--+--+--+--+--+--+--+
<2:     K  R  B  G  S  N  L  P
<2:   +--+--+--+--+--+--+--+--+
<2:   |  |  | 1|  |  |  |  | 1|
<2:   +--+--+--+--+--+--+--+--+
<2:king_sq ^59 v51
<2:record  7g7f 3c3d 8h2b+<B> 8b2b<+B> B*8d B*1e 7i7h 8c8d<B> 6g6f 9c9d 1i1h 9d9e 2g2f 1e2f<P> 2h2f<B> B*6g 2f2c<P>
<2:value seen from gote 0
<2:Teban is lose? false
<2:Aiteban is lose? false
<2:[Go do_it] value:0
<2:[18 moves / Gote / 0 repeat(s)]
<2:  k  r  b  g  s  n  l  p
<2:+--+--+--+--+--+--+--+--+
<2:|  |  |  |  |  |  |  | 1|
<2:+--+--+--+--+--+--+--+--+
<2:  9  8  7  6  5  4  3  2  1
<2:+--+--+--+--+--+--+--+--+--+
<2:| l| n| s| g| k| g| s| n| l| a
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  |  |  |  |  |  | r|  | b
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  | p| p| p| p|  | R| p| c
<2:+--+--+--+--+--+--+--+--+--+
<2:|  | p|  |  |  |  | p|  |  | d
<2:+--+--+--+--+--+--+--+--+--+
<2:| p|  |  |  |  |  |  |  |  | e
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  | P| P|  |  |  |  |  | f
<2:+--+--+--+--+--+--+--+--+--+
<2:| P| P|  | b| P| P| P|  | P| g
<2:+--+--+--+--+--+--+--+--+--+
<2:|  |  | S|  |  |  |  |  | L| h
<2:+--+--+--+--+--+--+--+--+--+
<2:| L| N|  | G| K| G| S| N|  | i
<2:+--+--+--+--+--+--+--+--+--+
<2:     K  R  B  G  S  N  L  P
<2:   +--+--+--+--+--+--+--+--+
<2:   |  |  | 1|  |  |  |  | 1|
<2:   +--+--+--+--+--+--+--+--+
<2:king_sq ^59 v51
<2:record  7g7f 3c3d 8h2b+<B> 8b2b<+B> B*8d B*1e 7i7h 8c8d<B> 6g6f 9c9d 1i1h 9d9e 2g2f 1e2f<P> 2h2f<B> B*6g 2f2c<P>
<2:value seen from gote 0
<2:Teban is lose? false
<2:Aiteban is lose? false
<2:info depth 2 nodes 572448 score cp 13500 nps 5090 string Single thread!
<2:bestmove R*3h
>1:gameover win
>1:quit
>2:gameover lose
>2:quit
<1:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover win
<2:info depth 2 time 11315 nodes 242880 score cp 16000 nps 21465 string Single thread!
<2:bestmove 2b2c
<2:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover lose
```

# 王手放置して３五桂打

```
lnsg1gs1l/9/1ppk3pp/6p2/p7+B/2PR5/PP1PPRPPP/9/LNSGKG1NL w BS3Pnp 1
```

```
>1:position startpos moves 7g7f 3c3d 8h2b+ 8b2b B*4e B*1e 4e6c+ 9c9d 6c5c 9d9e 5c4c 2a3c 4c3c 2b4b N*6c 5a5b 3c1e 4b4g 3i4h 4g4h 2h4h S*4g 4h4g 5b6c R*6f
>1:go btime 963000 wtime 1018000 binc 2000 winc 2000
<1:[26 moves / Gote / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  | 1|  | 1|
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g|  | g| s|  | l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | p| p| k|  |  |  | p| p| c
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  | p|  |  | d
<1:+--+--+--+--+--+--+--+--+--+
<1:| p|  |  |  |  |  |  |  |+B| e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  | P| R|  |  |  |  |  | f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| R| P| P| P| g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| L| N| S| G| K| G|  | N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  |  | 1|  | 1|  |  | 3|
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v63
<1:record  7g7f 3c3d 8h2b+<B> 8b2b<+B> B*4e B*1e 4e6c+<P> 9c9d 6c5c<P> 9d9e 5c4c<P> 2a3c 4c3c<N> 2b4b N*6c 5a5b 3c1e<B> 4b4g<P> 3i4h 4g4h<S> 2h4h<R> S*4g 4h4g<S> 5b6c<N> R*6f
<1:value seen from gote -3900
<1:Teban is lose? true
<1:Aiteban is lose? false
<1:[Go do_it] value:-3900
<1:[26 moves / Gote / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  | 1|  | 1|
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g|  | g| s|  | l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:|  | p| p| k|  |  |  | p| p| c
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  | p|  |  | d
<1:+--+--+--+--+--+--+--+--+--+
<1:| p|  |  |  |  |  |  |  |+B| e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  | P| R|  |  |  |  |  | f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| R| P| P| P| g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| L| N| S| G| K| G|  | N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  |  | 1|  | 1|  |  | 3|
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v63
<1:record  7g7f 3c3d 8h2b+<B> 8b2b<+B> B*4e B*1e 4e6c+<P> 9c9d 6c5c<P> 9d9e 5c4c<P> 2a3c 4c3c<N> 2b4b N*6c 5a5b 3c1e<B> 4b4g<P> 3i4h 4g4h<S> 2h4h<R> S*4g 4h4g<S> 5b6c<N> R*6f
<1:value seen from gote -3900
<1:Teban is lose? true
<1:Aiteban is lose? false
<1:info depth 2 time 24081 nodes 139530 score cp -2700 nps 5794 string Single thread!
<1:bestmove N*3e
>1:gameover lose
>1:quit
<1:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover lose
```

# 利きへ飛び込んだ

```
position startpos moves 2g2f 9c9d 7g7f 9d9e 2f2e 5c5d 2e2d 4a3b 2d2c+ 3b2c 2h2c+ 8b9b 2c2d 9b9c 8h3c+ 2b3c 2d2a 3c9i 2a3a 5a5b 3a3b 5b5c N*4e 5c4d S*5c
```

```
>1:position startpos moves 2g2f 9c9d 7g7f 9d9e 2f2e 5c5d 2e2d 4a3b 2d2c+ 3b2c 2h2c+ 8b9b 2c2d 9b9c 8h3c+ 2b3c 2d2a 3c9i 2a3a 5a5b 3a3b 5b5c N*4e 5c4d S*5c
>1:go btime 849000 wtime 839000 binc 5000 winc 5000
<1:[26 moves / Gote / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  | 1|  |  |  | 1| 1|
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g|  |  |  |  | l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |+R|  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:| r| p| p| p| S| p|  |  | p| c
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  | p| k|  |  |  | d
<1:+--+--+--+--+--+--+--+--+--+
<1:| p|  |  |  |  | N|  |  |  | e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  | P|  |  |  |  |  |  | f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| P| P|  | P| g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| b| N| S| G| K| G| S| N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  |  |  | 1|  |  |  | 2|
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v44
<1:record  2g2f 9c9d 7g7f 9d9e 2f2e 5c5d 2e2d 4a3b 2d2c+<P> 3b2c<+P> 2h2c+<G> 8b9b 2c2d 9b9c 8h3c+<P> 2b3c<+B> 2d2a<N> 3c9i<L> 2a3a<S> 5a5b 3a3b 5b5c N*4e 5c4d S*5c
<1:value seen from gote -500
<1:Teban is lose? true
<1:Aiteban is lose? false
<1:[Go do_it] value:-500
<1:[26 moves / Gote / 0 repeat(s)]
<1:  k  r  b  g  s  n  l  p
<1:+--+--+--+--+--+--+--+--+
<1:|  |  | 1|  |  |  | 1| 1|
<1:+--+--+--+--+--+--+--+--+
<1:  9  8  7  6  5  4  3  2  1
<1:+--+--+--+--+--+--+--+--+--+
<1:| l| n| s| g|  |  |  |  | l| a
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |+R|  |  | b
<1:+--+--+--+--+--+--+--+--+--+
<1:| r| p| p| p| S| p|  |  | p| c
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  | p| k|  |  |  | d
<1:+--+--+--+--+--+--+--+--+--+
<1:| p|  |  |  |  | N|  |  |  | e
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  | P|  |  |  |  |  |  | f
<1:+--+--+--+--+--+--+--+--+--+
<1:| P| P|  | P| P| P| P|  | P| g
<1:+--+--+--+--+--+--+--+--+--+
<1:|  |  |  |  |  |  |  |  |  | h
<1:+--+--+--+--+--+--+--+--+--+
<1:| b| N| S| G| K| G| S| N| L| i
<1:+--+--+--+--+--+--+--+--+--+
<1:     K  R  B  G  S  N  L  P
<1:   +--+--+--+--+--+--+--+--+
<1:   |  |  |  | 1|  |  |  | 2|
<1:   +--+--+--+--+--+--+--+--+
<1:king_sq ^59 v44
<1:record  2g2f 9c9d 7g7f 9d9e 2f2e 5c5d 2e2d 4a3b 2d2c+<P> 3b2c<+P> 2h2c+<G> 8b9b 2c2d 9b9c 8h3c+<P> 2b3c<+B> 2d2a<N> 3c9i<L> 2a3a<S> 5a5b 3a3b 5b5c N*4e 5c4d S*5c
<1:value seen from gote -500
<1:Teban is lose? true
<1:Aiteban is lose? false
<1:[0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.
<1: 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]
<1:info depth 2 time 19773 nodes 162196 score cp 32768 nps 8202 string The remainder of the 26(th) move divided by 10 is 6.Hello GPU! I use PyCUDA on Python. 1 time before the start of the search. (I just made a table cleared by zero) Ok.
<1:bestmove 4d3c
>T:-4433OU
<T:#ILLEGAL_MOVE
<T:#LOSE
>1:gameover lose
>T:%%GAME floodgate-900-5F *
<1:Hi! I am a Kifuwarabe. It's start! first_token[gameover] input:gameover lose
<T:##[ERROR] unknown command: %%GAME floodgate-900-5F *
>T: 
>T: 
>T: 
>T: 
>1:quit
>T:LOGOUT
<T:LOGOUT:completed
```
