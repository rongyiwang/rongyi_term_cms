require 'test_helper'

class ProductChildCatalogsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index, product_catalog_id: 1

    refute_nil assigns(:product_catalog)
    assert_equal 2, assigns(:product_child_catalogs).count
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: product_child_catalogs(:运动服饰), product_catalog_id: 1

    assert_equal product_child_catalogs(:运动服饰), assigns(:product_child_catalog)
    assert_response :success
  end

  test 'GET #new' do
    get :new, product_catalog_id: 1

    assert_equal 1, assigns(:product_catalog).id
    assert assigns(:product_child_catalog).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: product_child_catalogs(:饮料), product_catalog_id: 1

    assert_equal 1, assigns(:product_catalog).id
    assert_equal product_child_catalogs(:饮料), assigns(:product_child_catalog)
    assert_response :success
  end

  test 'POST #create' do
    post :create, product_catalog_id: 1, product_child_catalog: {name: '电子产品'}

    assert_equal 1, assigns(:product_catalog).id
    refute assigns(:product_child_catalog).name_changed?
    assert_redirected_to product_catalog_product_child_catalog_url(1, assigns(:product_child_catalog))
    assert_equal '产品二级目录新增成功。', flash[:notice]
    assert_redirected_to [assigns(:product_catalog), assigns(:product_child_catalog)]
  end

  test 'PATCH #update' do
    patch :update, id: product_child_catalogs(:饮料), product_catalog_id: 1, product_child_catalog: {name: '饮品'}

    assert_equal 1, assigns(:product_catalog).id
    assert_equal product_child_catalogs(:饮料), assigns(:product_child_catalog)
    refute assigns(:product_child_catalog).name_changed?
    assert_equal '饮品', assigns(:product_child_catalog).name
    assert_redirected_to product_catalog_product_child_catalog_url(1, assigns(:product_child_catalog))
  end

  test 'DELETE #destroy' do
    delete :destroy, id: product_child_catalogs(:饮料), product_catalog_id: 1

    assert assigns(:product_child_catalog).destroyed?

    assert_redirected_to product_catalog_product_child_catalogs_path
  end

  test 'POST #hide' do
    xhr :post, :hide, id: product_child_catalogs(:饮料), product_catalog_id: 1

    assert_equal product_child_catalogs(:饮料), assigns(:product_child_catalog)
    refute assigns(:product_child_catalog).hidden_changed?
    assert assigns(:product_child_catalog).hidden
    assert_response :success
  end

  test 'POST #unhide' do
    xhr :post, :unhide, id: product_child_catalogs(:饮料), product_catalog_id: 1

    assert_equal product_child_catalogs(:饮料), assigns(:product_child_catalog)
    refute assigns(:product_child_catalog).hidden_changed?
    refute assigns(:product_child_catalog).hidden
    assert_response :success
  end

end
