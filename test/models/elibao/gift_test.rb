require 'test_helper'

class Elibao::GiftTest < ActiveSupport::TestCase
  test 'number 不重复' do
    number = SecureRandom.uuid.to_s
    gift = Elibao::Gift.create(number: number)
    gift2 = Elibao::Gift.create(number: number)
    assert_not_equal gift.number, gift2.number
  end

end
