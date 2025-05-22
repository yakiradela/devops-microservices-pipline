region		= "us-east-2"
cluster_name	= "cluster"
eks_role_arn	= "arn:aws:iam::557690607676:role/eks-cluster-role"
subnet_ids = [
aws_subnet.public_1.id,
aws_subnet.public_2.id
]
worker_node_role_arn = "arn:aws:iam::557690607676:role/eks-node-role"
