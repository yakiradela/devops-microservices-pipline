resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_2" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = "10.0.2.0/24"
  availability_zone      = "us-east-2b"
   map_public_ip_on_launch = true
}

# 🆕 Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# 🆕 Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# 🆕 Associate route table with subnets
resource "aws_route_table_association" "public_1" {
  subnet_id              = aws_subnet.public_1.id
  route_table_id         = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id              = aws_subnet.public_2.id
  route_table_id         = aws_route_table.public.id
}
