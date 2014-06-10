require 'test_helper'

class OfficialArticlesControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:official_articles)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:official_article).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:official_article).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:official_article).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, official_article: {title: "春节促销"}

    assert assigns(:official_article).persisted?
    assert_redirected_to assigns(:official_article)
    assert_equal '官方文章新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, official_article: {title: "春节促销"}

    refute assigns(:official_article).changed?
    assert_equal 1, assigns(:official_article).id
    assert_equal '春节促销', assigns(:official_article).title
    assert_redirected_to assigns(:official_article)
    assert_equal '官方文章修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:official_article).destroyed?
    assert_redirected_to official_articles_url
  end

  test 'POST hide' do
    xhr :post, :hide, id: 1

    refute assigns(:official_article).changed?
    assert_equal 1, assigns(:official_article).id
    assert assigns(:official_article).hidden
    assert_response :success
  end

  test 'POST unhide' do
    xhr :post, :unhide, id: 1

    refute assigns(:official_article).changed?
    assert_equal 1, assigns(:official_article).id
    refute assigns(:official_article).hidden
    assert_response :success
  end
end
