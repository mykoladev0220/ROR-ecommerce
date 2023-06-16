class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart
  has_many :cart_items
  has_many :bought_items

  after_create :create_cart

  private

  def create_cart
    Cart.create(user_id: id)
  end
end
