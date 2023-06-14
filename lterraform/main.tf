terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["/Users/fnaf6/Downloads/lterraform/.aws/credentials"]
}

resource "aws_instance" "app_server" {
  ami                    = "ami-076bca9dd71a9a578"
  instance_type          = "t2.micro"
  key_name               = "mykeyfile"
  vpc_security_group_ids = [aws_security_group.main.id]


  tags = {
    Name = var.instance_name
  }


}
resource "aws_security_group" "main" {

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 25565
    protocol    = "tcp"
    to_port     = 25565
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}