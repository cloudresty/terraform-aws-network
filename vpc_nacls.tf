#
# Network Access List Resources
#

resource "aws_network_acl" "private_subnet" {

    vpc_id      = aws_vpc.default.id
    subnet_ids  = aws_subnet.private_subnet.*.id

    egress {

        rule_no     = var.vpc_private_subnet_nacl_egress_rule_number
        action      = var.vpc_private_subnet_nacl_egress_action
        cidr_block  = var.vpc_private_subnet_nacl_egress_cidr
        from_port   = var.vpc_private_subnet_nacl_egress_from_port
        to_port     = var.vpc_private_subnet_nacl_egress_to_port
        protocol    = var.vpc_private_subnet_nacl_egress_protocol

    }

    ingress {

        rule_no     = var.vpc_private_subnet_nacl_ingress_rule_number
        action      = var.vpc_private_subnet_nacl_ingress_action
        cidr_block  = var.vpc_private_subnet_nacl_ingress_cidr
        from_port   = var.vpc_private_subnet_nacl_ingress_from_port
        to_port     = var.vpc_private_subnet_nacl_ingress_to_port
        protocol    = var.vpc_private_subnet_nacl_ingress_protocol

    }

    tags = merge(var.vpc_private_subnet_nacl_tags,

        {

            Name = (var.project_id !="" ? "${var.vpc_private_subnet_nacl_name}-${var.vpc_region}-${var.project_id}": "${var.vpc_private_subnet_nacl_name}-${var.vpc_region}")

        },

    )

}