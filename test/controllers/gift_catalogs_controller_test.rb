require 'test_helper'

class GiftCatalogsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:gift_catalogs)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:gift_catalog).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:gift_catalog).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 2

    assert_equal 2, assigns(:gift_catalog).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, gift_catalog: {name: '生日'}

    assert assigns(:gift_catalog).persisted?
    assert_redirected_to assigns(:gift_catalog)
    assert_equal '礼品目录新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, gift_catalog: {name: '婚庆'}

    refute assigns(:gift_catalog).name_changed?
    assert_equal 1, assigns(:gift_catalog).id
    assert_equal '婚庆', assigns(:gift_catalog).name
    assert_redirected_to assigns(:gift_catalog)
    assert_equal '礼品目录修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:gift_catalog).destroyed?
    assert_equal 1, assigns(:gift_catalog).id
    assert_redirected_to gift_catalogs_url
  end

  test 'POST #hide' do
    xhr :post, :hide, id: 1

    refute assigns(:gift_catalog).hidden_changed?
    assert assigns(:gift_catalog).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: 1

    refute assigns(:gift_catalog).hidden_changed?
    refute assigns(:gift_catalog).hidden
    assert_response :success
  end
end
