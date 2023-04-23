# Move test

## 成らないと移動先のない駒になるとき、成るかテスト

👇 `1b1a+`  

```plaintext
position sfen k8/8P/9/9/9/9/1+r7/9/K8 b r2b4g4s4n4l17p 1
```

## 成り駒が、成ろうとしないかのテスト

👇 `▲と金`  

```plaintext
position sfen k8/7+P1/9/9/9/9/1+r7/9/K8 b r2b4g4s4n4l17p 1
```

## 持ち駒を打つテスト

👇 `▲歩`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b Pr2b4g4s4n4l17p 1
```

👇 `▲香`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b Lr2b4g4s4n3l18p 1
```

👇 `▲桂`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b Nr2b4g4s3n4l18p 1
```

👇 `▲銀`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b Sr2b4g3s4n4l18p 1
```

👇 `▲金`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b Gr2b3g4s4n4l18p 1
```

👇 `▲角`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b Brb4g4s4n4l18p 1
```

👇 `▲飛`  

```plaintext
position sfen 8k/9/9/9/9/9/7+r1/9/8K b R1b4g4s4n4l18p 1
```

# 打ち歩詰めしないことのテスト

```plaintext
position sfen 7lk/7l1/7lK/7r1/9/9/9/9/9 b Pr2b4g4s4nl17p 1
```

# 駒得しようとするかのテスト

👇 アンドゥ・ムーブでちゃんと評価値を戻すようにして修正済

```plaintext
position sfen 1nsk1ggnl/l2r1s1b1/1ppp+N1ppp/p3pp3/1P7/2PP1P1P1/P3P1P1P/1B2RK2L/L1SGG1SN1 w - 1
```
