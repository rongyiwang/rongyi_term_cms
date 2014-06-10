require 'test_helper'

class ProvincesControllerTest < ActionController::TestCase
  setup do
    sign_in admins(:admin)
  end

  test 'GET #index' do
    get :index

    refute_nil assigns(:provinces)
    assert_response :success
  end

  test 'GET #new' do
    xhr :get, :new

    assert assigns(:province).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    xhr :get, :edit, id: 1

    assert_equal 1, assigns(:province).id
    assert_response :success
  end

  test 'POST #create' do
    xhr :post, :create, province: {name: '陕西'}

    assert assigns(:province).persisted?
    assert_response :success
  end

  test 'PATCH #update' do
    xhr :patch, :update, id: 1, province: {name: '华盛顿'}

    assert_equal 1, assigns(:province).id
    refute assigns(:province).name_changed?
    assert_equal '华盛顿', assigns(:province).name
    assert_response :success
  end

  test 'DELETE #destroy' do
    xhr :delete, :destroy, id: 1

    assert_equal 1, assigns(:province).id
    assert assigns(:province).destroyed?
    assert_response :success
  end

  test 'POST #hide' do
    xhr :post, :hide, id: 1

    assert_equal 1, assigns(:province).id
    refute assigns(:province).hidden_changed?
    assert assigns(:province).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: 1

    assert_equal 1, assigns(:province).id
    refute assigns(:province).hidden_changed?
    refute assigns(:province).hidden
    assert_response :success
  end

end
