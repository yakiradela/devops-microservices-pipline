# ===== Cluster Role =====
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# ===== Worker Node Role =====
resource "aws_iam_role" "worker_node_role" {
  name = "eks-worker-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker_node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "worker_node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "worker_node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# ===== Allow PassRole to current user =====
resource "aws_iam_policy" "passrole_policy" {
  name        = "AllowPassRoleToEKS"
  description = "Allow user to pass cluster role to EKS"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement: [{
      Effect = "Allow",
      Action = "iam:PassRole",
      Resource = [
        aws_iam_role.eks_cluster_role.arn,
        aws_iam_role.worker_node_role.arn
      ]
    }]
  })
}

resource "aws_iam_user_policy_attachment" "user_passrole_attach" {
  user       = "yakirpip"
  policy_arn = aws_iam_policy.passrole_policy.arn
}

# ===== EKS Full Access Policy for yakirpip =====
resource "aws_iam_policy" "eks_full_access" {
  name        = "EKSFullAccessForUser"
  description = "Allows user to fully manage EKS"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect = "Allow",
        Action = [
          "eks:*",
          "ec2:Describe*",
          "ec2:CreateTags",
          "iam:GetRole",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "user_eks_full_access_attach" {
  user       = "yakirpip"
  policy_arn = aws_iam_policy.eks_full_access.arn
}

