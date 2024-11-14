#!/bin/bash

## Set the pattern to match for resource groups
pattern="rg-dsba6190"

## Get a list of resource groups that start with the pattern
resource_groups=$(az group list --query "[?starts_with(name, '$pattern')].name" --output tsv)

## Loop through each resource group
for rg in $resource_groups; do
    ## Get the suffix after the last hyphen (pattern is rg-dsba6190-cford38-dev-123)
    suffix=$(echo "$rg" | awk -F'-' '{print $NF}')

    ## Get the number of resources in the resource group
    resource_count=$(az resource list --resource-group "$rg" --query "length(@)")

    ## Check if the resource count is less than 4 and the suffix is greater than 001
    if [ "$resource_count" -lt 4 ] && [ "$suffix" -gt 001 ]; then
        echo "Deleting resource group $rg with $resource_count resources..."
        # az group delete --name "$rg" --yes --no-wait
    else
        # echo "Skipping resource group $rg with $resource_count resources."
        :
    fi
done
