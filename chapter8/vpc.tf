resource "aws_vpc" "main"{
  cidr_block = "10.0.0.0/16"

  tags ={
    Name ="terraform-101"
  }
}

resource "aws_subnet" "public_subnet"{
  vpc_id = aws_vpc.main.id
  cidr_block ="10.0.0.0/24"
  
  availability_zone ="ap-northeast-2a"

  tags ={
    Name= "terraform-101-public_subnet"
  }
}

resource "aws_subnet" "private_subnet"{
  vpc_id = aws_vpc.main.id
  cidr_block ="10.0.10.0/24"

  tags ={
    Name = "terraform-101-private_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags ={
    Name ="terraform-101-igw"
  }
}
resource "aws_eip" "name" {
  vpc =true

  lifecycle {
    create_before_destory =true
  }
}
resource "aws_nat_gateway" "nat_gateway"{
  allocation_id = aws_rip.nat.id
  subnet_id = aws_subnet.public_subnet.id

  tags={
    Name ="terraform-NATGW"
  }
}