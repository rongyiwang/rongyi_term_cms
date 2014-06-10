require 'test_helper'

class GiftTargetPopulationsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:gift_target_populations)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:gift_target_population).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:gift_target_population).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:gift_target_population).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, gift_target_population: {name: '女友'}

    assert assigns(:gift_target_population).persisted?
    assert_redirected_to assigns(:gift_target_population)
    assert_equal '礼品目标群体新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, gift_target_population: {name: '男友'}

    refute assigns(:gift_target_population).changed?
    assert_equal 1, assigns(:gift_target_population).id
    assert_equal '男友', assigns(:gift_target_population).name
    assert_redirected_to assigns(:gift_target_population)
    assert_equal '礼品目标群体修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:gift_target_population).destroyed?
    assert_redirected_to gift_target_populations_url
  end

  test 'POST hide' do
    xhr :post, :hide, id: 1

    refute assigns(:gift_target_population).changed?
    assert_equal 1, assigns(:gift_target_population).id
    assert assigns(:gift_target_population).hidden
    assert_response :success
  end

  test 'POST unhide' do
    xhr :post, :unhide, id: 1

    refute assigns(:gift_target_population).changed?
    assert_equal 1, assigns(:gift_target_population).id
    refute assigns(:gift_target_population).hidden
    assert_response :success
  end
end
