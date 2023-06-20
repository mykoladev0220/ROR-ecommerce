# frozen_string_literal: true

# Example of a JSON response:

# {
#   "message": "Cart item updated.",
#   "cart_item": {
#     "quantity": 1,
#     "id": 15,
#     "cart_id": 2,
#     "item_id": 3,
#     "created_at": "2023-06-20T10:08:32.237Z",
#     "updated_at": "2023-06-20T10:09:02.812Z"
#   }
# }

json.message @message
json.cart_item @cart_item
