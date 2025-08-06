provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "prod" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "your-key"

  tags = {
    Name = "genai-prod-ec2"
  }
}

resource "aws_instance" "staging" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "your-key"

  tags = {
    Name = "genai-staging-ec2"
  }
}
