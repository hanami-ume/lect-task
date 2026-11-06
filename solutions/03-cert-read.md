# 题解 · 03 读懂一张数字证书

## 答案（server.crt）
1. Issuer CN = `Demo Transport Training Root CA`；Subject CN = `ticket.demo-rail.test`；SAN = `ticket.demo-rail.test`, `m.ticket.demo-rail.test`。
2. 有效期 `2026-03-01 ~ 2027-03-01`（UTC）；2026-11-15 **有效**。
3. 公钥 **RSA 2048 位**；签名算法 `sha256WithRSAEncryption`。
4. **不是** CA 证书（`Basic Constraints: CA:FALSE`）；Key Usage = Digital Signature, Key Encipherment；扩展用途 = TLS Web Server Authentication。
5. SHA-256 指纹前 8 位：**`955D1E2B`**。
6. PEM 是 DER 的 Base64 文本再加首尾行，所以比 DER 大约 4/3 倍；转换 `openssl x509 -in server.cer -inform DER -out server.pem`。
7. `old_server.crt` 已于 2025-06-30 过期（`certificate has expired`）。
8. `sm2_demo.crt`：签名算法 `SM2-with-SM3`；公钥 **256 位**；`04` 表示未压缩点（后接 x、y 各 32 字节）；颁发者=使用者说明是**自签名**证书（`CA:TRUE`）。

## 命令
```
openssl x509 -in server.crt -noout -text
openssl x509 -in server.crt -noout -fingerprint -sha256
openssl verify -CAfile root_ca.crt server.crt       # OK
openssl verify -CAfile root_ca.crt old_server.crt   # expired
```

## 知识点
- 证书字段里最常考：Issuer / Subject / Validity / 公钥算法 / 签名算法 / Key Usage / SAN。
- **指纹不是证书里的字段**，是对整张 DER 字节算的哈希；PEM 和 DER 指纹相同。
- 浏览器按 **SAN**（不是 CN）校验域名；还要校验有效期、吊销状态、信任链。
