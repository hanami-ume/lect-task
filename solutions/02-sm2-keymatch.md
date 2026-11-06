# 题解 · 02 SM2 签名与公钥匹配

## 答案
- `1-3、2-1、3-4、4-2`
- 第 5 条签名对应**公钥 2**。

## 思路

### 1. 读懂数据格式
- 公钥 `04‖x‖y`：去掉 `04` 后前 32 字节是 `x`，后 32 字节是 `y`。
- 签名 `rs`：前 64 hex 是 `r`，后 64 hex 是 `s`。**是拼接，不是 `r+s` 相加。**

### 2. 确定实际参与签名的 e
题干说开发者“直接对数据本身签名而非杂凑值”。所以 1~4 号签名真正用的是：
```python
e = int.from_bytes(M.encode("utf-8"), "big")
```
而 `signatures.json` 里的 `e` 字段（`SM3(M)`）并没有参与这 4 条签名。

### 3. 遍历验签
对每条签名 × 每个公钥做 SM2 验签（验签只需公钥）：
```python
import json, gm
keys=json.load(open("public_keys.json")); sigs=json.load(open("signatures.json"))
for s in sigs:
    r,ss=int(s["rs"][:64],16),int(s["rs"][64:],16)
    for k in keys:
        h=k["public_key"]; pub=(int(h[2:66],16),int(h[66:],16))
        e=int.from_bytes(s["M"].encode(),"big")        # 缺陷实现：消息本身
        if gm.verify_e(e,r,ss,pub): print(s["id"],"-> key",k["key_id"])
```
每条签名只有一个公钥能验过，得到唯一匹配。

### 4. 第 5 条是对照样本
第 5 条是**按规范签的**：`e = SM3(ZA‖M)`，其中
```
ZA = SM3(ENTL_A ‖ ID_A ‖ a ‖ b ‖ xG ‖ yG ‖ xA ‖ yA)，默认 ID = 1234567812345678
```
所以第 5 条要用 `e` 字段（即 `SM3(ZA‖M)`）才能验过，用“消息本身”验不过——正好和前 4 条相反。

## 知识点
- 验签通过只证明“签名与这个公钥匹配”，要证明“是某人签的”还需证书把公钥和身份绑定。
- 高层库（gmssl 的 `verify_with_sm3`）会自动算 `ZA + SM3`，与缺陷实现不兼容，调试时要用“对 e 直接验签”的底层接口。
- 真实整改：回到标准高层接口，别把 `SM3(M)` 或 `SHA256(M)` 随手当作 SM2 的 e。
