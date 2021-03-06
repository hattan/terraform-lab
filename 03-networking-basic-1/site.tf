resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name      = "scale-main-vpc"
    Preferred = "true"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_subnet" "main" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = "${aws_vpc.main.id}"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags {
    Name = "main-vpc-subnet-01"
  }
}
