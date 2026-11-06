# 03 · 读懂一张数字证书

**方向**：数据安全（PKI / 数字证书）　**难度**：入门　**分值**：15

## 题面
附件是几张教学证书。请回答关于 `server.crt` 的问题：

1. 颁发者（Issuer）CN、使用者（Subject）CN、SAN 里的域名各是什么？
2. 有效期从哪天到哪天？在 2026-11-15 是否有效？
3. 公钥算法与长度、签名算法分别是什么？
4. 它是不是 CA 证书？依据哪个扩展？Key Usage 有哪些？
5. SHA-256 指纹的前 8 个 hex 是什么？
6. `server.crt`（PEM）与 `server.cer`（DER）内容相同，为什么文件大小不同？如何互转？
7. `old_server.crt` 为什么验证不过？
8. `sm2_demo.crt` 的签名算法是什么？公钥多少位？`04` 开头代表什么？为什么颁发者=使用者？

## 提交格式
按 1~8 逐条作答，指纹填前 8 个 hex。

## 提示
```
openssl x509 -in server.crt -noout -text
openssl x509 -in server.cer -inform DER -noout -text
openssl x509 -in server.crt -noout -fingerprint -sha256
openssl verify -CAfile root_ca.crt server.crt
```
没有 openssl 时直接看 `certs_text.txt`。
