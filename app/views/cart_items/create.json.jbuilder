# frozen_string_literal: true

# Example of a JSON response:

# {
#   "message": "Item added to cart.",
#   "cart_item": {
#     "id": 16,
#     "cart_id": 2,
#     "item_id": 2,
#     "quantity": 1,
#     "created_at": "2023-06-20T10:10:17.261Z",
#     "updated_at": "2023-06-20T10:10:17.261Z"
#   }
# }

json.message @message
json.cart_item @cart_item
