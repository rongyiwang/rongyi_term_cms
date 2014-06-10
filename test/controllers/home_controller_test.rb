require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    assert_response :success
  end
end
