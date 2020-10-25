# ----------------
# Deploy backend
# ----------------

# Create a new resource group
$ az group create --name catfacts --location westeurope

# Create the storage account
# This name must be globally unique, so change it with your own
$ az storage account create --name bbvjkcatfacts \
                            --resource-group catfacts \
                            --kind StorageV2

# Create the function app
# This name must be globally unique, so change it with your own
$ az functionapp create --name bbvjk-catfacts-api \
                        --resource-group catfacts \
                        --consumption-plan-location westeurope \
                        --storage-account bbvjkcatfacts

# Build your app
$ npm run build

# Clean up node_modules to keep only production dependencies
$ npm prune --production

# Create an archive from your local files and publish it
# Don't forget to change the name with the one you used previously
$ func azure functionapp publish bbvjk-catfacts-api

# ----------------
# Deploy frontend
# ----------------

# Make sure to use the storage account name created previously
$ ng add @azure/ng-deploy --resourceGroup catfacts --account catfacts

# Don't forget to change the account name with the one you used previously
$ az storage blob service-properties update \
    --account-name catfacts \
    --static-website \
    --404-document index.html \
    --index-document index.html
$ az storage blob service-properties update \
    --account-name bbvjkcatfacts \
    --account-key Wyvn4NhcW8eWXQrijroS2vmc7hQjxc80UwqfDYLKqo6+6Nccid9RbZJyhWaks09lDDD4PLL7IEy6Ds7Es2tG9A== \
    --static-website \
    --404-document index.html \
    --index-document index.html

# may have to change to the right subscription, if resource-group is not found
az account set --subscription "Visual Studio Enterprise-Abonnement – MPN"

# CORS is enabled by default on function apps but but you must add your website domain to the list of allowed origins using this command:
az functionapp cors add --name bbvjk-catfacts-api --resource-group catfacts --allowed-origins https://bbvjkcatfacts.z6.web.core.windows.net