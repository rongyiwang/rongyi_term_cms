require 'test_helper'

class Elibao::PrepaidCardBalanceLogTest < ActiveSupport::TestCase
  test 'number 不重复' do
    number = SecureRandom.uuid.to_s
    log = Elibao::PrepaidCardBalanceLog.create(number: number)
    log2 = Elibao::PrepaidCardBalanceLog.create(number: number)
    assert_not_equal log.number, log2.number
  end
end