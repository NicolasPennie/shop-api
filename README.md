# ShopAPI
### An API built with Rails

ShopAPI is a server-side API that models a simple shop. With ShopAPI you can create a shop, add products, and make orders. 

Try ShopAPI for yourself at https://shop-api-nickpennie.herokuapp.com/

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

The Product resource is available through /shops/:id/products

```
# Get existing Product
# GET /shops/1/products/3
{
    "id": 3,
    "name": "Eggs",
    "price": "1.99",
    "shop_id": 1,
    "created_at": "2018-09-24T03:45:31.451Z",
    "updated_at": "2018-09-24T03:45:31.451Z"
}

# Update existing Product
# PUT / PATCH /shops/1/products/3?price=1.49
# 204 No Response
```

The Order resource is available through /shops/:id/orders

```
# Get existing Order
# GET /shops/1/orders/2
{
    "id": 2,
    "comment": "Clothes order",
    "cost": "135.0",
    "shop_id": 1,
    "created_at": "2018-09-24T03:45:31.834Z",
    "updated_at": "2018-09-24T03:45:31.933Z"
}
```

Line items are available through shops/:id/orders/:id/line_items

```
# Get Line Items
# GET /shops/1/orders/2/line_items
[
    {
        "id": 5,
        "count": 2,
        "cost": "99.0",
        "order_id": 2,
        "product_id": 4,
        "created_at": "2018-09-24T03:45:31.859Z",
        "updated_at": "2018-09-24T03:45:31.859Z"
    },
    {
        "id": 6,
        "count": 1,
        "cost": "35.0",
        "order_id": 2,
        "product_id": 5,
        "created_at": "2018-09-24T03:45:31.883Z",
        "updated_at": "2018-09-24T03:45:31.883Z"
    },
    {
        "id": 7,
        "count": 1,
        "cost": "1.0",
        "order_id": 2,
        "product_id": 6,
        "created_at": "2018-09-24T03:45:31.900Z",
        "updated_at": "2018-09-24T03:45:31.900Z"
    }
]
```

