provider "aws" {
  region = var.region
}

variable "key_pair_name" {}
variable "ssh_private_key" {}
variable "region" {
  default = "ap-south-1"
}

resource "aws_instance" "prod" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  tags = {
    Name = "genai-prod-ec2"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nodejs npm git nginx docker.io",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.ssh_private_key
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "staging" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  tags = {
    Name = "genai-staging-ec2"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nodejs npm git nginx docker.io",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.ssh_private_key
      host        = self.public_ip
    }
  }
}
