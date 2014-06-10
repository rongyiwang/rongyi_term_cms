require 'test_helper'

class Slms::OrderTest < ActiveSupport::TestCase
  test 'paid_amount 的初始值应该为 0' do
    number = SecureRandom.uuid.to_s
    order = Slms::Order.create(number: number, public_number: number, items_amount: 0, transportation_costs: 0)
    assert_equal order.paid_amount, 0
  end

  test 'number 和 public_number 不重复' do
    number = SecureRandom.uuid.to_s
    order = Slms::Order.create(number: number, public_number: number, items_amount: 0, transportation_costs: 0)
    order2 = Slms::Order.create(number: number, public_number: number, items_amount: 0, transportation_costs: 0)
    assert_not_equal order.number, order2.number
    assert_not_equal order.public_number, order2.public_number
  end

  test 'wanted_payment_amount 为付款金额与已付金额之差' do
    number = SecureRandom.uuid.to_s
    order = Slms::Order.create(number: number, public_number: number, items_amount: 100, transportation_costs: 0)
    assert_equal order.wanted_payment_amount, 100
  end

end
