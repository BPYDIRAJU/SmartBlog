resource "aws_instance" "web" {
  ami                         = "ami-0f58b397bc5c1f2e8" # Replace with correct AMI ID
  instance_type               = "t2.micro"
  key_name                    = "terraform-bot"
  subnet_id                   = aws_subnet.public_subnet_n1.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true


  user_data = <<-EOF
#!/bin/bash
set -e

APP_DIR="/home/ubuntu/smartblog"

# Update and install Python pip
apt-get update -y
apt-get install -y python3-pip

# Prepare application directory
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# Create Flask app
cat > application.py << 'APP'
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "SmartBlog running via Terraform!"
APP

# Create requirements.txt
echo -e "flask\\ngunicorn" > requirements.txt

# Install dependencies
pip3 install -r requirements.txt

# Start the app using gunicorn and log output
nohup gunicorn --bind 0.0.0.0:5000 application:app > /home/ubuntu/app.log 2>&1 &

# Log success
echo "✅ SmartBlog setup complete at \$(date)" >> /home/ubuntu/user-data.log
EOF


  tags = {
    Name = "Terraform-EC2"
  }
  lifecycle {
    ignore_changes = [user_data] # or something valid
  }

}

    