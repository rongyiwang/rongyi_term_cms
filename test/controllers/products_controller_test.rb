require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  # ============================== 有关 role 的完整测试  ==============================

  test 'sa 可以访问 product 产品页面' do
    sign_in admins(:sa)
    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success
  end

  test 'admin 可以访问 product 产品页面' do
    sign_in admins(:admin)
    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success
  end

  test '普通角色 可以访问 product 产品页面' do
    sign_in admins(:普通角色)
    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success
  end

  test '有删除权限角色 可以访问 product 产品页面' do
    sign_in admins(:有删除权限角色)
    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success
  end

  test '预付费角色 可以访问 product 产品页面' do
    sign_in admins(:预付费角色)
    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success
  end

  test 'sa 是可以删除 product 的.' do
    sign_in admins(:sa)
    delete :destroy, id: 1

    assert_redirected_to products_url
  end

  test 'admin 是可以删除 product 的.' do
    sign_in admins(:admin)
    delete :destroy, id: 1

    assert_redirected_to products_url
  end

  test '有删除权限角色 是可以删除 product 的.' do
    sign_in admins(:有删除权限角色)
    delete :destroy, id: 1

    assert_redirected_to products_url
  end

  test '如果未加入 deletable 角色, 无法删除.' do
    sign_in admins(:普通角色)
    assert_raises(CanCan::AccessDenied, '.') { delete :destroy, id: 1 }
  end

  # ============================== 正常 product 测试 ==============================

  test 'GET #index' do
    get :index

    refute_nil assigns(:products)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:product).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:product).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:product).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, product: {name: '产品1'}

    assert assigns(:product).persisted?
    assert_redirected_to assigns(:product)
    assert_equal '商品新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, product: {name: '产品1'}

    refute assigns(:product).changed?
    assert_equal 1, assigns(:product).id
    assert_equal '产品1', assigns(:product).name
    assert_redirected_to assigns(:product)
    assert_equal '商品修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert_equal 1, assigns(:product).id
    assert assigns(:product).destroyed?
    assert_redirected_to products_url
  end

  test 'POST #hide' do
    xhr :post, :hide, id: 1

    assert_equal 1, assigns(:product).id
    refute assigns(:product).hidden_changed?
    assert assigns(:product).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: 1

    assert_equal 1, assigns(:product).id
    refute assigns(:product).hidden_changed?
    refute assigns(:product).hidden
    assert_response :success
  end

  test 'POST #recommend' do
    xhr :post, :recommend, id: 1

    assert_equal 1, assigns(:product).id
    refute assigns(:product).recommended_changed?
    assert assigns(:product).recommended
    assert_response :success
  end

  test 'POST #unrecommend' do
    xhr :post, :unrecommend, id: 1

    assert_equal 1, assigns(:product).id
    refute assigns(:product).recommended_changed?
    refute assigns(:product).recommended
    assert_response :success
  end

  test 'GET #show_more_operation_for' do
    xhr :get, :show_more_operations_for, id: 1

    assert_equal 1, assigns(:product).id
    assert_response :success
  end

  test 'GET #index_gift_child_catalogs_for' do
    xhr :get, :index_gift_child_catalogs_for, id: 1

    assert_equal 1, assigns(:product).id
    assert assigns(:products_gift_child_catalogs_line_item).new_record?
    assert_response :success
  end

  test 'GET #add_product_keywords_for' do
    xhr :get, :add_product_keywords_for, id: 1

    assert_equal 1, assigns(:product).id
    assert_equal 1, assigns(:product_keyword).product_id
    assert_equal ProductKeyword, assigns(:product_keyword).class
    assert_response :success
  end

  test 'GET #add_product_seo_fields_for' do
    xhr :get, :add_product_seo_fields_for, id: 1

    assert_equal 1, assigns(:product).id
    assert_equal 1, assigns(:product_seo_field).product_id
    assert_equal ProductSeoField, assigns(:product_seo_field).class
    assert_response :success
  end

  test 'get #set_search_params' do

  end

end
