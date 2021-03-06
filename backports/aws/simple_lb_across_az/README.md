# Simple service setup for HA pair

The purpose of this terraform configuration is to
setup a simple load balancing scheme to test out
the correct operation of the Citrix ADC VPX high availability pair across
AWS availability zones.

The configuration sets up a pair of ubuntu linux instances each in a different
availability zone and sets up a rudimentary http server with an index.html file
which idetifies the originating node.

The configuration also sets up a service group in the primary VPX node of the HA
pair and associates it with the lb vserver that was created during setup of the HA pair.

This configuration closely follows the configuration perfomed by the `ha_across_az` folder
and uses many of its output variables as input variables.

The expected result is that after correct execution of the configuration
the VPX HA pair should load balance HTTP requests addressed at the public client ip
between the two backend services.

Furthermore this load balancing should continue to work correctly after an HA failover.


## Configuration files

* provider\_aws.tf: AWS provider configuration
* provider\_netscaler.tf: Netscaler provider configuration
* ubuntu.tf: Setup for the two ubuntu linux nodes
* servicegroup.tf: Setup for the Citrix ADC servicegroup
* variables.tf: Input variables
* outputs.tf: Output variables

## Input variables

* `aws_region`: The AWS region to create entities in
* `aws_access_key`: The AWS access key.
* `aws_secret_key`: The AWS secret key
* `nsip`: The NSIP of the primary node.
* `username`: The username for Citrix ADC.
* `instance_id`: The default password for Citrix ADC after EC2 instance initialization.
* `management_security_group_id`: Security group id for the management interfaces.
* `management_subnet_ids`: Subnets for the management interfaces.
* `server_security_group_id`: Security group id for the server interfaces.
* `server_subnet_ids`: Subnet ids for the server interfaces.
* `lbvserver_name`: Name of the lb vserver.
* `server_subnets_cidr_block`: Server subnet cidr blocks.

## Output variables

* `management_ips`: The management ip addresses.
* `service_ips`: The service ip addresses.
