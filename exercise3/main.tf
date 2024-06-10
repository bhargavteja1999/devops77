
resource "aws_key_pair" "example_keypair" {
  key_name   = var.KEYNAME
  public_key = tls_private_key.example_keypair.public_key_openssh
}

resource "tls_private_key" "example_keypair" {
  algorithm = "RSA"
}

resource "local_file" "private_key_file" {
  content  = tls_private_key.example_keypair.private_key_pem
  filename = "venus.pem"
}

resource "aws_security_group" "example_security_group" {
  name        = "venus-security-group"
  description = "Example Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example_instance" {
  ami                    = "ami-09e67e426f25ce0d7" # Ubuntu 20.04 LTS in us-east-1 (N. Virginia) region
  instance_type          = var.MICRO
  key_name               = aws_key_pair.example_keypair.key_name
  vpc_security_group_ids = [aws_security_group.example_security_group.id]

  tags = {
    Name = "venus-instance"
  }
}
