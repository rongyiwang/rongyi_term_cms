require 'test_helper'

class Slms::OrderPaymentLogTest < ActiveSupport::TestCase
  test 'number 不重复' do
    number = SecureRandom.uuid.to_s
    log = Slms::OrderPaymentLog.create(number: number)
    log2 = Slms::OrderPaymentLog.create(number: number)
    assert_not_equal log.number, log2.number
  end
end