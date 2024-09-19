terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

#create cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = "menuguru"
  version  = "1.29"
  role_arn = "arn:aws:iam::774305030127:role/LabRole"

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id,
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id                  
    ]
  }
}

#create node groups
# create first node group
resource "aws_eks_node_group" "node_group_1" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "node-group-1"
  node_role_arn   = "arn:aws:iam::774305030127:role/LabRole"
  subnet_ids      = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

# create second node group
resource "aws_eks_node_group" "node_group_2" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "node-group-2"
  node_role_arn   = "arn:aws:iam::774305030127:role/LabRole"
  subnet_ids      = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}