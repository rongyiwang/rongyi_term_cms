require 'test_helper'

class Slms::OrdersControllerTest < ActionController::TestCase
  setup do
    sign_in admins(:admin)
  end

  test 'GET #index' do
    get :index

    refute_nil assigns(:slms_orders)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    refute_nil assigns(:slms_order)
    assert_response :success
  end
end
