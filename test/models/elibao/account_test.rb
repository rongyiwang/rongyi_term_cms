require 'test_helper'

class Elibao::AccountTest < ActiveSupport::TestCase
  test '如果 mobile 重复，要抛出错误' do
    assert_raises(ArgumentError, 'number 重复') do
      mobile = SecureRandom.uuid.to_s
      Elibao::Account.create(mobile: mobile)
      Elibao::Account.create(mobile: mobile)
    end
  end
end