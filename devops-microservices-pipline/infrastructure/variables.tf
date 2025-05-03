variable "region" {}
variable "cluster_name" {}
variable "eks_role_arn" {}
variable "subnet_ids" {
  type = list(string)
}
variable "worker_node_role_arn" {}
