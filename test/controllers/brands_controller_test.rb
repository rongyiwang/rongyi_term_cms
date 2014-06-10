require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:api_url)
    refute_nil assigns(:brands)
    assert_nil assigns(:product_catalog_id)
    assert_nil assigns(:product_child_catalog_id)
  end

  test 'GET #index 1' do
    get :index, brand: {product_catalog_id: 1, product_child_catalog_id: 2}

    refute_nil assigns(:api_url)
    refute_nil assigns(:brands)
    assert_equal "1", assigns(:product_catalog_id)
    assert_equal "2", assigns(:product_child_catalog_id)
  end

  test 'GET #show 1' do
    get :show, id: brands(:百事)

    assert_equal brands(:百事), assigns(:brand)
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:brand).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    assert_response :success
  end

  test 'POST #create' do
    post :create, brand: {name: '雅戈尔'}

    assert assigns(:brand).persisted?
    assert_redirected_to brand_url(assigns(:brand))
    assert_equal '品牌新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: brands(:百事), brand: {name: '百事可乐'}

    assert_equal brands(:百事), assigns(:brand)
    refute assigns(:brand).name_changed?
    assert_equal '百事可乐', assigns(:brand).name
    assert_redirected_to brand_url(assigns(:brand))
    assert_equal '品牌修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    assert assigns(:brand).destroyed?
    assert_redirected_to brands_url
  end

  test 'POST #hide' do
    xhr :post, :hide, id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    refute assigns(:brand).hidden_changed?
    assert assigns(:brand).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    refute assigns(:brand).hidden_changed?
    refute assigns(:brand).hidden
    assert_response :success
  end

  test 'POST #recommend' do
    xhr :post, :recommend, id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    refute assigns(:brand).recommended_changed?
    assert assigns(:brand).recommended
    assert_response :success
  end

  test 'POST #unrecommend' do
    xhr :post, :unrecommend, id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    refute assigns(:brand).recommended_changed?
    refute assigns(:brand).recommended
    assert_response :success
  end
end
