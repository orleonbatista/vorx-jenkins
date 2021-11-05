data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["vorx-vpc-dev"]
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["vorx-vpc-dev-public-us-east-1a"]
  }
}

module "meu_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "EC2-SG-HTTP"
  description         = "SG for EC2 Instance with 80 port allowed."
  vpc_id              = data.aws_vpc.selected.id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "http-8080-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name    = "jenkins-server"

  ami                    = "ami-087c17d1fe0178315"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.meu_sg.security_group_id]
  subnet_id              = data.aws_subnet.selected.id
  user_data              = file("./install_dependencies.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_eip" "lb" {
  instance = module.ec2_instance.id
  vpc      = true

  tags = {
    Name   = "Jenkins-Server-EIP"
  }
}

