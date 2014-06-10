require 'test_helper'

class BasicSettings::InvoiceTypesControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:basic_settings_invoice_types)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:basic_settings_invoice_type).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:basic_settings_invoice_type).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:basic_settings_invoice_type).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, basic_settings_invoice_type: {name: 'bbb'}

    assert assigns(:basic_settings_invoice_type).persisted?
    assert_redirected_to assigns(:basic_settings_invoice_type)
    assert_equal '发票类型新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, basic_settings_invoice_type: {name: 'aaa'}

    refute assigns(:basic_settings_invoice_type).changed?
    assert_equal 1, assigns(:basic_settings_invoice_type).id
    assert_equal 'aaa', assigns(:basic_settings_invoice_type).name
    assert_redirected_to assigns(:basic_settings_invoice_type)
    assert_equal '发票类型修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert_equal 1, assigns(:basic_settings_invoice_type).id
    assert assigns(:basic_settings_invoice_type).destroyed?
    assert_redirected_to basic_settings_invoice_types_url
  end

  test 'POST #hide' do
    xhr :post, :hide, id: 1

    assert_equal 1, assigns(:basic_settings_invoice_type).id
    refute assigns(:basic_settings_invoice_type).hidden_changed?
    assert assigns(:basic_settings_invoice_type).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: 1

    assert_equal 1, assigns(:basic_settings_invoice_type).id
    refute assigns(:basic_settings_invoice_type).hidden_changed?
    refute assigns(:basic_settings_invoice_type).hidden
    assert_response :success
  end
end
