require 'test_helper'

class BasicSettings::PaymentWaysControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:basic_settings_payment_ways)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:basic_settings_payment_way).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:basic_settings_payment_way).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:basic_settings_payment_way).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, basic_settings_payment_way: {name: 'aaa'}

    assert assigns(:basic_settings_payment_way).persisted?
    assert_redirected_to assigns(:basic_settings_payment_way)
    assert_equal '支付方式新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, basic_settings_payment_way: {name: 'bbb'}

    refute assigns(:basic_settings_payment_way).changed?
    assert_equal 1, assigns(:basic_settings_payment_way).id
    assert_equal 'bbb', assigns(:basic_settings_payment_way).name
    assert_redirected_to assigns(:basic_settings_payment_way)
    assert_equal '支付方式修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert_equal 1, assigns(:basic_settings_payment_way).id
    assert assigns(:basic_settings_payment_way).destroyed?
    assert_redirected_to basic_settings_payment_ways_url
  end

  test 'POST #hide' do
    xhr :post, :hide, id: 1

    assert_equal 1, assigns(:basic_settings_payment_way).id
    refute assigns(:basic_settings_payment_way).hidden_changed?
    assert assigns(:basic_settings_payment_way).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: 1

    assert_equal 1, assigns(:basic_settings_payment_way).id
    refute assigns(:basic_settings_payment_way).hidden_changed?
    refute assigns(:basic_settings_payment_way).hidden
    assert_response :success
  end

end
