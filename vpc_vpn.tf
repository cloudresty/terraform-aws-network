#
# VPN Customer Gateway
#

resource "aws_customer_gateway" "default" {

    count       = var.vpc_vpn_customer_gateway_enabled ? 1 : 0
    bgp_asn     = var.vpc_vpn_customer_gateway_bgp_asn
    ip_address  = var.vpc_vpn_customer_gateway_ip_address
    type        = var.vpc_vpn_customer_gateway_type

    tags = merge(var.vpc_vpn_customer_gateway_tags,{

        Name = (var.project_id !="" ? "${var.vpc_vpn_customer_gateway_name}-${var.project_id}" : "${var.vpc_vpn_customer_gateway_name}")

    })

}

#
# VPN Connection Transit Gateway
#

resource "aws_vpn_connection" "default_vpn_connection_transit_gateway" {

    count                   = var.vpc_vpn_connection_transit_gateway_enabled ? 1 : 0
    customer_gateway_id     = aws_customer_gateway.default[0].id
    transit_gateway_id      = var.vpc_vpn_connection_transit_gateway_tgw_id
    type                    = aws_customer_gateway.default[0].type

    # Tunnel 1
    tunnel1_inside_cidr                     = var.vpc_vpn_connection_transit_gateway_tunnel1_inside_cidr
    tunnel1_ike_versions                    = var.vpc_vpn_connection_transit_gateway_tunnel1_ike_versions

    tunnel1_phase1_dh_group_numbers         = var.vpc_vpn_connection_transit_gateway_tunnel1_phase1_dh_group_numbers
    tunnel1_phase1_encryption_algorithms    = var.vpc_vpn_connection_transit_gateway_tunnel1_phase1_encryption_algorithms
    tunnel1_phase1_integrity_algorithms     = var.vpc_vpn_connection_transit_gateway_tunnel1_phase1_integrity_algorithms

    tunnel1_phase2_dh_group_numbers         = var.vpc_vpn_connection_transit_gateway_tunnel1_phase2_dh_group_numbers
    tunnel1_phase2_encryption_algorithms    = var.vpc_vpn_connection_transit_gateway_tunnel1_phase2_encryption_algorithms
    tunnel1_phase2_integrity_algorithms     = var.vpc_vpn_connection_transit_gateway_tunnel1_phase2_integrity_algorithms

    tunnel1_startup_action                  = var.vpc_vpn_connection_transit_gateway_tunnel1_startup_action

    # Tunnel 2
    tunnel2_inside_cidr                     = var.vpc_vpn_connection_transit_gateway_tunnel2_inside_cidr
    tunnel2_ike_versions                    = var.vpc_vpn_connection_transit_gateway_tunnel2_ike_versions

    tunnel2_phase1_dh_group_numbers         = var.vpc_vpn_connection_transit_gateway_tunnel2_phase1_dh_group_numbers
    tunnel2_phase1_encryption_algorithms    = var.vpc_vpn_connection_transit_gateway_tunnel2_phase1_encryption_algorithms
    tunnel2_phase1_integrity_algorithms     = var.vpc_vpn_connection_transit_gateway_tunnel2_phase1_integrity_algorithms

    tunnel2_phase2_dh_group_numbers         = var.vpc_vpn_connection_transit_gateway_tunnel2_phase2_dh_group_numbers
    tunnel2_phase2_encryption_algorithms    = var.vpc_vpn_connection_transit_gateway_tunnel2_phase2_encryption_algorithms
    tunnel2_phase2_integrity_algorithms     = var.vpc_vpn_connection_transit_gateway_tunnel2_phase2_integrity_algorithms

    tunnel2_startup_action                  = var.vpc_vpn_connection_transit_gateway_tunnel2_startup_action

    tags = merge(var.vpc_vpn_connection_transit_gateway_tags,{

        Name = (var.project_id !="" ? "${var.vpc_vpn_connection_transit_gateway_name}-${var.project_id}" : "${var.vpc_vpn_connection_transit_gateway_name}")

    })

}