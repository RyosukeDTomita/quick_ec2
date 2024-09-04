# NOTE: VPC，Security Group(80穴あけ済み)は一旦デフォルトのものを使う。
provider "aws" {
  region = "ap-northeast-1"
}


# IAM Role for EC2
resource "aws_iam_role" "ssm_role" {
  name = "example-ssm-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


# Attach the policy to IAM Role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# ec2
resource "aws_instance" "example" {
  ami           = "ami-00c79d83cf718a893"
  instance_type = "t3.micro"
  # attach IAM Role
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "sigma-ec2"
  }

  user_data = <<EOF
#!/bin/bash
yum install -y docker
cat <<EOF2 > /etc/systemd/system/docker.httpd.service
[Unit]
Description=httpd Container
After=docker.service
Requires=docker.service
[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker stop httpd-container
ExecStartPre=-/usr/bin/docker rm httpd-container
ExecStartPre=/usr/bin/docker pull httpd
ExecStart=/usr/bin/docker run --rm --name httpd-container -p 80:80 httpd
[Install]
WantedBy=multi-user.target
EOF2
systemctl enable --now docker.httpd
systemctl restart docker.httpd
systemctl daemon-reload
EOF
}


# IAM Instance Profile for EC2 to use SSM role
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "example-instance-profile"
  role = aws_iam_role.ssm_role.name
}
