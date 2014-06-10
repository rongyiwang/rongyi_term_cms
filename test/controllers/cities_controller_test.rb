require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    xhr :get, :index, province_id: 1

    assert_equal 1, assigns(:province).id
    refute_nil assigns(:cities)
    assert_response :success
  end

  test 'GET #new' do
    xhr :get, :new, province_id: 1

    assert_equal 1, assigns(:province).id
    assert assigns(:city).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    xhr :get, :edit, province_id: 1, id: 1

    assert_equal 1, assigns(:province).id
    assert_equal 1, assigns(:city).id
    assert_response :success
  end

  test 'POST #create' do
    xhr :post, :create, province_id: 1, city: {name: '纽约'}

    assert_equal 1, assigns(:province).id
    assert assigns(:city).persisted?
    assert_response :success
  end

  test 'PATCH #update' do
    xhr :patch, :update, province_id: 1, id: 1, city: {name: '纽约'}

    assert_equal 1, assigns(:province).id
    refute assigns(:city).name_changed?
    assert_equal '纽约', assigns(:city).name
    assert_response :success
  end

  test 'DELETE #destroy' do
    xhr :delete, :destroy, province_id: 1, id: 1

    assert_equal 1, assigns(:province).id
    assert assigns(:city).destroyed?
    assert_response :success
  end

  test 'POST #hide' do
    xhr :post, :hide, province_id: 1, id: 1

    assert_equal 1, assigns(:province).id
    assert_equal 1, assigns(:city).id
    refute assigns(:city).hidden_changed?
    assert assigns(:city).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, province_id: 1, id: 1

    assert_equal 1, assigns(:province).id
    assert_equal 1, assigns(:city).id
    refute assigns(:city).hidden_changed?
    refute assigns(:city).hidden
    assert_response :success
  end
end
