# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: 'user2', email: 'test@mail.com', password: 'password', password_confirmation: 'password')

first_user = User.create(name: 'user', email: 'user@mail.com', password: 'password', password_confirmation: 'password')

ruby_book = Item.create(name: 'ruby book', price: 50, quantity: 3, code: 'ruby_2023', description: 'book')
iphone = Item.create(name: 'iphone', price: 100, quantity: 3, code: 'iphone14_2023', description: 'smartphone')
bugatti = Item.create(name: 'bugatti', price: 999, quantity: 3, code: 'bugatti_2023', description: 'car')

CartItem.create(item: ruby_book, quantity: 1, cart: first_user.cart)
CartItem.create(item: iphone, quantity: 1, cart: first_user.cart)
BoughtItem.create(item: bugatti, quantity: 1, cart: first_user.cart)
