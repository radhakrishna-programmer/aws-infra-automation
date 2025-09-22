provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name           = "webserver"
  ami            = "ami-0360c520857e3138f"
  instance_type  = "t2.micro"
  subnet_id      = element(module.vpc.public_subnets, 0)
  key_name       = "key1"
  create_security_group = true
  associate_public_ip_address = true
security_group_ingress_rules = {
    ssh = {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"  
    }
    http = {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3
              EOF
}


