module "storage" {
  source                   = "git::https://github.com/hmcts/cnp-module-storage-account?ref=4.x"
  env                      = var.env
  storage_account_name     = "${replace(var.component, "-", "")}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  default_action           = "Deny"
  sa_subnets = [
    "/subscriptions/1497c3d7-ab6d-4bb7-8a10-b51d03189ee3/resourceGroups/cft-ptlsbox-network-rg/providers/Microsoft.Network/virtualNetworks/cft-ptlsbox-vnet/subnets/aks-00",
    "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/cft-ptl-network-rg/providers/Microsoft.Network/virtualNetworks/cft-ptl-vnet/subnets/aks-00",
    "/subscriptions/3eec5bde-7feb-4566-bfb6-805df6e10b90/resourceGroups/ss-test-network-rg/providers/Microsoft.Network/virtualNetworks/ss-test-vnet/subnets/aks-00",
    "/subscriptions/3eec5bde-7feb-4566-bfb6-805df6e10b90/resourceGroups/ss-test-network-rg/providers/Microsoft.Network/virtualNetworks/ss-test-vnet/subnets/aks-01",
    "/subscriptions/5ca62022-6aa2-4cee-aaa7-e7536c8d566c/resourceGroups/ss-prod-network-rg/providers/Microsoft.Network/virtualNetworks/ss-prod-vnet/subnets/aks-00",
    "/subscriptions/5ca62022-6aa2-4cee-aaa7-e7536c8d566c/resourceGroups/ss-prod-network-rg/providers/Microsoft.Network/virtualNetworks/ss-prod-vnet/subnets/aks-01",
    "/subscriptions/62864d44-5da9-4ae9-89e7-0cf33942fa09/resourceGroups/cft-ithc-network-rg/providers/Microsoft.Network/virtualNetworks/cft-ithc-vnet/subnets/aks-01",
    "/subscriptions/64b1c6d6-1481-44ad-b620-d8fe26a2c768/resourceGroups/ss-ptlsbox-network-rg/providers/Microsoft.Network/virtualNetworks/ss-ptlsbox-vnet/subnets/aks-00",
    "/subscriptions/6c4d2513-a873-41b4-afdd-b05a33206631/resourceGroups/ss-ptl-network-rg/providers/Microsoft.Network/virtualNetworks/ss-ptl-vnet/subnets/aks-00",
    "/subscriptions/74dacd4f-a248-45bb-a2f0-af700dc4cf68/resourceGroups/ss-stg-network-rg/providers/Microsoft.Network/virtualNetworks/ss-stg-vnet/subnets/aks-00",
    "/subscriptions/74dacd4f-a248-45bb-a2f0-af700dc4cf68/resourceGroups/ss-stg-network-rg/providers/Microsoft.Network/virtualNetworks/ss-stg-vnet/subnets/aks-01",
    "/subscriptions/867a878b-cb68-4de5-9741-361ac9e178b6/resourceGroups/ss-dev-network-rg/providers/Microsoft.Network/virtualNetworks/ss-dev-vnet/subnets/aks-00",
    "/subscriptions/8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c/resourceGroups/cft-perftest-network-rg/providers/Microsoft.Network/virtualNetworks/cft-perftest-vnet/subnets/aks-00",
    "/subscriptions/8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c/resourceGroups/cft-perftest-network-rg/providers/Microsoft.Network/virtualNetworks/cft-perftest-vnet/subnets/aks-01",
    "/subscriptions/8b6ea922-0862-443e-af15-6056e1c9b9a4/resourceGroups/cft-preview-network-rg/providers/Microsoft.Network/virtualNetworks/cft-preview-vnet/subnets/aks-00",
    "/subscriptions/8cbc6f36-7c56-4963-9d36-739db5d00b27/resourceGroups/cft-prod-network-rg/providers/Microsoft.Network/virtualNetworks/cft-prod-vnet/subnets/aks-00",
    "/subscriptions/8cbc6f36-7c56-4963-9d36-739db5d00b27/resourceGroups/cft-prod-network-rg/providers/Microsoft.Network/virtualNetworks/cft-prod-vnet/subnets/aks-01",
    "/subscriptions/96c274ce-846d-4e48-89a7-d528432298a7/resourceGroups/cft-aat-network-rg/providers/Microsoft.Network/virtualNetworks/cft-aat-vnet/subnets/aks-00",
    "/subscriptions/96c274ce-846d-4e48-89a7-d528432298a7/resourceGroups/cft-aat-network-rg/providers/Microsoft.Network/virtualNetworks/cft-aat-vnet/subnets/aks-01",
    "/subscriptions/a8140a9e-f1b0-481f-a4de-09e2ee23f7ab/resourceGroups/ss-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/ss-sbox-vnet/subnets/aks-00",
    "/subscriptions/a8140a9e-f1b0-481f-a4de-09e2ee23f7ab/resourceGroups/ss-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/ss-sbox-vnet/subnets/aks-01",
    "/subscriptions/b72ab7b7-723f-4b18-b6f6-03b0f2c6a1bb/resourceGroups/cft-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/cft-sbox-vnet/subnets/aks-00",
    "/subscriptions/b72ab7b7-723f-4b18-b6f6-03b0f2c6a1bb/resourceGroups/cft-sbox-network-rg/providers/Microsoft.Network/virtualNetworks/cft-sbox-vnet/subnets/aks-01",
    "/subscriptions/ba71a911-e0d6-4776-a1a6-079af1df7139/resourceGroups/ss-ithc-network-rg/providers/Microsoft.Network/virtualNetworks/ss-ithc-vnet/subnets/aks-00",
    "/subscriptions/c68a4bed-4c3d-4956-af51-4ae164c1957c/resourceGroups/ss-demo-network-rg/providers/Microsoft.Network/virtualNetworks/ss-demo-vnet/subnets/aks-00",
    "/subscriptions/c68a4bed-4c3d-4956-af51-4ae164c1957c/resourceGroups/ss-demo-network-rg/providers/Microsoft.Network/virtualNetworks/ss-demo-vnet/subnets/aks-01",
    "/subscriptions/d025fece-ce99-4df2-b7a9-b649d3ff2060/resourceGroups/cft-demo-network-rg/providers/Microsoft.Network/virtualNetworks/cft-demo-vnet/subnets/aks-00",
    "/subscriptions/d025fece-ce99-4df2-b7a9-b649d3ff2060/resourceGroups/cft-demo-network-rg/providers/Microsoft.Network/virtualNetworks/cft-demo-vnet/subnets/aks-01"
  ]

  managed_identity_object_id = data.azurerm_client_config.current.object_id
  role_assignments = [
    "Storage Blob Data Contributor"
  ]

  containers = [{
    name        = "plan-html"
    access_type = "private"
    },
    {
      name        = "plan-json"
      access_type = "private"
    }
  ]

  common_tags = module.ctags.common_tags
}