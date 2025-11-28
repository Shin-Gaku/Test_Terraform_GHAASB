# 作成したVPC ID をモジュールの外部に渡す
output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "作成されたVPCのID"
}

# 作成したVPC CIDR
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}


# 作成したパブリックサブネットID
output "public_subnets_ids" {
  description = "パブリックサブネットID"
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

# 作成したプライベートサブネットID
output "private_subnets_ids" {
  description = "プライベートサブネットID"
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}

# 作成したパブリックサブネットcidr
output "public_subnets_cidr" {
  description = "パブリックサブネットcidr"
  value = [
    aws_subnet.public_subnet_1.cidr_block,
    aws_subnet.public_subnet_2.cidr_block
  ]
}

# 作成したプライベートサブネットcidr
output "private_subnets_cidr" {
  description = "プライベートサブネットcidr"
  value = [
    aws_subnet.private_subnet_1.cidr_block,
    aws_subnet.private_subnet_2.cidr_block
  ]
}