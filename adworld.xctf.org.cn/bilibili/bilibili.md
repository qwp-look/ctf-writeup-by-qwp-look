# Bilibili CTF 分析

## 原理
（请补充原理描述）

## 目标
（请补充目标描述）

## 环境
- **操作系统**: Windows 11 LTSC

## 工具
- **浏览器**: Edge
- **抓包工具**: Burp Suite Pro v2023.4.5

## 步骤
1. 发现它提示我们购买 LV6（见图 1）。
2. 简单浏览了几个页面，没有发现 LV6，但发现网页的格式为：
   ```
   http://223.112.5.141:65401/shop?page=2
   ```
3. 右键检查查看 LV2（见图 2），发现其格式为 `lv2.png`。
4. 思考后，编写了一个 Python 脚本进行寻找（见附件）。
5. 找到了 LV6 的藏身地（见图 3）。
6. 发现 LV6 太贵了，买不起（见图 4）。
7. 抓包分析（见图 5）。
8. 在抓包中看到以下内容：
   ```
   _xsrf=2%7C192495af%7Ca360e7751666bff8b45cc8656908f68e%7C1753090587&id=1624&price=1145141919.0&discount=0.8
   ```
9. 尝试修改折扣为 `0.000000000000000001`。
10. 修改后跳转到了以下页面：
    ```
    http://223.112.5.141:65401/b1g_m4mber
    ```
    （见图 6）。
11. 重新抓包分析（见图 7）。
12. 发现以下信息：
    - **Host**: `223.112.5.141:65401`
    - **Cookie** 中包含 JWT：
      ```
      eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InF3cC1sb29rIn0.Kc_vKQp-E_69qRoid2s4yAw3ZF2RRIc3FXxhvOdRFPQ
      ```
    - 还有一个 `commodity_id` 的 Cookie，其值是一个序列化字符串，看起来像是 Django 的签名结构。
13. 解密 JWT：
    - Header: `{"alg":"HS256","typ":"JWT"}`
    - Payload: `{"username":"qwp-look"}`

## 图片
1. ![提示购买 LV6]({DC14316E-A960-4914-9E45-5B74DA34D182}.png)
2. ![网页格式]({6FE61287-DD6F-473D-B749-8B18D76545EF}.png)
3. ![找到 LV6]({03227792-26AE-4E7F-B7B7-DF1C1876301E}.png)
4. ![LV6 太贵]({14D3AD11-2C52-462D-A2BE-58A6C9C169A4}.png)
5. ![抓包分析](image.png)
6. ![跳转页面](image-1.png)

## 答案
（请补充答案）
