require 'test_helper'

class CollectionItemsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:collection_items)
    assert_response :success
  end

  test 'GET #index 分页测试' do
    get :index

    refute_nil assigns(:collection_items)
    assert_equal 2, assigns(:collection_items).total_pages
    assert_equal 1, assigns(:collection_items).current_page
    assert_equal 2, assigns(:collection_items).count
  end

  test 'GET #index 分页测试 page=2' do
    get :index, page: 2

    refute_nil assigns(:collection_items)
    assert_equal 2, assigns(:collection_items).total_pages
    assert_equal 2, assigns(:collection_items).current_page
    assert_equal 1, assigns(:collection_items).count
  end

  test 'GET #index 搜索测试' do
    get :index, keyword: 'product'

    refute_nil assigns(:collection_items)
    assert_equal 2, assigns(:collection_items).count
  end

  test 'GET #index 搜索测试1' do
    get :index, keyword: 'product1'

    refute_nil assigns(:collection_items)
    assert_equal 1, assigns(:collection_items).count
  end

  test 'GET #index 搜索测试2' do
    get :index, keyword: 'prodcut'

    refute_nil assigns(:collection_items)
    assert_equal 0, assigns(:collection_items).count
  end
end
