provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg-0cc001deb9c666ad3" {
  name        = "launch-wizard-2"
  description = "security group for EC2 instance using terraform"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}

resource "aws_instance" "ec2-terraform" {
  ami           = "ami-07d9b9ddc6cd8dd30"  
  instance_type = "t2.micro"

  security_group_names = [aws_security_group.launch-wizard-2]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10  
  }
}
