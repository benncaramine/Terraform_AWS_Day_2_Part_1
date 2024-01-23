# Terraform with AWS Day 2


This repository contains Terraform code to deploy a web server on AWS infrastructure. Follow the instructions below to set up and deploy the infrastructure.

![Alt text](screen-main.png)

## Designing the Infrastructure

### Provider File (`provider.tf`)

Create a new file named `provider.tf` in your working directory and copy the following code:

```hcl
provider "aws" {
  region  = var.region
  profile = "default"
}
```

This file sets the required AWS provider and version for resource provisioning.

### Variables File (variables.tf)
Create a new file named variables.tf and copy the following code:

```hcl
variable "region" {
  description = "The AWS region in which the resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "The availability zone where the resources will reside."
  type        = string
  default     = "us-east-1a"
}

variable "ami" {
  description = "The ID of the Amazon Machine Image (AMI) used to create the EC2 instance."
  type        = string
  default     = "ami-0261755***b8c4a84"
}

variable "instance_type" {
  description = "The type of EC2 instance used to create the instance."
  type        = string
  default     = "t2.micro"
}
```
This file contains variables used in the main Terraform configuration file (main.tf).

### Main File (main.tf)
Create a new file named main.tf and copy the Terraform configuration blocks. Click here to view main.tf.

This file defines the AWS resources, such as VPC, subnet, security group, EC2 instance, and more.

User Data File (user_data.sh)
Create a new file named user_data.sh and copy the following Bash script:

```bash
Copy code
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
echo "Deploy a web server on AWS" | sudo tee /var/www/html/index.html
This script is executed during EC2 instance launch to configure and start the Apache web server.
```

 ### Output File (output.tf)
Create a new file named output.tf and copy the following code:

```hcl
Copy code
output "vpc_id" {
    description = "VPC ID"
    value       = aws_vpc.terra_vpc.id
}

output "subnet_id" {
    description = "Subnet ID"
    value       = aws_subnet.terra_subnet.id
}

output "IGW_id" {
    description = "Internet Gateway ID"
    value       = aws_internet_gateway.terra_IGW.id
}

output "routetable_id" {
    description = "Route Table ID"
    value       = aws_route_table.terra_route_table.id
}

output "SG_id" {
    description = "Security Group ID"
    value       = aws_security_group.terra_SG.id
}

output "eip" {
    description = "Public IP of EIP"
    value       = aws_eip.terra_eip.public_ip
}

output "instance_id" {
    description = "ID of the EC2 instance"
    value       = aws_instance.terra_ec2.id
}

output "instance_public_ip" {
    description = "Public IP address of the EC2 instance"
    value       = aws_instance.terra_ec2.private_ip
}
```
This file declares outputs to display information about the created resources after Terraform provisioning.

## Deploying the Infrastructure
Follow these steps to deploy the infrastructure:

### Initialize Terraform:

```bash
terraform init
```

This command sets up the working directory and retrieves the necessary provider plugins.

### Plan the Deployment:

```bash
terraform plan
```
Review the output to ensure it aligns with your expectations.

### Deploy the Infrastructure:

```bash
terraform apply
```
Confirm the deployment by typing yes. Terraform will provision the AWS resources.

### Testing and Verifying the Web Server
Access the AWS Console and check the EC2 dashboard to ensure instances are launched and initialized.

Retrieve the public IP address of the EC2 instance and enter it in a web browser. Verify that the web server is accessible.

SSH into the EC2 instance using the private key file:

```hcl
chmod 700 <private-key-file.pem>
ssh -i <private-key-file.pem> ec2-user@<public-ip>
```
### Cleanup and Destruction
After testing, run the following command to destroy the resources:

```hcl
terraform destroy
```
Confirm the destruction by typing yes. Be cautious, as this command cannot be undone.

### Note: 
Ensure you have the necessary AWS credentials configured locally. Adjust variable values in variables.tf as needed for your environment.
