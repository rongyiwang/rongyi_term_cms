require 'test_helper'

class GiftOccasionsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:gift_occasions)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:gift_occasion).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:gift_occasion).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:gift_occasion).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, gift_occasion: {name: '生日礼物'}

    assert assigns(:gift_occasion).persisted?
    assert_redirected_to assigns(:gift_occasion)
    assert_equal '礼品场合新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, gift_occasion: {name: '结婚礼物'}

    refute assigns(:gift_occasion).changed?
    assert_equal 1, assigns(:gift_occasion).id
    assert_equal '结婚礼物', assigns(:gift_occasion).name
    assert_redirected_to assigns(:gift_occasion)
    assert_equal '礼品场合修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:gift_occasion).destroyed?
    assert_redirected_to gift_occasions_url
  end

  test 'POST hide' do
    xhr :post, :hide, id: 1

    refute assigns(:gift_occasion).changed?
    assert_equal 1, assigns(:gift_occasion).id
    assert assigns(:gift_occasion).hidden
    assert_response :success
  end

  test 'POST unhide' do
    xhr :post, :unhide, id: 1

    refute assigns(:gift_occasion).changed?
    assert_equal 1, assigns(:gift_occasion).id
    refute assigns(:gift_occasion).hidden
    assert_response :success
  end
end
