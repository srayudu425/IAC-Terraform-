# Azure Infrastructure with Terraform

This Terraform configuration deploys a complete Azure infrastructure for a healthcare application with AKS, ACR, Application Gateway, and monitoring resources.

## Architecture

The infrastructure includes:

### Resource Groups
1. **AKS Resource Group**: Contains AKS cluster, ACR, and networking
2. **Monitoring Resource Group**: Contains Application Insights and Log Analytics
3. **Application Gateway Resource Group**: Contains Application Gateway and its networking

### Networking
- **AKS VNET** (10.0.0.0/16)
  - AKS Subnet (10.0.1.0/24)
  - ACR Subnet (10.0.2.0/24)
- **Application Gateway VNET** (10.1.0.0/16)
  - AppGW Subnet (10.1.1.0/24)
- **VNET Peering**: Bi-directional peering between AKS and AppGW VNETs

### Services
- **AKS**: Azure Kubernetes Service with system-assigned managed identity
- **ACR**: Azure Container Registry with AKS integration
- **NGINX Ingress Controller**: Deployed via Helm chart
- **Application Gateway**: With public IP for external access
- **Log Analytics Workspace**: For monitoring and logging
- **Application Insights**: For application performance monitoring

## Prerequisites

1. Azure CLI installed and authenticated
2. Terraform >= 1.0
3. Azure subscription with appropriate permissions
4. Azure Storage Account for Terraform state (backend) - already created

## Backend Configuration

Update the `backend.tf` file with your existing backend storage account details:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "your-tfstate-rg"
    storage_account_name = "your-storage-account-name"
    container_name       = "tfstate"
    key                  = "aks-infrastructure.tfstate"
  }
}
```

## Configuration

1. Copy the example variables file:
```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit `terraform.tfvars` with your specific values:
```hcl
location     = "eastus"
environment  = "dev"
project_name = "healthcare"
```

3. Update `backend.tf` with your storage account name:
```hcl
storage_account_name = "tfstateaks<your-unique-id>"
```

## Deployment

### Initialize Terraform
```bash
cd terraform
terraform init
```

### Validate Configuration
```bash
terraform validate
```

### Plan Deployment
```bash
terraform plan
```

### Apply Configuration
```bash
terraform apply
```

## Post-Deployment

### Get AKS Credentials
```bash
az aks get-credentials \
  --resource-group healthcare-aks-dev-rg \
  --name healthcare-aks-dev
```

### Verify AKS Connection
```bash
kubectl get nodes
kubectl get namespaces
```

### Verify NGINX Ingress
```bash
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```

### ACR Login
```bash
az acr login --name healthcareacrdev
```

## Outputs

After deployment, you can retrieve important values:

```bash
# Get all outputs
terraform output

# Get specific outputs
terraform output aks_cluster_name
terraform output acr_login_server
terraform output application_gateway_public_ip

# Get sensitive outputs
terraform output -raw kube_config > ~/.kube/config-healthcare
terraform output -raw application_insights_instrumentation_key
```

## Module Structure

```
terraform/
├── main.tf                 # Main configuration
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── providers.tf            # Provider configuration
├── backend.tf              # Backend configuration
├── terraform.tfvars.example
└── modules/
    ├── resource-group/     # Resource group module
    ├── networking/         # VNET and subnets module
    ├── aks/                # AKS cluster module
    ├── acr/                # Container registry module
    ├── nginx-ingress/      # NGINX ingress controller module
    ├── monitoring/         # Log Analytics and App Insights module
    ├── application-gateway/ # Application Gateway module
    └── vnet-peering/       # VNET peering module
```

## Customization

### Scaling AKS
Modify in `terraform.tfvars`:
```hcl
aks_node_count = 3
aks_node_size  = "Standard_D4s_v3"
```

### Change Network CIDR
Modify in `terraform.tfvars`:
```hcl
aks_vnet_address_space = ["10.10.0.0/16"]
aks_subnet_address_prefix = "10.10.1.0/24"
```

### Enable Auto-scaling
Add to AKS module configuration in `main.tf`:
```hcl
enable_auto_scaling = true
min_node_count      = 2
max_node_count      = 5
```

## Security Considerations

1. **Network Isolation**: AKS and ACR are in separate subnets
2. **Managed Identity**: AKS uses system-assigned managed identity
3. **ACR Integration**: AKS has AcrPull role assignment
4. **VNET Peering**: Secure communication between AKS and AppGW VNETs
5. **Backend State**: Terraform state stored securely in Azure Blob Storage

## Monitoring

### Access Application Insights
```bash
AI_KEY=$(terraform output -raw application_insights_instrumentation_key)
echo $AI_KEY
```

### Access Log Analytics
Navigate to Azure Portal → Monitor → Log Analytics Workspaces

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

**Warning**: This will delete all resources including data. Make sure to backup any important data before running this command.

## Troubleshooting

### AKS Connection Issues
```bash
az aks get-credentials --resource-group <rg-name> --name <aks-name> --overwrite-existing
```

### ACR Pull Issues
Verify role assignment:
```bash
az role assignment list --scope <acr-id>
```

### Terraform State Lock
If state is locked:
```bash
az storage blob lease break \
  --account-name <storage-account> \
  --container-name tfstate \
  --blob-name aks-infrastructure.tfstate
```

## Cost Optimization

- Use Standard SKU for ACR instead of Premium (unless geo-replication is needed)
- Start with smaller AKS node sizes
- Enable auto-scaling to scale down during off-hours
- Use Azure Cost Management to monitor spending

## Additional Resources

- [Azure AKS Documentation](https://docs.microsoft.com/en-us/azure/aks/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)
- [Azure Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/)
