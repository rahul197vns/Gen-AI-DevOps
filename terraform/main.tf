# 1. Configure the AWS provider
provider "aws" {
  region = "ap-south-1"
}

# 2. Generate an SSH key pair
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "my-terraform"
  public_key = tls_private_key.key.public_key_openssh
}

# 3. Security group to allow SSH (and HTTP, if needed)
resource "aws_security_group" "ssh" {
  name        = "allow_ssh_genai"
  description = "Allow SSH inbound"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Create two EC2 instances using count
resource "aws_instance" "app" {
  count         = 1
  ami           = "ami-0f918f7e67a3323f0"      # Example Ubuntu/Nginx AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "gen-ai-${count.index + 1}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nodejs npm git nginx docker.io",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
}
}
