//create aws vpc
resource "aws_vpc" "terra_vpc" {
    cidr_block = "10.10.0.0/24"
  }

  // create aws subnet
  resource "aws_subnet" "mypublic_subnet" {
    vpc_id = aws_vpc.terra_vpc.id
    cidr_block = "10.10.0.0/24"

    tags = {
      name = "mypublic_subnet"
    }
  }
  resource "aws_subnet" "myprivate_subnet" {
    vpc_id = aws_vpc.terra_vpc.id
    cidr_block = "10.10.1.0/24"

    tags = {
        name = "myprivate_subnet"
    }
}

//create aws internet gatway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.terra_vpc.id

    tags = {
      name = "my_igw"
    }
}

//create aws route table
resource "aws_route_table" "my_route" {
    vpc_id = aws_vpc.terra_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }

    tags = {
      name = "my_route"
    }
}


//associate subnet with route table
resource "aws_route_table_association" "my_route_association" {
    subnet_id = aws_subnet.mypublic_subnet.id
    route_table_id = aws_route_table.my_route.id
  
}