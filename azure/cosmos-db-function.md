# Using cosmos-db in azure functions

## function.json
```
{
  "bindings": [
    ...
    {
      "name": "document",
      "type": "cosmosDB",
      "databaseName": "studio-db",
      "collectionName": "users",
      "createIfNotExists": false,
      "connectionStringSetting": "studio-db-account_COSMOSDB",
      "direction": "out"
    }
    ...
  ],
}

```

## local.settings.json
```
{
  "Values": {
    ...
    "studio-db-account_COSMOSDB": "xxxxx"
    ...
  }
}

```
Key comes from Azure portal / DB Account / Keys / PRIMARY KEY

## saving data
```
context.bindings.document = JSON.stringify({name: 'blah' });
context.done();
```
