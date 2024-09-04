# Quick start tiny EC2

![un license](https://img.shields.io/github/license/RyosukeDTomita/quick_ec2)

## INDEX

- [ABOUT](#about)
- [ENVIRONMENT](#environment)
- [PREPARING](#preparing)
- [HOW TO USE](#how-to-use)

---

## ABOUT

最低限の機能を持つEC2を構築するためのリポジトリです。

- SSMで接続できる
- Apacheが80番ポートで起動している

---

## ENVIRONMENT

Apacheをdockerでサービスとして起動してます。

---

## PREPARING

### install terraform

[公式のインストールガイド](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
[Linux版バイナリを取得](https://developer.hashicorp.com/terraform/install)

```shell
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

---

## HOW TO USE

### gui(do not use terraform)

read [gui.md](./gui.md)

### terraform

```shell
cd terraform
terraform init
terraform plan
terraform apply
```

```shell
curl EC2 IP
```
