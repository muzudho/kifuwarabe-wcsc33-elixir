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
