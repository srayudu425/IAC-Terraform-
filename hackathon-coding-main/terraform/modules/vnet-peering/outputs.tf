output "peering1_id" {
  description = "Peering 1 ID (VNET1 to VNET2)"
  value       = azurerm_virtual_network_peering.vnet1_to_vnet2.id
}

output "peering2_id" {
  description = "Peering 2 ID (VNET2 to VNET1)"
  value       = azurerm_virtual_network_peering.vnet2_to_vnet1.id
}
