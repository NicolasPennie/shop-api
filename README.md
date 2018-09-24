# ShopAPI
### An API built with Rails

ShopAPI is a server-side API that models a simple shop. With ShopAPI you can create a shop, add products, and make orders. Try ShopAPI for yourself at https://shop-api-nickpennie.herokuapp.com/

### How to use

The shop resource is available through /shops

```
# Get existing Shops
# GET /shops
[
    {
        "id": 1,
        "name": "Shoppers",
        "created_at": "2018-09-24T03:45:31.263Z",
        "updated_at": "2018-09-24T03:45:31.263Z"
    },
    {
        "id": 2,
        "name": "Oberbrunner-Haag",
        "created_at": "2018-09-24T03:45:33.856Z",
        "updated_at": "2018-09-24T03:45:33.856Z"
    }
]

# Create new Shop
# POST /shops?name="Example"
{
    "id": 3,
    "name": "Example",
    "created_at": "2018-09-24T05:00:12.817Z",
    "updated_at": "2018-09-24T05:00:12.817Z"
}

# Get specific Shop
# GET /shops/3
{
    "id": 3,
    "name": "Example",
    "created_at": "2018-09-24T05:00:12.817Z",
    "updated_at": "2018-09-24T05:00:12.817Z"
}

# Update existing Shop
# PUT or PATCH /shops/3?name="New Name"
# 204 No Content

# Destroy existing Shop
# DELETE /shops/3
# 204 No Content

```

