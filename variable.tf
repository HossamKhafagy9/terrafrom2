
variable "subnet_cidr" {
  type = list(string)
}
variable "subnet_name" {
  type = list(string)
}
variable "Type"{
  default = "t2.micro"  
}
locals {
  public_subnet = aws_subnet.subnet_tera[0].id
  private_subnet = aws_subnet.subnet_tera[1].id
}