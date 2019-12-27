LOCALFUNCTIONPROJECT = functions-proj
RESOURCEGROUP = functionsDemoGroup
STORAGEACCOUNT = jfcfunctionsdemostorage
FUNCTIONAPP = jfc-functions-demo

# Initialise new local project for functions
func init $LOCALFUNCTIONPROJECT

# Create new local function
func new --name MyHttpTrigger --template "HttpTrigger"

# Create new group of functions in azure
az group create --name $RESOURCEGROUP --location australiasoutheast
az storage account create --name $STORAGEACCOUNT --location australiasoutheast --resource-group $RESOURCEGROUP --sku Standard_LRS
az functionapp create --resource-group $RESOURCEGROUP --consumption-plan-location australiasoutheast \
--name $FUNCTIONAPP --storage-account $STORAGEACCOUNT --runtime node

# Create new cosmo db
az cosmosdb create --name $DBAccount --resource-group $RESOURCEGROUP

# Deploy local functions to azure
npm run build:production
func azure functionapp publish $FUNCTIONAPP

# delete
az group delete --name $RESOURCEGROUP
