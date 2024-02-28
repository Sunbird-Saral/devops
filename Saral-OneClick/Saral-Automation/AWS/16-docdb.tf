resource "aws_docdb_cluster_instance" "db" {
  cluster_identifier = aws_docdb_cluster.doc-db.id
  instance_class     = "db.r5.large"
}

resource "aws_docdb_cluster" "doc-db" {
  cluster_identifier         = "saral-db"
  engine_version             = "4.0.0"
  master_username            = var.docdb_username
  master_password            = var.docdb_password
  backup_retention_period    = 7
  preferred_backup_window    = "07:00-09:00"
  skip_final_snapshot        = true
  apply_immediately          = true
  storage_encrypted          = false  # Disabling encryption
  vpc_security_group_ids     = [aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id]  # Specify the security group IDs

  # Specify the IDs of existing VPC and subnets
  db_subnet_group_name       = aws_docdb_subnet_group.db.name 
  # Add parameter group and KMS key if needed
}

resource "aws_docdb_subnet_group" "db" {
  name       = "doc-db-subnet-group"
    subnet_ids = [
      aws_subnet.private-ap-south-1a.id,
      aws_subnet.private-ap-south-1b.id,
      aws_subnet.docdb-private-ap-south-1a.id,  # Newly added subnet
      aws_subnet.docdb-private-ap-south-1b.id,
    ]

  tags = {
    Name = "docdb-subnet-group"
  }
}

output "AWS_Document_DB_Endpoint" {
  value = aws_docdb_cluster.doc-db.endpoint
}

####NEW

resource "aws_security_group_rule" "eks_to_docdb" {
  type                     = "ingress"
  from_port                = 27017  # Assuming DocumentDB uses the default MongoDB port, adjust if necessary
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id  # Security group ID of EKS worker nodes
}

