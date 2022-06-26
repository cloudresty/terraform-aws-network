#
# Project Variables
#

variable "project_id" {

    description = "Project ID"
    type        = string
    default     = ""

}

#
# VPC Variables
#

variable "vpc_name" {

    description = "VPC Name"
    type        = string
    default     = "vpc"

}

variable "vpc_region" {

    description = "VPC Region"
    type        = string
    default     = "us-east-1"

}

variable "vpc_availability_zones" {

    description = "VPC Subnets Availability Zones"
    type        = list
    default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

variable "vpc_cidr_block" {

    description = "VPC CIDR Block"
    type        = string
    default     = "10.0.0.0/18" # 10.0.0.1 - 10.0.63.255: 16384 IP Addresses

}

variable "vpc_instance_tenancy" {

    description = "VPC Instance Tenancy"
    type        = string
    default     = "default"

}

variable "vpc_dns_support" {

    description = "VPC DNS Support"
    type        = bool
    default     = true

}

variable "vpc_dns_hostnames" {

    description = "VPC DNS Hostnames"
    type        = bool
    default     = true

}

variable "vpc_classiclink" {

    description = "VPC Classic Link"
    type        = bool
    default     = false

}

variable "vpc_tags" {

    description = "VPC Tags"
    type        = map
    default     = {}

}

#
# Internet Gateway Variables
#

variable "vpc_internet_gateway_name" {

    description = "VPC Internete Gateway Name"
    type        = string
    default     = "internet-gateway"

}

variable "vpc_internet_gateway_tags" {

    description = "VPC Internet Gateway Tags"
    type        = map
    default     = {}

}

#
# Subnet Variables
#

variable "vpc_public_subnets_prefix_name" {

    description = "VPC Public Subnets Prefix Name"
    type        = string
    default     = "public-subnet"

}

variable "vpc_public_subnets" {

    description = "VPC Public Subnets"
    type        = list
    default     = [

        "10.0.0.0/21",  # 10.0.0.1  - 10.0.7.254  : 2048 IP Addresses
        "10.0.8.0/21",  # 10.0.8.1  - 10.0.15.254 : 2048 IP Addresses
        "10.0.16.0/21"  # 10.0.16.1 - 10.0.23.254 : 2048 IP Addresses

        # Spare Subnet
        # 10.0.24.0/21    10.0.24.1 - 10.0.31.254 : 2048 IP Addresses

    ]

}

variable "vpc_public_subnet_tags" {

    description = "VPC Public Subnet Tags"
    type        = map
    default     = {}

}

variable "vpc_private_subnets_prefix_name" {

    description = "VPC Private Subnets Prefix Name"
    type        = string
    default     = "private-subnet"

}

variable "vpc_private_subnets" {

    description = "VPC Public Subnets"
    type        = list
    default     = [

        "10.0.32.0/21", # 10.0.32.1  - 10.0.39.254 : 2048 IP Addresses
        "10.0.40.0/21", # 10.0.40.1  - 10.0.47.254 : 2048 IP Addresses
        "10.0.48.0/21"  # 10.0.48.1  - 10.0.55.254 : 2048 IP Addresses

        # Spare Subnet:
        # 10.0.56.0/21    10.0.56.1  - 10.0.63.254 : 2048 IP Addresses

    ]

}

variable "vpc_private_subnet_tags" {

    description = "VPC Private Subnet Tags"
    type        = map
    default     = {}

}

#
# Network Access List Variables for Private Subnets
#

variable "vpc_private_subnet_nacl_name" {

    description = "VPC Private Subnet NACL Name"
    type        = string
    default     = "private-subnets-nacl"

}

variable "vpc_private_subnet_nacl_egress_rule_number" {

    description = "VPC Private Subnet NACL Egress Rule Number"
    type        = number
    default     = 100

}

variable "vpc_private_subnet_nacl_egress_action" {

    description = "VPC Private Subnet NACL Egress Action"
    type        = string
    default     = "allow"

}

variable "vpc_private_subnet_nacl_egress_cidr" {

    description = "VPC Private Subnet NACL Egress CIDR Block"
    type        = string
    default     = "0.0.0.0/0"

}

variable "vpc_private_subnet_nacl_egress_from_port" {

    description = "VPC Private Subnet NACL Egress From Port"
    type        = number
    default     = 0

}

variable "vpc_private_subnet_nacl_egress_to_port" {

    description = "VPC Private Subnet NACL Egress To Port"
    type        = number
    default     = 0

}

variable "vpc_private_subnet_nacl_egress_protocol" {

    description = "VPC Private Subnet NACL Egress Protocol"
    type        = string
    default     = "-1"

}

variable "vpc_private_subnet_nacl_ingress_rule_number" {

    description = "VPC Private Subnet NACL Ingress Rule Number"
    type        = number
    default     = 100

}

variable "vpc_private_subnet_nacl_ingress_action" {

    description = "VPC Private Subnet NACL Ingress Action"
    type        = string
    default     = "allow"

}

variable "vpc_private_subnet_nacl_ingress_cidr" {

    description = "VPC Private Subnet NACL Ingress CIDR Block"
    type        = string
    default     = "0.0.0.0/0"

}

variable "vpc_private_subnet_nacl_ingress_from_port" {

    description = "VPC Private Subnet NACL Ingress From Port"
    type        = number
    default     = 0

}

variable "vpc_private_subnet_nacl_ingress_to_port" {

    description = "VPC Private Subnet NACL Ingress To Port"
    type        = number
    default     = 0

}

variable "vpc_private_subnet_nacl_ingress_protocol" {

    description = "VPC Private Subnet NACL Ingress Protocol"
    type        = string
    default     = "-1"

}

variable "vpc_private_subnet_nacl_tags" {

    description = "VPC Private Subnet NACL Tags"
    type        = map
    default     = {}

}

#
# Elastic IPs Variables for NAT Gateway
#

variable "vpc_nat_eip_prefix_name" {

    description = "VPC NAT Elastic IPs Prefix Name"
    type        = string
    default     = "nat-eip"

}

variable "vpc_nat_eip_tags" {

    description = "VPC NAT Elastic IP Tags"
    type        = map
    default     = {}

}

#
# NAT Gateway Variables
#

variable "vpc_nat_gateway_prefix_name" {

    description = "VPC NAT Gateway Prefix Name"
    type        = string
    default     = "nat-gateway"

}

variable "vpc_nat_gateway_tags" {

    description = "VPC NAT Gateway Tags"
    type        = map
    default     = {}

}

#
# Route Table Variables
#

#
# Public Subnets
#
variable "vpc_public_route_table_prefix_name" {

    description = "VPC Public Route Table Prefix Name"
    type        = string
    default     = "public"

}

variable "vpc_public_route_table_route_cidr" {

    description = "VPC Public Route Table Route CIDR Block"
    type        = string
    default     = "0.0.0.0/0"

}

variable "vpc_public_route_table_tags" {

    description = "VPC Public Route Table Tags"
    type        = map
    default     = {}

}

#
# Private Subnets
#

variable "vpc_private_route_table_prefix_name" {

    description = "VPC Private Route Table Prefix Name"
    type        = string
    default     = "private"

}

variable "vpc_private_route_table_route_cidr" {

    description = "VPC Private Route Table Route CIDR Block"
    type        = string
    default     = "0.0.0.0/0"

}

variable "vpc_private_route_table_tags" {

    description = "VPC Private Route Table Tags"
    type        = map
    default     = {}

}

#
# Transit Gateway
#

variable "vpc_transit_gateway_enabled" {

    description = "VPC Transit Gateway Enabled"
    type        = bool
    default     = false

}

variable "vpc_transit_gateway_name" {

    description = "VPC Transit Gateway Name"
    type        = string
    default     = "transit-gateway"

}

variable "vpc_transit_gateway_description" {

    description = "VPC Transit Gateway Description"
    type        = string
    default     = "External Connection"

}

variable "vpc_transit_gateway_tags" {

    description = "VPC Transit Gateway Tags"
    type        = map
    default     = {}

}

#
# Transit Gateway VPC Attachment
#

variable "vpc_transit_gateway_vpc_attachment_enabled" {

    description = "VPC Transit Gateway VPC Attachment Enabled"
    type        = bool
    default     = false

}

variable "vpc_transit_gateway_vpc_attachment_name" {

    description = "VPC Transit Gateway VPC Attachment Name"
    type        = string
    default     = "tgw-attachment"

}

variable "vpc_transit_gateway_vpc_attachment_vpc_id" {

    description = "VPC Transit Gateway VPC Attachment VPC ID"
    type        = string
    default     = ""

}

variable "vpc_transit_gateway_vpc_attachment_subnet_ids" {

    description = "VPC Transit Gateway VPC Attachment Subnet IDs"
    type        = list
    default     = []

}

variable "vpc_transit_gateway_vpc_attachment_tags" {

    description = "VPC Transit Gateway VPC Attachment Tags"
    type        = map
    default     = {}

}

#
# VPN Customer Gateway
#

variable "vpc_vpn_customer_gateway_enabled" {

    description = "VPN Customer Gateway Enabled"
    type        = bool
    default     = false

}

variable "vpc_vpn_customer_gateway_name" {

    description = "VPN Customer Gateway Name"
    type        = string
    default     = "customer-gateway"

}

variable "vpc_vpn_customer_gateway_bgp_asn" {

    description = "VPN Customer Gateway BGP ASN"
    type        = number
    default     = 65000

}

variable "vpc_vpn_customer_gateway_ip_address" {

    description = "VPN Customer Gateway IP Address"
    type        = string
    default     = ""

}

variable "vpc_vpn_customer_gateway_type" {

    description = "VPN Customer Gateway Type"
    type        = string
    default     = "ipsec.1"

}

variable "vpc_vpn_customer_gateway_tags" {

    description = "VPN Customer Gateway Tags"
    type        = map
    default     = {}

}

#
# VPN Connection Transit Gateway
#

variable "vpc_vpn_connection_transit_gateway_enabled" {

    description = "VPN Connection Transit Gateway Enabled"
    type        = bool
    default     = false

}

variable "vpc_vpn_connection_transit_gateway_name" {

    description = "VPN Connection Transit Gateway Name"
    type        = string
    default     = "external-s2s"

}

variable "vpc_vpn_connection_transit_gateway_tgw_id" {

    description = "VPN Connection Transit Gateway TGW ID"
    type        = string
    default     = ""

}

variable "vpc_vpn_connection_transit_gateway_tags" {

    description = "VPN Connection Transit Gateway Tags"
    type        = map
    default     = {}

}

# Tunnel 1
variable "vpc_vpn_connection_transit_gateway_tunnel1_inside_cidr" {

    description = "VPN Connection Transit Gateway - Tunnel 1 Inside CIDR"
    type        = string
    default     = ""

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_ike_versions" {

    description = "VPN Connection Transit Gateway - Tunnel 1 IKE Versions"
    type        = list
    default     = ["ikev1", "ikev2"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_phase1_dh_group_numbers" {

    description = "VPN Connection Transit Gateway - Tunnel 1, Phase 1 DH Group Numbers"
    type        = list
    default     = ["2", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_phase1_encryption_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 1, Phase 1 Encryption Algorithms"
    type        = list
    default     = ["AES128", "AES128-GCM-16", "AES256", "AES256-GCM-16"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_phase1_integrity_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 1, Phase 1 Integrity Algorithms"
    type        = list
    default     = ["SHA1", "SHA2-256", "SHA2-384", "SHA2-512"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_phase2_dh_group_numbers" {

    description = "VPN Connection Transit Gateway - Tunnel 1, Phase 2 DH Group Numbers"
    type        = list
    default     = ["2", "5", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_phase2_encryption_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 1, Phase 2 Encryption Algorithms"
    type        = list
    default     = ["AES128", "AES128-GCM-16", "AES256", "AES256-GCM-16"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_phase2_integrity_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 1, Phase 2 Integrity Algorithms"
    type        = list
    default     = ["SHA1", "SHA2-256", "SHA2-384", "SHA2-512"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel1_startup_action" {

    description = "VPN Connection Transit Gateway - Tunnel 1 Startup Action"
    type        = string
    default     = "add"

}

# Tunnel 2
variable "vpc_vpn_connection_transit_gateway_tunnel2_inside_cidr" {

    description = "VPN Connection Transit Gateway - Tunnel 2 Inside CIDR"
    type        = string
    default     = ""

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_ike_versions" {

    description = "VPN Connection Transit Gateway - Tunnel 2 IKE Versions"
    type        = list
    default     = ["ikev1", "ikev2"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_phase1_dh_group_numbers" {

    description = "VPN Connection Transit Gateway - Tunnel 2, Phase 1 DH Group Numbers"
    type        = list
    default     = ["2", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_phase1_encryption_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 2, Phase 1 Encryption Algorithms"
    type        = list
    default     = ["AES128", "AES128-GCM-16", "AES256", "AES256-GCM-16"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_phase1_integrity_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 2, Phase 1 Integrity Algorithms"
    type        = list
    default     = ["SHA1", "SHA2-256", "SHA2-384", "SHA2-512"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_phase2_dh_group_numbers" {

    description = "VPN Connection Transit Gateway - Tunnel 2, Phase 2 DH Group Numbers"
    type        = list
    default     = ["2", "5", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_phase2_encryption_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 2, Phase 2 Encryption Algorithms"
    type        = list
    default     = ["AES128", "AES128-GCM-16", "AES256", "AES256-GCM-16"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_phase2_integrity_algorithms" {

    description = "VPN Connection Transit Gateway - Tunnel 2, Phase 2 Integrity Algorithms"
    type        = list
    default     = ["SHA1", "SHA2-256", "SHA2-384", "SHA2-512"]

}

variable "vpc_vpn_connection_transit_gateway_tunnel2_startup_action" {

    description = "VPN Connection Transit Gateway - Tunnel 2 Startup Action"
    type        = string
    default     = "add"

}