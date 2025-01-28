data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnets" "fetch_subnet" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}