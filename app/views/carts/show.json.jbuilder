# frozen_string_literal: true

# Example of a JSON response:

# {
#   "cart_total": 999,
#   "cart_items": [
#     {
#       "id": 15,
#       "cart_id": 2,
#       "item_id": 3,
#       "quantity": 1,
#       "created_at": "2023-06-20T10:08:32.237Z",
#       "updated_at": "2023-06-20T10:09:02.812Z"
#     }
#   ]
# }

json.cart_total @cart_total
json.cart_items @cart_items
