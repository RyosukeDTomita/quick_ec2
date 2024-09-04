# Error log

## EC2のUserDataがうまくとりこめない

```
│ Error: Invalid reference
│
│   on test.tf line 19, in resource "aws_instance" "example":
│   19: ExecStartPre=-/usr/bin/docker stop ${CONTAINER_NAME}
│
│ A reference to a resource type must be followed by at least one
│ attribute access, specifying the resource name.
╵
╷
│ Error: Invalid reference
│
│   on test.tf line 20, in resource "aws_instance" "example":
│   20: ExecStartPre=-/usr/bin/docker rm ${CONTAINER_NAME}
│
│ A reference to a resource type must be followed by at least one
│ attribute access, specifying the resource name.
╵
╷
│ Error: Invalid reference
│
│   on test.tf line 22, in resource "aws_instance" "example":
│   22: ExecStart=/usr/bin/docker run --rm --name ${CONTAINER_NAME} -p 80:80 httpd
│
│ A reference to a resource type must be followed by at least one
│ attribute access, specifying the resource name.
╵
```
- $$にしてエスケープとかもうまくいかなかったので一旦ベタガキしている。

---

## terraformで指定しない時に選ばれるサブネットの仕様

- ap-northeast-1なら指定しないと1aが選ばれるのでこれをpublicにsubnetに所属させておかないとssmとか全部つながらなくなる。

---


