# SPDX-FileCopyrightText: 2025 SAP edge team
# SPDX-FileContributor: Kirill Satarin (@kksat)
# SPDX-FileContributor: Manjun Jiao (@mjiao)
#
# SPDX-License-Identifier: Apache-2.0

data "aws_subnets" "subnets" {
  region = var.aws_region
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

module "rosa-hcp" {
  source                 = "git::https://github.com/terraform-redhat/terraform-rhcs-rosa-hcp.git?ref=68c20d8"
  cluster_name           = var.cluster_name
  openshift_version      = var.rosa_version
  account_role_prefix    = var.cluster_name
  operator_role_prefix   = var.cluster_name
  replicas               = 3
  aws_availability_zones = slice([for zone in data.aws_availability_zones.available.names : format("%s", zone)], 0, 3)
  create_oidc            = true
  private                = true
  aws_subnet_ids         = data.aws_subnets.subnets.ids
  create_account_roles   = true
  create_operator_roles  = true
}
