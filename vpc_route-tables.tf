#
# Route Table Resources
#

# Public Route Table

resource "aws_route_table" "public" {

    vpc_id  = aws_vpc.default.id

    route {

        cidr_block = var.vpc_public_route_table_route_cidr
        gateway_id = aws_internet_gateway.default.id

    }

    tags = merge(var.vpc_public_route_table_tags,{

        Name = (var.project_id !="" ? "${var.vpc_public_route_table_prefix_name}-${var.vpc_region}-${var.project_id}" : "${var.vpc_public_route_table_prefix_name}-${var.vpc_region}")

    })

    depends_on = [aws_internet_gateway.default]

}

resource "aws_route_table_association" "public" {

    count           = length(var.vpc_public_subnets)
    subnet_id       = element(aws_subnet.public_subnet.*.id, count.index)
    route_table_id  = aws_route_table.public.id

}

# Private Route Tables

resource "aws_route_table" "private" {

    count   = length(var.vpc_private_subnets)
    vpc_id  = aws_vpc.default.id

    route {

        cidr_block      = var.vpc_private_route_table_route_cidr
        nat_gateway_id  = element(aws_nat_gateway.default.*.id, count.index)

    }

    tags = merge(var.vpc_private_route_table_tags,{

        Name = (var.project_id !="" ? "${var.vpc_private_route_table_prefix_name}-${element(var.vpc_availability_zones, count.index)}-${var.project_id}" : "${var.vpc_private_route_table_prefix_name}-${element(var.vpc_availability_zones, count.index)}")

    })

    depends_on = [aws_nat_gateway.default]

}

resource "aws_route_table_association" "private" {

    count           = length(aws_route_table.private)
    subnet_id       = element(aws_subnet.private_subnet.*.id, count.index)
    route_table_id  = element(aws_route_table.private.*.id, count.index)

}