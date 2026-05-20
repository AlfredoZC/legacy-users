resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.iam_instance_profile

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nodejs npm
    mkdir -p /app
    cd /app
    cat > package.json << 'PKGJSON'
    {
      "name": "legacy-users",
      "version": "1.0.0",
      "description": "Sistema Legacy de Usuarios",
      "main": "app.js",
      "scripts": {
        "start": "node app.js",
        "test": "node test/app.test.js"
      },
      "dependencies": {
        "express": "^4.19.2"
      }
    }
    PKGJSON
    npm install
    cat > app.js << 'APPJS'
    const express = require('express');
    const app = express();
    const PORT = ${var.app_port};
    app.get('/', (req, res) => {
      res.json({ status: 'ONLINE', app: 'legacy-users', port: PORT });
    });
    app.listen(PORT, () => console.log('Server running on port ' + PORT));
    APPJS
    node app.js &
  EOF

  tags = {
    Name = "legacy-users-server"
  }
}