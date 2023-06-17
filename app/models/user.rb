# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart
  has_many :bought_items, dependent: :destroy

  private

  def create_cart
    Cart.create!(user_id: id)
  end
end
