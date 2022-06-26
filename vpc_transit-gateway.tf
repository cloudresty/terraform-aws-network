#
# Transit Gateway
#

resource "aws_ec2_transit_gateway" "default" {

    count       = var.vpc_transit_gateway_enabled ? 1 : 0
    description = var.vpc_transit_gateway_description

    tags = merge(var.vpc_transit_gateway_tags,{

        Name = (var.project_id !="" ? "${var.vpc_transit_gateway_name}-${var.project_id}" : "${var.vpc_transit_gateway_name}")

    })

}

#
# Transit Gateway VPC Attachment
#

resource "aws_ec2_transit_gateway_vpc_attachment" "default" {

    count               = var.vpc_transit_gateway_vpc_attachment_enabled ? 1 : 0
    vpc_id              = var.vpc_transit_gateway_vpc_attachment_vpc_id
    subnet_ids          = var.vpc_transit_gateway_vpc_attachment_subnet_ids
    transit_gateway_id  = aws_ec2_transit_gateway.default[0].id

    tags = merge(var.vpc_transit_gateway_vpc_attachment_tags,{

        Name = (var.project_id !="" ? "${var.vpc_transit_gateway_vpc_attachment_name}-${var.project_id}" : "${var.vpc_transit_gateway_vpc_attachment_name}")

    })

}