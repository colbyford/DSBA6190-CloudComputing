
## Set subscription
az account set --subscription "DSI-23950 Subscription"

## Set list of groups
groups=(
    "alpha"
    "beta"
    "gamma"
    "delta"
    "epsilon"
    "zeta"
    "eta"
    "theta"
    "iota"
    "kappa"
    )

## Loop through groups and create resource groups
for group in ${groups[@]}
do
    echo "Creating resource group: rg-dsba6190-${group}-dev-eastus-001"
    az group create --name "rg-dsba6190-${group}-dev-eastus-001" --location eastus  --tags "class=dsba6190" "instructor=cford38" "semester=fall2024"
done