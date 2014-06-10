require 'test_helper'

class AreasControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    xhr :get, :index, city_id: 1

    assert_equal 1, assigns(:city).id
    refute_nil assigns(:areas)
    assert_response :success
  end

  test 'GET #new' do
    xhr :get, :new, city_id: 1

    assert_equal 1, assigns(:city).id
    assert assigns(:area).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    xhr :get, :edit, city_id: 1, id: 1

    assert_equal 1, assigns(:city).id
    assert_equal 1, assigns(:area).id
    assert_response :success
  end

  test 'POST #create' do
    xhr :post, :create, city_id: 1, area: {name: '张江镇'}

    assert_equal 1, assigns(:city).id
    assert assigns(:area).persisted?
    assert_response :success
  end

  test 'PATCH #update' do
    xhr :patch, :update, city_id: 1, id: 1, area: {name: '张江镇'}

    assert_equal 1, assigns(:city).id
    refute assigns(:area).name_changed?
    assert_equal '张江镇', assigns(:area).name
    assert_response :success
  end

  test 'DELETE #destroy' do
    xhr :delete, :destroy, city_id: 1, id: 1

    assert_equal 1, assigns(:city).id
    assert assigns(:area).destroyed?
    assert_response :success
  end

  test 'POST #hide' do
    xhr :post, :hide, city_id: 1, id: 1

    assert_equal 1, assigns(:city).id
    assert_equal 1, assigns(:area).id
    refute assigns(:area).hidden_changed?
    assert assigns(:city).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, city_id: 1, id: 1

    assert_equal 1, assigns(:city).id
    assert_equal 1, assigns(:area).id
    refute assigns(:area).hidden_changed?
    refute assigns(:area).hidden
    assert_response :success
  end
end
