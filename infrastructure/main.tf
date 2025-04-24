# Variables
variable "my_ip" {
  description = "Your IP"
  type        = string
}

variable "key_name" {
  description = "Your Key Pair Name for SSH"
  type        = string
}

provider "aws" {
  region = "sa-east-1" # Your region
}

# default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group
resource "aws_security_group" "allow_access" {
  name        = "allow_access"
  description = "Allow SSH and HTTP access from my IP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    description = "HTTP FastAPI Access"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }

  tags = {
    Name = "allow_access"
  }
}

# EC2 Instance
resource "aws_instance" "fastapi_instance" {
  ami                         = "ami-0c67065b5ac5afe3a" # Amazon Linux 2023
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.allow_access.id]

  tags = {
    Name = "FastAPIDockerDevOps"
  }
}

# Output: Instance Public IP
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.fastapi_instance.public_ip
}
