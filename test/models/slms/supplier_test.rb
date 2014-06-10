require 'test_helper'

class Slms::SupplierTest < ActiveSupport::TestCase
  test 'number不重复' do
    number = NumberHelper.random_supplier_number
    osupplier = Slms::Supplier.create(number: number)
    nsupplier = Slms::Supplier.create(number: number)
    assert_not_equal osupplier.number, nsupplier.number
  end
end
