output "region" {
    value = var.region
}

output "project_name" {
    value = var.project_name
}

output "public_instance_public_ip" {
    value = module.EC2.public_instance_public_ip
}