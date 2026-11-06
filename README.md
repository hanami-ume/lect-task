# lect-task · 密码安全与数据安全 · 配套练习

面向 2026“经纬杯”交通运输网络安全大赛决赛 B 组团队赛培训的配套练习题。
配套讲义幻灯片：https://hanami-ume.github.io/

## 目录结构

```
challenges/            题面与附件（发给学员的部分）
  01-classic-encoding/   编码与古典密码识别
  02-sm2-keymatch/       SM2 签名与公钥匹配   （真题第 7 题）
  03-cert-read/          读懂一张数字证书
  04-pcap-pii/           流量中的明文敏感数据 （真题第 6 题）
  05-mask-export/        脱敏导出与文件指纹   （综合防御 13/14）
solutions/             题解与参考答案（教师用，勿发学员）
tools/                 gm.py（教学 SM2/SM3）、pcap_summary.py（离线看流量）
deploy/                在服务器上布置练习环境的脚本
```

## 方向与真题对应

| 题 | 方向 | 对应 2025 真题 |
|---|---|---|
| 01 | 密码安全 · 古典密码 | — |
| 02 | 密码安全 · 国密 SM2 | 运维实操第 7 题 |
| 03 | 数据安全 · 数字证书 | 运维实操“数字证书” |
| 04 | 数据安全 · 敏感数据识别 | 运维实操第 6 题 |
| 05 | 数据安全 · 脱敏与共享 | 综合防御 域控 13/14 |

## 怎么做题

**本地**：进入对应 `challenges/<题>/` 目录，读 `README.md`，按提示用 CyberChef / Wireshark / OpenSSL / Python 完成。

**SSH 到练习机**：
```
ssh player@47.103.190.211
cd ~/challenges/01-classic-encoding
cat README.md
```
练习机上只有题面和附件，没有题解。所需工具（python3、openssl、tshark）已装好。

## 说明
题目数据（姓名、证件号、手机号、域名、证书、流量）均为按真题考点构造的教学数据，不对应真实人员或系统。
