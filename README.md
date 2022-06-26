# Terraform AWS Network Module
_Developed and maintained by [Cloudresty](https://cloudresty.com)._

&nbsp;

Terraform AWS Network Module has been designed for creating and managing a specific set of network related resources. It can be used being for setting up a new AWS account or to manage a pre-existing one. This module can provision and managed the following set of AWS resources:

- 1 x VPC
- 1 x Internet Gateway
- 3 x Public Subnets
- 3 x Private Subnets
- 1 x Network Access Lists (NACLs) for Private Subnets
- 3 x Elastic IPs for NAT Gateways
- 3 x NAT Gateways for Private Subnets
- 4 x Route Tables, one for Public Subnets and three for Private Subnets
- 1 x Transit Gateway (optional)
- 1 x Transit Gateway VPC Attachment (optional)
- 1 x VPN Customer Gateway (optional)
- 1 x VPN Connection Transit Gateway (optional)

Optionally you can set a `project_id` variable for your project, variable that the module can use in order to suffix all resource names that will be provisioned or managed. For example if a `var.project_id="d3rt19"` variable is provided then all the resources will be suffixed like for example `vpc-eu-east-1-d3rt19`, `internet-gateway-eu-east-1-d3rt19` etc..

&nbsp;

## Usage
Example using the default values:
```
module "aws-network" {

    source      = "git::github.com/cloudresty/terraform-aws-network.git?ref=v1.0.0"

}
```
Example using custom values:
```
module "aws-network" {

    source      = "git::github.com/cloudresty/terraform-aws-network.git?ref=v1.0.0"
    project_id  = var.project_id

    vpc_region              = "us-west-2"
    vpc_availability_zones  = ["us-west-2a", "us-west-2b", "us-west-2c"]

}
```

> Check the latest version available and replace the `ref=v1.0.0` flag.

&nbsp;

---

&nbsp;

## VPC
By default, the module will create a new AWS VPC within `us-east-1` region. The default configuration can be updated by changing the VPC Input Variables listed below.

<details>
    <summary>VPC Input Variables</summary>

| Variable Name             | Type      | Default Value             |
| ---------------------     | --------- | ------------------------- |
| `vpc_name`                | `string`  | `vpc`                     |
| `vpc_region`              | `string`  | `us-east-1`               |
| `vpc_availability_zones`  | `list`    | `us-east-1a`              |
|                           |           | `us-east-1b`              |
|                           |           | `us-east-1c`              |
| `vpc_cidr_block`          | `string`  | `10.0.0.0/18`             |
| `vpc_instance_tenancy`    | `string`  | `default`                 |
| `vpc_dns_support`         | `bool`    | `true`                    |
| `vpc_dns_hostnames`       | `bool`    | `true`                    |
| `vpc_classiclink`         | `bool`    | `false`                   |
| `vpc_tags`                | `map`     | `-`                       |

</details>

<details>
  <summary>VPC Outputs</summary>

The module will generate the following VPC outputs:
- `vpc_id`
- `vpc_arn`
- `vpc_owner_id`

</details>

&nbsp;

The name of the VPC will be automatically generated based on the region name selected in the form of `${var.vpc_name}-${var.vpc_region}`. For example if the default values will be used then the VPC will be named `vpc-us-east-1`.

&nbsp;

---

&nbsp;

## Internet Gateway
An AWS Internet Gateway will be provisioned that will be attached to the Public Subnets.

<details>
  <summary>Internet Gateway Input Variables</summary>

| Variable Name                 | Type      | Default Value     |
| ----------------------------- | --------- | ----------------- |
| `vpc_internet_gateway_name`   | `string`  | `internet-gateway`|
| `vpc_internet_gateway_tags`   | `map`     | `-`               |

</details>


<details>
  <summary>Internet Gateway Outputs</summary>

- `vpc_internet_gateway_id`
- `vpc_internet_gateway_arn`

</details>

&nbsp;

The Internet Gateway will be named by default `internet-gateway-${var.vpc_region}`.

&nbsp;

---

&nbsp;

## Subnets
By default, the module will generate a set of Public and Private subnets within the AWS VPC, each having three CIDR blocks for multi-az.

<details>
    <summary>Subnet Input Variables</summary>

| Variable Name                     | Type      | Default Value     |
| -----------------------------     | --------- | ----------------- |
| `vpc_public_subnets_prefix_name`  | `string`  | `public-subnet`   |
| `vpc_public_subnets`              | `list`    | `10.0.0.0/21`     |
|                                   |           | `10.0.8.0/21`     |
|                                   |           | `10.0.16.0/21`    |
| `vpc_public_subnets_tags`         | `map`     | `-`               |
| `vpc_private_subnets_prefix_name` | `string`  | `private-subnet`  |
| `vpc_private_subnets`             | `list`    | `10.0.32.0/21`    |
|                                   |           | `10.0.40.0/21`    |
|                                   |           | `10.0.48.0/21`    |
| `vpc_private_subnets_tags`        | `map`     | `-`               |

</details>

<details>
    <summary>Subnet Outputs</summary>

The module will generate the following Subnet outputs:

- `vpc_public_subnet_id`
- `vpc_private_subnet_id`

</details>

&nbsp;

> Please note that the number of CIDR blocks for each subnet must match the number of availability zones defined within the VPC configuration.

The name of each subnet CIDR block will be generated automatically based on the subnet type and the desired availability zone in the form of `[subnet-type]-${var.vpc_availability_zones}`.

For example if the default values will be used then the subnets will be named like this:
- Public Subnets
    - `public-subnet-eu-east-1a`
    - `public-subnet-eu-east-1b`
    - `public-subnet-eu-east-1c`

- Private Subnets
    - `private-subnet-eu-east-1a`
    - `private-subnet-eu-east-1b`
    - `private-subnet-eu-east-1c`

&nbsp;

---

&nbsp;

## Network Access List (NACLs)
One NACL will be provisioned and configured for the Private Subnets.

<details>
    <summary>NACL Input Variables</summary>

| Variable Name                                 | Type      | Default Value             |
| -----------------------------                 | --------- | -----------------         |
| `vpc_private_subnet_nacl_name`                | `string`  | `private-subnets-nacl`    |
| `vpc_private_subnet_nacl_egress_rule_number`  | `number`  | `100`                     |
| `vpc_private_subnet_nacl_egress_action`       | `string`  | `allow`                   |
| `vpc_private_subnet_nacl_egress_cidr`         | `string`  | `0.0.0.0/0`               |
| `vpc_private_subnet_nacl_egress_from_port`    | `number`  | `0`                       |
| `vpc_private_subnet_nacl_egress_to_port`      | `number`  | `0`                       |
| `vpc_private_subnet_nacl_egress_protocol`     | `string`  | `-1`                      |
| `vpc_private_subnet_nacl_ingress_rule_number` | `number`  | `100`                     |
| `vpc_private_subnet_nacl_ingress_action`      | `string`  | `allow`                   |
| `vpc_private_subnet_nacl_ingress_cidr`        | `string`  | `0.0.0.0/0`               |
| `vpc_private_subnet_nacl_ingress_from_port`   | `number`  | `0`                       |
| `vpc_private_subnet_nacl_ingress_to_port`     | `number`  | `0`                       |
| `vpc_private_subnet_nacl_ingress_protocol`    | `string`  | `-1`                      |
| `vpc_private_subnet_nacl_tags`                | `map`     | `-`

</details>

<details>
    <summary>NACL Outputs</summary>

- `vpc_private_subnet_nacl_id`
- `vpc_private_subnet_nacl_arn`

</details>

&nbsp;

---

&nbsp;

## Elastic IPs for NAT Gateway
A set of Elastic IP addresses will be provisioned, each one of these EIPs being attached to NAT Gateways. The number of EIPs generated is based on the number of availability zones defined within the VPC. For example if there are three availability zones defined within the VPC then three EIPs will be automatically generated by the module.

<details>
    <summary>EIP Input Variables</summary>

| Variable Name                 | Type      | Default Value     |
| ----------------------------- | --------- | ----------------- |
| `vpc_nat_eip_prefix_name`     | `string`  | `nat-eip`         |
| `vpc_nat_eip_tags`            | `map`     | `-`               |

</details>

<details>
    <summary>EIP Outputs</summary>

- `vpc_nat_eip_id`
- `vpc_nat_eip_address`

</details>

&nbsp;

---

&nbsp;

## NAT Gateways
A set of NAT Gateways will be created based on the number of availability zones defined within the VPC. Each NAT Gateway will be automatically attached to each individual Private Subnets.

<details>
    <summary>NAT Gateway Input Variables</summary>

| Variable Name                 | Type      | Default Value     |
| ----------------------------- | --------- | ----------------- |
| `vpc_nat_gateway_prefix_name` | `string`  | `internet-gateway`|
| `vpc_nat_gateway_tags`        | `map`     | `-`               |

</details>

<details>
    <summary>NAT Gateway Outputs</summary>

- `vpc_nat_gateway_private_ip`
- `vpc_nat_gateway_public_ip`

</details>

&nbsp;

---

&nbsp;

## Route Tables
The module will provision automatically two route table types, Public and Private route tables.

One Public route table will be provisioned and this will be responsible for the routes between all Public Subnets and the Internet Gateway.

The Private route tables will be provisioned based on the number of Private Subnets, one for each private subnet / availability zone, managing individual routes between the zonal NAT Gateway and its corresponding Private Subnet.

<details>
    <summary>Route Table Input Variables</summary>

| Variable Name                         | Type      | Default Value     |
| -----------------------------         | --------- | ----------------- |
| `vpc_public_route_table_prefix_name`  | `string`  | `public`          |
| `vpc_public_route_table_route_cidr`   | `string`  | `0.0.0.0/0`       |
| `vpc_public_route_table_tags`         | `map`     | `-`               |
| `vpc_private_route_table_prefix_name` | `string`  | `private`         |
| `vpc_private_route_table_route_cidr`  | `string`  | `0.0.0.0/0`       |
| `vpc_private_route_table_tags`        | `map`     | `-`               |


</details>

<details>
    <summary>Route Table Outputs</summary>

- `vpc_public_route_table_id`
- `vpc_public_route_table_arn`
- `vpc_private_route_table_id`
- `vpc_private_route_table_arn`

</details>

&nbsp;

---

&nbsp;

## Transit Gateway
Transit Gateway has been introduced since `v1.1.0` and it's an optional feature.


<details>
    <summary>Transit Gateway Input Variables</summary>

| Variable Name                         | Type      | Default Value         |
| -----------------------------         | --------- | -----------------     |
| `vpc_transit_gateway_enabled`         | `bool`    | `false`               |
| `vpc_transit_gateway_name`            | `string`  | `transit-gateway`     |
| `vpc_transit_gateway_description`     | `string`  | `External Connection` |
| `vpc_transit_gateway_tags`            | `map`     | `-`                   |

</details>

<details>
    <summary>Transit Gateway Outputs</summary>

- `vpc_transit_gateway_id`
- `vpc_transit_gateway_arn`

</details>

&nbsp;

---

&nbsp;

## Transit Gateway VPC Attachment
Transit Gateway VPC Attachment has been introduced since `v1.1.0` and it's an optional feature.


<details>
    <summary>Transit Gateway VPC Attachment Input Variables</summary>

| Variable Name                                     | Type      | Default Value         |
| -----------------------------                     | --------- | -----------------     |
| `vpc_transit_gateway_vpc_attachment_enabled`      | `bool`    | `false`               |
| `vpc_transit_gateway_vpc_attachment_name`         | `string`  | `tgw-attachment`      |
| `vpc_transit_gateway_vpc_attachment_vpc_id`       | `string`  | `-`                   |
| `vpc_transit_gateway_vpc_attachment_subnet_ids`   | `list`    | `-`                   |
| `vpc_transit_gateway_vpc_attachment_tags`         | `map`     | `-`                   |

</details>

<details>
    <summary>Transit Gateway VPC Attachment Outputs</summary>

- `vpc_transit_gateway_vpc_attachment_id`

</details>

&nbsp;

---

&nbsp;

## VPN Customer Gateway
VPC Customer Gateway has been introduced since `v1.1.0` and it's an optional feature.


<details>
    <summary>VPN Customer Gateway Input Variables</summary>

| Variable Name                                     | Type      | Default Value         |
| -----------------------------                     | --------- | -----------------     |
| `vpc_vpn_customer_gateway_enabled`                | `bool`    | `false`               |
| `vpc_vpn_customer_gateway_name`                   | `string`  | `customer-gateway`    |
| `vpc_vpn_customer_gateway_bgp_asn`                | `number`  | `65000`               |
| `vpc_vpn_customer_gateway_ip_address`             | `string`  | `-`                   |
| `vpc_vpn_customer_gateway_type`                   | `string`  | `ipsec.1`             |
| `vpc_vpn_customer_gateway_tags`                   | `map`     | `-`                   |


</details>

<details>
    <summary>VPN Customer Gateway Outputs</summary>

- `vpc_vpn_customer_gateway_id`
- `vpc_vpn_customer_gateway_arn`

</details>


&nbsp;

---

&nbsp;

## VPN Connection Transit Gateway
...


<details>
    <summary>VPN Connection Transit Gateway Input Variables</summary>

| Variable Name                                                             | Type      | Default Value         |
| -----------------------------                                             | --------- | -----------------     |
| `vpc_vpn_connection_transit_gateway_enabled`                              | `bool`    | `false`               |
| `vpc_vpn_connection_transit_gateway_name`                                 | `string`  | `external-s2s`        |
| `vpc_vpn_connection_transit_gateway_tgw_id`                               | `string`  | `-`                   |
| `vpc_vpn_connection_transit_gateway_tags`                                 | `map`     | `-`                   |
| `vpc_vpn_connection_transit_gateway_tunnel1_ike_versions`                 | `list`    | `ikev1`               |
|                                                                           |           | `ikev2`               |
| `vpc_vpn_connection_transit_gateway_tunnel1_inside_cidr`                  | `string`  | `-`                   |
| `vpc_vpn_connection_transit_gateway_tunnel1_phase1_dh_group_numbers`      | `list`    | `2`                   |
|                                                                           |           | `14`                  |
|                                                                           |           | `15`                  |
|                                                                           |           | `16`                  |
|                                                                           |           | `17`                  |
|                                                                           |           | `18`                  |
|                                                                           |           | `19`                  |
|                                                                           |           | `20`                  |
|                                                                           |           | `21`                  |
|                                                                           |           | `22`                  |
|                                                                           |           | `23`                  |
|                                                                           |           | `24`                  |
| `vpc_vpn_connection_transit_gateway_tunnel1_phase1_encryption_algorithms` | `list`    | `AES128`              |
|                                                                           |           | `AES128-GCM-16`       |
|                                                                           |           | `AES256`              |
|                                                                           |           | `AES256-GCM-16`       |
| `vpc_vpn_connection_transit_gateway_tunnel1_phase1_integrity_algorithms`  | `list`    | `SHA1`                |
|                                                                           |           | `SHA2-256`            |
|                                                                           |           | `SHA2-384`            |
|                                                                           |           | `SHA2-512`            |
| `vpc_vpn_connection_transit_gateway_tunnel1_phase2_dh_group_numbers`      | `list`    | `2`                   |
|                                                                           |           | `5`                   |
|                                                                           |           | `14`                  |
|                                                                           |           | `15`                  |
|                                                                           |           | `16`                  |
|                                                                           |           | `17`                  |
|                                                                           |           | `18`                  |
|                                                                           |           | `19`                  |
|                                                                           |           | `20`                  |
|                                                                           |           | `21`                  |
|                                                                           |           | `22`                  |
|                                                                           |           | `23`                  |
|                                                                           |           | `24`                  |
| `vpc_vpn_connection_transit_gateway_tunnel1_phase2_encryption_algorithms` | `list`    | `AES128`              |
|                                                                           |           | `AES128-GCM-16`       |
|                                                                           |           | `AES256`              |
|                                                                           |           | `AES256-GCM-16`       |
| `vpc_vpn_connection_transit_gateway_tunnel1_phase2_integrity_algorithms`  | `list`    | `SHA1`                |
|                                                                           |           | `SHA2-256`            |
|                                                                           |           | `SHA2-384`            |
|                                                                           |           | `SHA2-512`            |
| `vpc_vpn_connection_transit_gateway_tunnel1_startup_action`               | `string`  | `add`                 |
| `vpc_vpn_connection_transit_gateway_tunnel2_inside_cidr`                  | `string`  | `-`                   |
| `vpc_vpn_connection_transit_gateway_tunnel2_phase1_dh_group_numbers`      | `list`    | `2`                   |
|                                                                           |           | `14`                  |
|                                                                           |           | `15`                  |
|                                                                           |           | `16`                  |
|                                                                           |           | `17`                  |
|                                                                           |           | `18`                  |
|                                                                           |           | `19`                  |
|                                                                           |           | `20`                  |
|                                                                           |           | `21`                  |
|                                                                           |           | `22`                  |
|                                                                           |           | `23`                  |
|                                                                           |           | `24`                  |
| `vpc_vpn_connection_transit_gateway_tunnel2_phase1_encryption_algorithms` | `list`    | `AES128`              |
|                                                                           |           | `AES128-GCM-16`       |
|                                                                           |           | `AES256`              |
|                                                                           |           | `AES256-GCM-16`       |
| `vpc_vpn_connection_transit_gateway_tunnel2_phase1_integrity_algorithms`  | `list`    | `SHA1`                |
|                                                                           |           | `SHA2-256`            |
|                                                                           |           | `SHA2-384`            |
|                                                                           |           | `SHA2-512`            |
| `vpc_vpn_connection_transit_gateway_tunnel2_phase2_dh_group_numbers`      | `list`    | `2`                   |
|                                                                           |           | `5`                   |
|                                                                           |           | `14`                  |
|                                                                           |           | `15`                  |
|                                                                           |           | `16`                  |
|                                                                           |           | `17`                  |
|                                                                           |           | `18`                  |
|                                                                           |           | `19`                  |
|                                                                           |           | `20`                  |
|                                                                           |           | `21`                  |
|                                                                           |           | `22`                  |
|                                                                           |           | `23`                  |
|                                                                           |           | `24`                  |
| `vpc_vpn_connection_transit_gateway_tunnel2_phase2_encryption_algorithms` | `list`    | `AES128`              |
|                                                                           |           | `AES128-GCM-16`       |
|                                                                           |           | `AES256`              |
|                                                                           |           | `AES256-GCM-16`       |
| `vpc_vpn_connection_transit_gateway_tunnel2_phase2_integrity_algorithms`  | `list`    | `SHA1`                |
|                                                                           |           | `SHA2-256`            |
|                                                                           |           | `SHA2-384`            |
|                                                                           |           | `SHA2-512`            |
| `vpc_vpn_connection_transit_gateway_tunnel2_startup_action`               | `string`  | `add`                 |

</details>

<details>
    <summary>VPN Connection Transit Gateway Outputs</summary>

- `vpc_vpn_connection_transit_gateway_id`
- `vpc_vpn_connection_transit_gateway_arn`

</details>