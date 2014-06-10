require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:carts)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    refute_nil assigns(:cart)
    assert_response :success
  end
end
