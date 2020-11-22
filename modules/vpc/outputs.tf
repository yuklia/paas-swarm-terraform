
output "vpc_id" {
  description = ""
  value       = aws_vpc.vpc.id
}

output "vpc_region_id" {
  description = ""
  value       = aws_vpc.vpc.tags["Region_Id"]
}
