data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnets" "public_subnet_1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
  tags = {
    Name = "default-a"  
  }
}

data "aws_subnets" "public_subnet_2" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
  tags = {
    Name = "default-c"  
  }
}

# Reuse an existing security group
resource "aws_security_group" "ec2_sg" {
  vpc_id = data.aws_vpc.existing_vpc.id  # Reference the existing VPC  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 8080  # Allow access to WordPress on port 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic on port 8080 from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "security-group-wordpress-dad"
  }
}
