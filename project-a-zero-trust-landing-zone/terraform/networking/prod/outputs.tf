output "hub_vnet_id" {
  value = module.hub_vnet.resource.id
}

output "spoke_vnet_id" {
  value = module.spoke_vnet.resource.id
}

output "firewall_id" {
  value = module.firewall.resource.id
}

output "bastion_id" {
  value = module.bastion.resource.id
}

output "private_dns_zone_id" {
  value = module.private_dns.resource.id
}
