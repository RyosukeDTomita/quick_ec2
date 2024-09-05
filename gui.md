# 最低限のEC2インスタンスを作りたい

## 要件

- SSMでつなげること。
- 何かしら外部からアクセスする用のサービスを起動すること

---

## ブラウザからの設定のチェックポイント

- インスタンスの種類: Amazon Linux 2023
- VPCが正しいか: IGWとかついてないと詰む。
- subnetがpublicか
- public IPの自動割当: on
- IAMロールをつける: `AmazonSSMManagedInstanceCore`がついているIAMロールであること
- Security Group: 80あたりをあけておく

---

### UserData

> [!NOTE]
> `EOF`を''で囲むことで変数展開を無効にしている。

```
#!/bin/bash
yum install -y docker
cat <<'EOF' > /etc/systemd/system/docker.httpd.service
[Unit]
Description=httpd Container
After=docker.service
Requires=docker.service
[Service]
Environment="CONTAINER_NAME=httpd-container"
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker stop ${CONTAINER_NAME}
ExecStartPre=-/usr/bin/docker rm ${CONTAINER_NAME}
ExecStartPre=/usr/bin/docker pull httpd
ExecStart=/usr/bin/docker run --rm --name ${CONTAINER_NAME} -p 80:80 httpd
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now docker.httpd
systemctl restart docker.httpd
systemctl daemon-reload
```
