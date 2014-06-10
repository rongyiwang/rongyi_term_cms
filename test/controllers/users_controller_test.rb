require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    sign_in admins(:admin)
  end

  # was the web request successful?
  # was the user redirected to the right page?
  # was the user successfully authenticated?
  # was the correct object stored in the response template?
  # was the appropriate message displayed to the user in the view?

  test 'GET #index' do
    get :index

    refute_nil assigns(:users)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:user).id
    assert_response :success
  end

  test 'POST #lock' do
    xhr :post, :lock, id: 1

    assert_equal 1, assigns(:user).id
    refute assigns(:user).locked_at_changed?
    refute_nil assigns(:user).locked_at
    assert_response :success
  end

  test 'POST #unlock' do
    xhr :post, :unlock, id: 1

    assert_equal 1, assigns(:user).id
    refute assigns(:user).locked_at_changed?
    assert_nil assigns(:user).locked_at
    assert_response :success
  end
end
