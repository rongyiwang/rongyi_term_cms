require 'test_helper'

class BrandsProductChildCatalogsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #show' do
    get :show, brand_id: brands(:李宁)

    assert_equal brands(:李宁), assigns(:brand)
    assert_response :success
  end

  test 'GET #show_product_catalogs' do
    xhr :get, :show_product_catalogs, brand_id: brands(:百事)

    assert_equal brands(:百事), assigns(:brand)
    refute_nil assigns(:product_catalogs)
    assert_response :success
  end

  test 'GET #show_options' do
    xhr :get, :show_options, brand_id: brands(:百事), product_catalog_id: 1

    assert_equal brands(:百事), assigns(:brand)
    assert_equal 1, assigns(:product_catalog).id
    assert_equal 2, assigns(:product_child_catalogs).count
    assert_response :success
  end

  test 'POST #check 当李宁在运动服饰中时, checked 为 true 时, 不做修改.' do
    assert_no_difference 'brands(:李宁).product_child_catalogs.count' do
      xhr :post,
      :check,
      brand_id: brands(:李宁).id,
      product_child_catalog_id: product_child_catalogs(:运动服饰).id,
      checked: 'true'
    end

    assert_equal brands(:李宁).id, assigns(:brand).id
    assert_equal product_child_catalogs(:运动服饰).id, assigns(:product_child_catalog).id
    assert_response :success
  end

  test 'POST #check 当李宁不在鞋袜中时, checked 为 true 时, 将李宁加入鞋袜.' do
    assert_difference 'brands(:李宁).product_child_catalogs.count' do
      xhr :post,
      :check,
      brand_id: brands(:李宁).id,
      product_child_catalog_id: product_child_catalogs(:鞋袜).id,
      checked: 'true'
    end

    assert_equal brands(:李宁).id, assigns(:brand).id
    assert_equal product_child_catalogs(:鞋袜).id, assigns(:product_child_catalog).id
    assert_response :success
  end

  test 'POST #check 当李宁在运动服饰中时, checked 为 false, 应该移除李宁.' do
    assert_difference 'brands(:李宁).product_child_catalogs.count', -1 do
      xhr :post,
      :check,
      brand_id: brands(:李宁).id,
      product_child_catalog_id: product_child_catalogs(:运动服饰).id,
      checked: 'false'
    end

    assert_equal brands(:李宁).id, assigns(:brand).id
    assert_equal product_child_catalogs(:运动服饰).id, assigns(:product_child_catalog).id
    assert_response :success
  end

  test 'POST #check 当李宁不在鞋袜中时, checked 为 false, 应该不做修改.' do
    assert_no_difference 'brands(:李宁).product_child_catalogs.count' do
      xhr :post,
      :check,
      brand_id: brands(:李宁).id,
      product_child_catalog_id: product_child_catalogs(:鞋袜).id,
      checked: 'false'
    end

    assert_equal brands(:李宁).id, assigns(:brand).id
    assert_equal product_child_catalogs(:鞋袜).id, assigns(:product_child_catalog).id
    assert_response :success
  end
end
