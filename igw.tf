# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_tera.id

  tags = {
    Name = "igw"
  }
}