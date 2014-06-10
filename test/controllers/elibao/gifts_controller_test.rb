require 'test_helper'

class Elibao::GiftsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  test 'GET #index' do
    get :index

    refute_nil assigns(:elibao_gifts)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:elibao_gift).id
    assert_response :success
  end

  test 'POST #hide' do
    xhr :post, :hide, id: 2

    assert_equal 2, assigns(:elibao_gift).id
    refute assigns(:elibao_gift).hidden_changed?
    assert assigns(:elibao_gift).hidden
    assert_response :success
  end

  test 'POST #unhidden' do
    xhr :post, :unhide, id: 2

    assert_equal 2, assigns(:elibao_gift).id
    refute assigns(:elibao_gift).hidden_changed?
    refute assigns(:elibao_gift).hidden
    assert_response :success
  end

  test 'POST #recommend' do
    xhr :post, :recommend, id: 2

    assert_equal 2, assigns(:elibao_gift).id
    refute assigns(:elibao_gift).recommended_changed?
    assert assigns(:elibao_gift).recommended
    assert_response :success
  end

  test 'POST #unrecommend' do
    xhr :post, :unrecommend, id: 2

    assert_equal 2, assigns(:elibao_gift).id
    refute assigns(:elibao_gift).recommended_changed?
    refute assigns(:elibao_gift).recommended
    assert_response :success
  end
end
