#
# VPC Outputs
#

output "vpc_id" {

    description = "VPC ID"
    value       = aws_vpc.default.id

}

output "vpc_arn" {

    description = "VPC Amazon Resource Names"
    value       = aws_vpc.default.arn

}

output "vpc_owner_id" {

    description = "VPC Owner ID - AWS Account ID"
    value       = aws_vpc.default.owner_id

}

#
# Internet Gateway Outputs
#

output "vpc_internet_gateway_id" {

    description = "VPC Internet Gateway ID"
    value       = aws_internet_gateway.default.id
  
}

output "vpc_internet_gateway_arn" {

    description = "VPC Internet Gateway ARN"
    value       = aws_internet_gateway.default.arn
  
}

#
# Public Subnet Outputs
#

output "vpc_public_subnet_id" {
  
    description = "VPC Public Subnet ID"
    value       = aws_subnet.public_subnet.*.id

}

#
# Private Subnet Outputs 
#

output "vpc_private_subnet_id" {
  
    description = "VPC Private Subnet ID"
    value       = aws_subnet.private_subnet.*.id

}

#
# Network Access List Output for Private Subnets
#

output "vpc_private_subnet_nacl_id" {

    description = "VPC Private Subnet NACL ID"
    value       = aws_network_acl.private_subnet.id
  
}

output "vcp_private_subnet_nacl_arn" {

    description = "VPC Private Subnet NACL ARN"
    value       = aws_network_acl.private_subnet.arn

}

#
# Elastic IPs for NAT Gateway
#

output "vpc_nat_eip_id" {

    description = "VPC Elastic IPs for NAT Gateway"
    value       = aws_eip.default.*.id
  
}

output "vpc_nat_eip_address" {

    description = "VPC Elastic IP address for NAT Gateway"
    value       = aws_eip.default.*.address
  
}

#
# NAT Gateway
#

output "vpc_nat_gateway_private_ip" {

    description = "VPC NAT Gateway Private IP"
    value       = aws_nat_gateway.default.*.private_ip
  
}

output "vpc_nat_gateway_public_ip" {

    description = "VPC NAT Gateway Public IP"
    value       = aws_nat_gateway.default.*.public_ip
  
}

#
# Route Tables
#

output "vpc_public_route_table_id" {

    description = "VPC Public Route Tables ID"
    value       = aws_route_table.public.id
  
}

output "vpc_public_route_table_arn" {

    description = "VPC Public Route Table ARN"
    value       = aws_route_table.public.arn
  
}

output "vpc_private_route_table_id" {

    description = "VPC Private Route Table ID"
    value       = aws_route_table.private.*.id
  
}

output "vpc_private_route_table_arn" {

    description = "VPC Private Route Table ARN"
    value       = aws_route_table.private.*.arn
  
}