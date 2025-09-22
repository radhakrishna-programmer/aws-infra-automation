AWS Infrastructure Automation with Terraform & Ansible
Project Overview

This project demonstrates Infrastructure-as-Code (IaC) using Terraform to provision AWS resources and Ansible to configure and deploy a web server.
It automates the creation of a VPC, subnets, EC2 instances, security groups, and installs/configures Nginx on the EC2 instance using Ansible roles.

Project Structure
aws-infra-project/
│── terraform/
│   ├── main.tf           # Terraform configuration for VPC, subnets, EC2, security group
│   ├── variables.tf      # Terraform input variables
│   ├── outputs.tf        # Terraform output variables
│   └── terraform.tfvars  # Terraform variable values
│
│── ansible/
│   ├── ansible.cfg       # Configuration for roles path
│   ├── inventory.ini     # EC2 inventory
│   ├── playbook.yml      # Main playbook to configure webserver
│   └── roles/
│       └── webserver/
│           ├── tasks/
│           │   └── main.yml  # Tasks for installing and configuring Nginx
│           └── templates/
│               └── index.html.j2  # Custom HTML page for webserver
│
└── README.md

Prerequisites

AWS Account with access keys

Terraform installed (v1.5+ recommended)

Ansible installed (v2.15+ recommended)

SSH key pair for EC2 access

Terraform Steps

Initialize Terraform:

cd terraform
terraform init


Apply Terraform to create resources:

terraform apply


Enter yes to confirm.

Terraform will provision:

VPC with public subnets

EC2 instance with specified AMI

Security group allowing SSH & HTTP

Key pair

Outputs:

terraform output


ec2_public_ip: Public IP of the EC2 instance

Ansible Steps

Update inventory with EC2 public IP (from Terraform output):

[webservers]
<ec2_public_ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/key1.pem


Run the playbook:

cd ../ansible
ansible-playbook -i inventory.ini playbook.yml


Verify:

Open your browser:

http://<ec2_public_ip>


You should see the custom Nginx page deployed by Ansible.

Key Features

Infrastructure Automation: VPC, EC2, and security groups created via Terraform.

Configuration Management: Nginx installed and configured via Ansible roles.

Idempotent: Re-running Terraform or Ansible won’t break existing resources.

Custom Web Page: Deployed using Ansible templates.

Optional Next Steps

Integrate Terraform outputs directly into Ansible inventory to fully automate deployment.

Deploy multiple web servers or applications.

Add monitoring, logging, or additional security rules.

Cleanup

To destroy all resources:

cd terraform
terraform destroy
