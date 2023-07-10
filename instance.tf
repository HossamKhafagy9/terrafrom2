data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "public-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.Type
  subnet_id              = local.public_subnet
  vpc_security_group_ids = [aws_security_group.terraform_securityGroup.id]
  source_dest_check      = false
  associate_public_ip_address = true
  user_data = file("apache.sh")
  tags = {
    Name = "nginx"
  }
}
resource "aws_instance" "private-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.Type
  subnet_id              = local.private_subnet
  vpc_security_group_ids = [aws_security_group.terraform_securityGroup.id]
  source_dest_check      = false
  associate_public_ip_address = false
  
  user_data = file("apache.sh")
  
  
  tags = {
    Name = "appache"
  }
}