# Rule Cover Check

# (__UchifuDumeCheck__) 打ち歩詰めしないことのテスト

```plaintext
position sfen +P+P+P+P+P+P+P+P1/PPPPPPPPk/9/6g1K/8L/8L/8L/8L/9 b P2r2b3g4s4np 1

go
```

0手読み（駒を動かさないで、次の１手を選ぶこと）で、指し手の一覧に `P*1c` が含まれ「る」  

```plaintext
[Think go] BELOW, MOVE LIST
===========================
> (2a1a)
> (1d1c)
> (1d2e)
> (1d2d)
> (1d2c)
> (P*1c)
> (P*1i)
```

何度か `go` を試みても、  
探索で `P*1c` は、直接的にも、枝刈りでも、除外されること  
