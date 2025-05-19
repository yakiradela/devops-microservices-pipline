# יוצרים את ה-Role עבור הקלאסטר של EKS
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# מצרפים את המדיניות שמאפשרת לקלאסטר של EKS לעבוד
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# (אופציונלי - רק אם אתה מנהל את המשתמש דרך Terraform) 
# מעניקים למשתמש yakiradela את ההרשאה לבצע PassRole על ה-Role שנוצר
resource "aws_iam_policy" "passrole_policy" {
  name        = "AllowPassRoleToEKSCluster"
  description = "Allows user yakiradela to pass the eks cluster role"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = aws_iam_role.eks_cluster_role.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_passrole_policy" {
  user       = "yakiradela"
  policy_arn = aws_iam_policy.passrole_policy.arn
}
