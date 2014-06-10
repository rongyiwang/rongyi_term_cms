require 'test_helper'

class GiftChildCatalogsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index, gift_catalog_id: 1

    assert_equal 1, assigns(:gift_catalog).id
    refute_nil assigns(:gift_child_catalogs)
    assert_response :success
  end

  test 'GET #show' do
    get :show, gift_catalog_id: 1, id: 1

    assert_equal 1, assigns(:gift_catalog).id
    assert_equal 1, assigns(:gift_child_catalog).id
    assert_response :success
  end

  test 'GET #new' do
    get :new, gift_catalog_id: 1

    assert_equal 1, assigns(:gift_catalog).id
    assert assigns(:gift_child_catalog).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, gift_catalog_id: 1, id: 1

    assert_equal 1, assigns(:gift_catalog).id
    assert_equal 1, assigns(:gift_child_catalog).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, gift_catalog_id: 1, gift_child_catalog: {name: '子分类1'}

    assert_equal 1, assigns(:gift_catalog).id
    refute assigns(:gift_child_catalog).name_changed?
    assert_equal '子分类1', assigns(:gift_child_catalog).name
    assert_redirected_to [assigns(:gift_catalog), assigns(:gift_child_catalog)]
    assert '产品二级目录新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, gift_catalog_id: 1, id: 1, gift_child_catalog: {name: '子分类1'}

    assert_equal 1, assigns(:gift_catalog).id
    refute assigns(:gift_child_catalog).name_changed?
    assert_equal 1, assigns(:gift_child_catalog).id
    assert_equal '子分类1', assigns(:gift_child_catalog).name
    assert_redirected_to [assigns(:gift_catalog), assigns(:gift_child_catalog)]
    assert '产品二级目录修改成功。', flash[:notice]
  end

  test 'DELETE #destory' do
    delete :destroy, gift_catalog_id: 1, id: 1

    assert_equal 1, assigns(:gift_catalog).id
    assert assigns(:gift_child_catalog).destroyed?
    assert_redirected_to gift_catalog_gift_child_catalogs_url
  end

  test 'POST hide' do
    xhr :post, :hide, gift_catalog_id: 1, id: 1

    assert_equal 1, assigns(:gift_catalog).id
    refute assigns(:gift_child_catalog).hidden_changed?
    assert_equal 1, assigns(:gift_child_catalog).id
    assert assigns(:gift_child_catalog).hidden
    assert_response :success
  end

  test 'POST unhide' do
    xhr :post, :unhide, gift_catalog_id: 1, id: 1

    assert_equal 1, assigns(:gift_catalog).id
    refute assigns(:gift_child_catalog).hidden_changed?
    assert_equal 1, assigns(:gift_child_catalog).id
    refute assigns(:gift_child_catalog).hidden
    assert_response :success
  end
end
