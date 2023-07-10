# public route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc_tera.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route"
  }
}
resource "aws_route_table_association" "tera_a_route" {
  subnet_id      = local.public_subnet
  route_table_id = aws_route_table.public_route.id
}
/////////////////////////////////////////////////////////
#private route table

resource "aws_eip" "elastic_ip" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     =  local.public_subnet

  tags = {
    Name = "nat"
  }
}
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc_tera.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private_route"
  }
}
resource "aws_route_table_association" "association_tera" {
  subnet_id      =  local.private_subnet
  route_table_id = aws_route_table.private_route.id
}