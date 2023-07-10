# subnets
resource "aws_subnet" "subnet_tera" {
  count =length(var.subnet_cidr)
  vpc_id     = aws_vpc.vpc_tera.id
  cidr_block = var.subnet_cidr[count.index]

  tags = {
    Name = var.subnet_name[count.index]

  }
}