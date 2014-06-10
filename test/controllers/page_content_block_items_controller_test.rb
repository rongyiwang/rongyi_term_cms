require 'test_helper'

class PageContentBlockItemsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index, page_content_block_id: 1

    assert_equal 1, assigns(:page_content_block).id
    refute_nil assigns(:page_content_block_items)
    assert_response :success
  end
  
  test 'GET #show' do
    get :show, id: 1, page_content_block_id: 1

    assert_equal 1, assigns(:page_content_block).id
    assert_equal 1, assigns(:page_content_block_item).id
    assert_response :success
  end

  test 'GET #new' do
    get :new, page_content_block_id: 1

    assert_equal 1, assigns(:page_content_block).id
    assert assigns(:page_content_block_item).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1, page_content_block_id: 1

    assert_equal 1, assigns(:page_content_block).id
    assert_equal 1, assigns(:page_content_block_item).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, page_content_block_id: 1, page_content_block_item: {text: 'block1'}

    assert_equal 1, assigns(:page_content_block).id
    assert assigns(:page_content_block_item).persisted?
    assert_redirected_to [assigns(:page_content_block), assigns(:page_content_block_item)]
    assert_equal '页面内容项新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, page_content_block_id: 1, page_content_block_item: {text: 'block1'}

    refute assigns(:page_content_block_item).changed?
    assert_equal 1, assigns(:page_content_block_item).id
    assert_equal 'block1', assigns(:page_content_block_item).text
    assert_redirected_to [assigns(:page_content_block), assigns(:page_content_block_item)]
    assert_equal '页面内容项修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1, page_content_block_id: 1

    assert_equal 1, assigns(:page_content_block).id
    assert assigns(:page_content_block_item).destroyed?
    assert_redirected_to page_content_block_page_content_block_items_url
  end
end
