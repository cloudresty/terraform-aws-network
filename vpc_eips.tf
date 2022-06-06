#
# Elastic IP Resources for NAT Gateway
#

resource "aws_eip" "default" {

    count   = length(var.vpc_availability_zones)
    vpc     = true

    tags = merge(var.vpc_nat_eip_tags,

        {

            Name = (var.project_id !="" ? "${var.vpc_nat_eip_prefix_name}-${element(var.vpc_availability_zones,count.index)}-${var.project_id}": "${var.vpc_nat_eip_prefix_name}-${element(var.vpc_availability_zones,count.index)}")

        },

    )

    depends_on = [aws_internet_gateway.default]

}