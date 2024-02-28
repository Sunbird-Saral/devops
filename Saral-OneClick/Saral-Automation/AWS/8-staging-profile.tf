resource "aws_eks_fargate_profile" "staging" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "staging"
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = [
    aws_subnet.private-ap-south-1a.id,
    aws_subnet.private-ap-south-1b.id
  ]

  selector {
    namespace = "staging"
  }
}


resource "null_resource" "refresh_coredns" {
  depends_on = [aws_eks_fargate_profile.kube-system]

  provisioner "local-exec" {
    command = "kubectl rollout restart -n kube-system deployment coredns"
  }
}
