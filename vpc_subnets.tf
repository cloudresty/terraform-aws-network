#
# Subnet Resources
#

# Public Subnets

resource "aws_subnet" "public_subnet" {

    count                   = length(var.vpc_public_subnets)
    vpc_id                  = aws_vpc.default.id
    cidr_block              = element(var.vpc_public_subnets,count.index)
    availability_zone       = element(var.vpc_availability_zones,count.index)
    map_public_ip_on_launch = true
    
    tags = merge(var.vpc_public_subnet_tags,{

        Name = (var.project_id !="" ? "${var.vpc_public_subnets_prefix_name}-${element(var.vpc_availability_zones, count.index)}-${var.project_id}" : "${var.vpc_public_subnets_prefix_name}-${element(var.vpc_availability_zones, count.index)}")

    })

}

# Private Subnets

resource "aws_subnet" "private_subnet" {

    count                   = length(var.vpc_private_subnets)
    vpc_id                  = aws_vpc.default.id
    cidr_block              = element(var.vpc_private_subnets,count.index)
    availability_zone       = element(var.vpc_availability_zones,count.index)
    map_public_ip_on_launch = false
    
    tags = merge(var.vpc_private_subnet_tags,{

        Name = (var.project_id !="" ? "${var.vpc_private_subnets_prefix_name}-${element(var.vpc_availability_zones,count.index)}-${var.project_id}" : "${var.vpc_private_subnets_prefix_name}-${element(var.vpc_availability_zones,count.index)}")

    })

}