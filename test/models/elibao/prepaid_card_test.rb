require 'test_helper'

class Elibao::PrepaidCardTest < ActiveSupport::TestCase
  test '如果 number 重复，要抛出错误' do
    assert_raises(ArgumentError, 'number 重复') do
      number = SecureRandom.uuid.to_s
      Elibao::PrepaidCard.create(number: number)
      Elibao::PrepaidCard.create(number: number)
    end
  end

  test 'create_for_user' do
    user_id = 1
    handler = SecureRandom.uuid.to_s
    reason = SecureRandom.uuid.to_s
    password = NumberHelper.random_number_password
    card = Elibao::PrepaidCard.create_for_user(user_id, 10, handler, reason, password)
    assert_equal card.user_id, user_id
    assert_equal Elibao::PrepaidCard.first, card
    assert_equal reason, card.prepaid_card_balance_logs.first.summary
    assert card.can_pay?
    card = Elibao::PrepaidCard.create_for_user(user_id, 10, handler, reason, nil)
    assert_not card.can_pay?
    card = Elibao::PrepaidCard.create_for_user(user_id, 10)
    assert card.persisted?
  end
end
