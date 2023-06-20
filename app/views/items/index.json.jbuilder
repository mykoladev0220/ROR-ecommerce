# frozen_string_literal: true

# Example of a JSON response:

# {
#   "items": [
#     {
#       "id": 1,
#       "name": "ruby book",
#       "price": 50,
#       "quantity": 0,
#       "code": "book",
#       "description": "This is a book about ruby programming language and how to use it.",
#       "created_at": "2023-06-20T09:08:13.034Z",
#       "updated_at": "2023-06-20T10:23:34.380Z"
#     },
#     {
#       "id": 2,
#       "name": "iphone",
#       "price": 100,
#       "quantity": 2,
#       "code": "smartphone",
#       "description": "This is a top-notch phone XMAXULTIMATE 99.9% of people cannot afford it.",
#       "created_at": "2023-06-20T09:08:13.039Z",
#       "updated_at": "2023-06-20T10:10:59.759Z"
#     },
#     {
#       "id": 3,
#       "name": "bugatti",
#       "price": 999,
#       "quantity": 3,
#       "code": "car",
#       "description": "This is Bugatti, the best car in the world.",
#       "created_at": "2023-06-20T09:08:13.044Z",
#       "updated_at": "2023-06-20T10:17:31.555Z"
#     }
#   ]
# }

json.items @items
