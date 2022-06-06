#
# Internet Gateway Resources
#

resource "aws_internet_gateway" "default" {

    vpc_id = aws_vpc.default.id

    tags = merge(var.vpc_internet_gateway_tags,

        {

            Name = (var.project_id !="" ? "${var.vpc_internet_gateway_name}-${var.vpc_region}-${var.project_id}": "${var.vpc_internet_gateway_name}-${var.vpc_region}")

        },

    )

}