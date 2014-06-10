require 'test_helper'

class PageContentBlocksControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:page_content_blocks)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:page_content_block).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:page_content_block).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:page_content_block).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, page_content_block: {name: 'block1'}

    assert assigns(:page_content_block).persisted?
    assert_redirected_to assigns(:page_content_block)
    assert_equal '页面内容块新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, page_content_block: {name: 'block1'}

    refute assigns(:page_content_block).changed?
    assert_equal 1, assigns(:page_content_block).id
    assert_equal 'block1', assigns(:page_content_block).name
    assert_redirected_to assigns(:page_content_block)
    assert_equal '页面内容块修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:page_content_block).destroyed?
    assert_redirected_to page_content_blocks_url
  end
end
