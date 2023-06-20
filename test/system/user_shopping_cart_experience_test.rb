# frozen_string_literal: true

require 'application_system_test_case'

class UserShoppingCartExperienceTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  attr_accessor :user

  setup do
    @user = users(:one)
    sign_in user

    visit root_url
  end

  test 'should sign up' do
    click_on 'Log Out'

    click_on 'Sign Up'

    fill_in 'user_email', with: 'minitest@test.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    within('#new_user') do
      click_on 'Sign up'
    end

    assert_text 'Welcome! You have signed up successfully.'
  end

  test 'should add item to cart' do
    # Add item to cart
    click_on 'ruby book'
    click_on 'Add item to cart'

    assert_text 'Item added to cart.'
    assert_text 'Cart | 1 Items'
  end

  test 'should update cart item and remove cart item' do
    click_on 'ruby book'
    click_on 'Add item to cart'

    assert_text 'Item added to cart.'
    assert_text 'Cart | 1 Items'

    # Go to cart
    click_on 'Cart | 1 Items'

    assert_text 'Cart total: $50'

    # Update quantity
    fill_in 'cart_item_quantity', with: 3
    click_on 'Update quantity'

    assert_text 'Cart item updated.'
    assert_text 'Cart total: $150'

    # Remove item from cart
    click_on 'Remove from cart'

    assert_text 'Item removed from cart.'
    assert_text 'Cart | 0 Items'
    assert_text 'Cart total: $0'
  end

  test 'should not checkout an empty cart' do
    # Try visiting checkout page with empty cart
    visit checkout_cart_url

    assert_text 'You cannot checkout an empty cart.'
  end

  test 'should checkout if cart is not empty' do
    # Add item to cart
    click_on 'ruby book'
    click_on 'Add item to cart'

    assert_text 'Item added to cart.'
    assert_text 'Cart | 1 Items'

    # Go to cart
    click_on 'Cart | 1 Items'

    assert_text 'Cart total: $50'

    # Checkout
    click_on 'Go to checkout'

    fill_in 'checkout_cart_number', with: '4242424242424242'
    fill_in 'checkout_cart_expiration_month', with: '12'
    fill_in 'checkout_cart_expiration_year', with: '2025'
    fill_in 'checkout_cart_cvv', with: '123'
    fill_in 'checkout_shipping_address', with: '123 Main St.'
    click_on 'Submit Payment'

    assert_text 'Checkout successful.'
    assert_text 'Cart | 0 Items'
    assert_text 'Bought Items'
    assert_text 'Total Spending: $50'
  end
end
