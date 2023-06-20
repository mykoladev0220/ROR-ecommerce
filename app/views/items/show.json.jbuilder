# frozen_string_literal: true

# Example of a JSON response:

# {
#   "item": {
#     "id": 1,
#     "name": "ruby book",
#     "price": 50,
#     "quantity": 0,
#     "code": "book",
#     "description": "This is a book about ruby programming language...",
#     "created_at": "2023-06-20T09:08:13.034Z",
#     "updated_at": "2023-06-20T10:23:34.380Z"
#   },
#   "cart_item": {
#     "id": null,
#     "cart_id": null,
#     "item_id": null,
#     "quantity": 1,
#     "created_at": null,
#     "updated_at": null
#   }
# }

json.item @item
json.cart_item @cart_item
