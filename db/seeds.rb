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

ruby_book = Item.create(name: 'ruby book',
                        price: 50,
                        quantity: 3,
                        code: 'book',
                        description: 'This is a book about ruby programming language and how to use it. '\
                        'It is a very good book and you should buy it if you want to learn ruby. ' \
                        '200 pages, 5 chapters, 300 excellent examples')

iphone = Item.create(name: 'iphone',
                     price: 100,
                     quantity: 3,
                     code: 'smartphone',
                     description: 'This is a top-notch phone XMAXULTIMATE 99.9% of people cannot afford it. '\
                     'But if you are one of the 0.1% of people who can afford it, do not hesitate to buy it. '\
                     '24 GB of RAM, 1TB of storage, 1000MP camera, 10000mAh battery, 1000Hz screen refresh rate.')


bugatti = Item.create(name: 'bugatti', price: 999, quantity: 3, code: 'car',
                      description: 'This is Bugatti, the best car in the world. '\
                      'Very expensive and not everyone can afford it, but if you can, do not hesitate to buy it. '\
                      'This car is only for the best of the best. ' \
                      '400km/h, 1500HP, 0-100km/h in 2 seconds, 1000km range')

CartItem.create(item: ruby_book, quantity: 1, cart: first_user.cart)
CartItem.create(item: iphone, quantity: 1, cart: first_user.cart)
BoughtItem.create(item: bugatti, quantity: 1, cart: first_user.cart)
