data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    exec > /var/log/user-data.log 2>&1
    dnf update -y
    dnf install -y nodejs npm git
    cd /home/ec2-user
    git clone https://github.com/AlfredoZC/legacy-users.git app
    cd app
    npm install
    nohup node app.js > /var/log/app.log 2>&1 &
  EOF

  tags = {
    Name = "legacy-users-server"
  }
}