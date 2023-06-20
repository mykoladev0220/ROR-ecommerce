# frozen_string_literal: true

# Example of a JSON response:

# {
#   "total_spending": 50,
#   "bought_items": [
#     {
#       "id": 1,
#       "cart_id": 2,
#       "user_id": 2,
#       "item_id": 1,
#       "quantity": 1,
#       "created_at": "2023-06-20T10:23:37.335Z",
#       "updated_at": "2023-06-20T10:23:37.335Z"
#     }
#   ]
# }

json.total_spending @total_spending
json.bought_items @bought_items
