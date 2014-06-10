require 'test_helper'

class GiftPriceRangesControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:gift_price_ranges)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:gift_price_range).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:gift_price_range).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:gift_price_range).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, gift_price_range: {display_name: '1-99'}

    assert assigns(:gift_price_range).persisted?
    assert_redirected_to assigns(:gift_price_range)
    assert_equal '礼品价格范围新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, gift_price_range: {display_name: '1-99'}

    refute assigns(:gift_price_range).changed?
    assert_equal 1, assigns(:gift_price_range).id
    assert_equal '1-99', assigns(:gift_price_range).display_name
    assert_redirected_to assigns(:gift_price_range)
    assert_equal '礼品价格范围修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:gift_price_range).destroyed?
    assert_redirected_to gift_price_ranges_url
  end

  test 'POST hide' do
    xhr :post, :hide, id: 1

    refute assigns(:gift_price_range).changed?
    assert_equal 1, assigns(:gift_price_range).id
    assert assigns(:gift_price_range).hidden
    assert_response :success
  end

  test 'POST unhide' do
    xhr :post, :unhide, id: 1

    refute assigns(:gift_price_range).changed?
    assert_equal 1, assigns(:gift_price_range).id
    refute assigns(:gift_price_range).hidden
    assert_response :success
  end
end
