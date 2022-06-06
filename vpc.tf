#
# VPC Resources
#

resource "aws_vpc" "default" {

    cidr_block              = var.vpc_cidr_block
    instance_tenancy        = var.vpc_instance_tenancy
    enable_dns_support      = var.vpc_dns_support
    enable_dns_hostnames    = var.vpc_dns_hostnames
    enable_classiclink      = var.vpc_classiclink

    tags = merge(var.vpc_tags,

        {

            Name = (var.project_id !="" ? "${var.vpc_name}-${var.vpc_region}-${var.project_id}": "${var.vpc_name}-${var.vpc_region}")

        },

    )

}