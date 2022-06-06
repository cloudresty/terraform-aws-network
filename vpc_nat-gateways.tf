#
# NAT Gateway Resources
#

locals {
  
    eip_allocation = aws_eip.default.*.id

}

resource "aws_nat_gateway" "default" {

    count           = length(var.vpc_private_subnets)
    allocation_id   = element(local.eip_allocation, count.index)
    subnet_id       = element(aws_subnet.private_subnet.*.id, count.index)

    tags = merge(var.vpc_nat_gateway_tags,

        {

            Name = (var.project_id !="" ? "${var.vpc_nat_gateway_prefix_name}-${element(var.vpc_availability_zones, count.index)}-${var.project_id}": "${var.vpc_nat_gateway_prefix_name}-${element(var.vpc_availability_zones, count.index)}")

        },

    )

    depends_on      = [aws_eip.default, aws_subnet.private_subnet]

}