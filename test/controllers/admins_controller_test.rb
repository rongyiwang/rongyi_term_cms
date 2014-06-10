require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  setup do
    sign_in admins(:admin)
  end

  # was the web request successful?
  # was the user redirected to the right page?
  # was the user successfully authenticated?
  # was the correct object stored in the response template?
  # was the appropriate message displayed to the user in the view?


  # ============================== 角色验证 ==============================
  test '有删除权限角色不可以删除或锁定.' do
    sign_in admins(:有删除权限角色)

    assert_raises(CanCan::AccessDenied) { xhr :delete, :destroy, id: 3 }
    assert_raises(CanCan::AccessDenied, '删除权限角色, 锁定用户抛异常.') { xhr :patch, :lock, id: 3 }
    assert_raises(CanCan::AccessDenied, '删除权限角色, 锁定用户抛异常.') { xhr :patch, :unlock, id: 3 }
  end

  test '预付费角色不可以删除或锁定' do
    sign_in admins(:预付费角色)

    assert_raises(CanCan::AccessDenied) { xhr :delete, :destroy, id: 3 }
    assert_raises(CanCan::AccessDenied, '预付费角色, 锁定用户抛异常.') { xhr :patch, :lock, id: 3 }
    assert_raises(CanCan::AccessDenied, '预付费角色, 锁定用户抛异常.') { xhr :patch, :unlock, id: 3 }
  end

  test '普通角色不可以删除 admin 中的任何记录.' do
    sign_in admins(:普通角色)

    assert_raises(CanCan::AccessDenied) { xhr :delete, :destroy, id: 3 }
    assert_raises(CanCan::AccessDenied, '普通角色, 锁定用户抛异常.') { xhr :patch, :lock, id: 4 }
    assert_raises(CanCan::AccessDenied, '普通角色, 锁定用户抛异常.') { xhr :patch, :unlock, id: 4 }
  end

  test '普通角色退出登陆时, 不应该抛出异常.' do
    sign_in admins(:普通角色)
    sign_out admins(:普通角色)
    assert_response :success
  end

  # ============================== Admin 验证 ==============================

  test 'GET #index' do
    get :index

    refute_nil assigns(:admins)
    assert_response :success
  end

  test 'GET #edit_role' do
    get :edit_role, id: 3

    assert_equal 3, assigns(:admin).id
    assert_response :success
  end

  test 'PATCH #update_role' do
    patch :update_role, id: 3, admin: {roles: ["admin"]}

    assert_equal 3, assigns(:admin).id
    refute assigns(:admin).roles_changed?
    assert_equal ["admin"], assigns(:admin).roles
    assert_redirected_to admins_path
    assert_equal "修改成功", flash[:notice]
  end

  # 这个测试非必须, 因为这个测试的是 model 验证.
  test 'PATCH #update_role 1' do
    patch :update_role, id: 1, admin: {roles: ["admin"]}

    assert_equal 1, assigns(:admin).id
    refute assigns(:admin).roles_changed?
    assert_equal ["sa"], assigns(:admin).roles
    assert_redirected_to admins_path
    assert_equal "不可以更改 sa!", flash[:notice]
  end

  test 'POST #lock' do
    xhr :post, :lock, id: 3

    assert_equal 3, assigns(:admin).id
    refute assigns(:admin).locked_at_changed?
    refute_nil assigns(:admin).locked_at
    assert_response :success
  end

  test 'POST #unlock' do
    xhr :post, :unlock, id: 3

    assert_equal 3, assigns(:admin).id
    refute assigns(:admin).locked_at_changed?
    assert_nil assigns(:admin).locked_at
    assert_response :success
  end
  
  test 'DELETE #destroy' do
    xhr :delete, :destroy, id: 3

    assert_equal 3, assigns(:admin).id
    assert assigns(:admin).destroyed?
    assert_response :success
  end

  # 也非必须, model 验证
  test 'DELETE #destroy 1' do
    xhr :delete, :destroy, id: 1

    assert_equal 1, assigns(:admin).id
    refute assigns(:admin).destroyed?
    assert_response :redirect
  end
end
