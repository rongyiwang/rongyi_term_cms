require 'test_helper'

class Elibao::PrepaidCardsControllerTest < ActionController::TestCase
  setup { sign_in admins(:admin) }

  # ============================== 角色验证 ==============================

  test 'sa 可以操作预付卡' do
    sign_in admins(:sa)

    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success

    post :create, elibao_prepaid_card: {number: '12345678'}
    assert_redirected_to assigns(:elibao_prepaid_card)
  end

  test 'admin 可以操作预付卡' do
    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success

    post :create, elibao_prepaid_card: {number: '12345678'}
    assert_redirected_to assigns(:elibao_prepaid_card)
  end

  test 'prepaid 角色可以操作预付卡' do
    sign_in admins(:预付费角色)

    get :index
    assert_response :success

    get :show, id: 1
    assert_response :success

    post :create, elibao_prepaid_card: {number: '12345678'}
    assert_redirected_to assigns(:elibao_prepaid_card)
  end

  test '有删除权限角色不可以操作预付卡' do
    sign_in admins(:有删除权限角色)

    assert_raises(CanCan::AccessDenied) { get :index }
    assert_raises(CanCan::AccessDenied) { get :show, id: 1 }
    assert_raises(CanCan::AccessDenied) { get :new, id: 1 }
    assert_raises(CanCan::AccessDenied) { post :create, elibao_prepaid_card: {number: '12345678'} }
  end

  test '普通角色不可以操作预付卡' do
    sign_in admins(:普通角色)

    assert_raises(CanCan::AccessDenied) { get :index }
    assert_raises(CanCan::AccessDenied) { get :show, id: 1 }
    assert_raises(CanCan::AccessDenied) { get :new, id: 1 }
    assert_raises(CanCan::AccessDenied) { post :create, elibao_prepaid_card: {number: '12345678'} }
  end

  # ============================== prepaid_cards 测试 ==============================

  test 'GET #index' do
    get :index

    refute_nil assigns(:elibao_prepaid_cards)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:elibao_prepaid_card).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:elibao_prepaid_card).new_record?
    assert_response :success
  end

  test 'POST #create' do
    post :create, elibao_prepaid_card: {number: '123456', amount: 100}

    assert assigns(:elibao_prepaid_card).persisted?
    assert_redirected_to assigns(:elibao_prepaid_card)
    assert_equal '预付卡新增成功。', flash[:notice]
  end

  test 'POST #lock' do
    xhr :post, :lock, id: 2

    assert_equal 2, assigns(:elibao_prepaid_card).id
    refute assigns(:elibao_prepaid_card).locked_at_changed?
    assert_kind_of ActiveSupport::TimeWithZone, assigns(:elibao_prepaid_card).locked_at
    assert_response :success
  end

  test 'POST #unlock' do
    xhr :post, :unlock, id: 2

    assert_equal 2, assigns(:elibao_prepaid_card).id
    refute assigns(:elibao_prepaid_card).locked_at_changed?
    assert_nil assigns(:elibao_prepaid_card).locked_at
    assert_response :success
  end

  test 'POST #sell' do
    xhr :post, :sell, id: 2

    assert_equal 2, assigns(:elibao_prepaid_card).id
    refute assigns(:elibao_prepaid_card).sold_at_changed?
    assert_kind_of ActiveSupport::TimeWithZone, assigns(:elibao_prepaid_card).sold_at
    assert_response :success
  end

  test 'POST #unsell' do
    xhr :post, :unsell, id: 2

    assert_equal 2, assigns(:elibao_prepaid_card).id
    refute assigns(:elibao_prepaid_card).sold_at_changed?
    refute assigns(:elibao_prepaid_card).sold_at
    assert_response :success
  end

  test 'PATCH #update_password' do
    xhr :patch, :update_password, id: 1, elibao_prepaid_card: { password: '1234', password_confirmation: '1234' }

    assert_equal 1, assigns(:elibao_prepaid_card).id
    refute assigns(:elibao_prepaid_card).changed?
    assert_equal assigns(:elibao_prepaid_card).password, '1234'
    assert_equal assigns(:elibao_prepaid_card).encrypted_password, '1234'

    assert_response :success
  end

  test 'PATCH #show_update_password' do
    xhr :get, :show_update_password, id: 2

    assert_response :success
  end

  test 'GET #rand_password' do
    xhr :get, :rand_password, id: 2

    assert_kind_of Integer, assigns(:newpass)
    assert_operator assigns(:newpass), :<, 100000000
    assert_response :success
  end

  test 'GET #batch_new' do
    get :batch_new

    assert_response :success
  end

  test 'Post #batch_create' do
    initialize_count = Elibao::PrepaidCard.all.count

    # 不输入起始 number 的情况下创建
    post :batch_create, count: 10, amount: 1000, handler: 'zw963'
    assert_equal initialize_count + 10, Elibao::PrepaidCard.all.count
    assert_redirected_to elibao_prepaid_cards_path
    assert_equal flash[:notice], '预付卡批量新增成功 10 个！ 跳过了已经存在的 0 个。'

    # 输入起始 number 的情况下创建
    starting_card_number = Elibao::PrepaidCard.order('number').last.number.to_i + 1
    post :batch_create, count: 10, amount: 1000, handler: 'zw963', starting_card_number: starting_card_number
    assert_equal initialize_count + 20, Elibao::PrepaidCard.all.count
    assert_redirected_to elibao_prepaid_cards_path
    assert_equal flash[:notice], '预付卡批量新增成功 10 个！ 跳过了已经存在的 0 个。'

    # 输入起始 number 的情况下创建，但中间要跳过已创建的 number
    starting_card_number = Elibao::PrepaidCard.order('number').last.number.to_i - 1
    skip_number_1 = starting_card_number
    skip_number_2 = starting_card_number + 1
    skip_card_1 = Elibao::PrepaidCard.find_by_number(skip_number_1)
    skip_card_2 = Elibao::PrepaidCard.find_by_number(skip_number_2)
    post :batch_create, count: 10, amount: 1000, handler: 'zw963', starting_card_number: starting_card_number
    assert_equal initialize_count + 30, Elibao::PrepaidCard.all.count
    assert_redirected_to elibao_prepaid_cards_path
    assert_equal flash[:notice], '预付卡批量新增成功 10 个！ 跳过了已经存在的 2 个。'

    # 验证两个跳过的 number：
    skip_card_1_after_batch_create = Elibao::PrepaidCard.find_by_number(skip_number_1)
    skip_card_2_after_batch_create = Elibao::PrepaidCard.find_by_number(skip_number_2)
    assert_equal skip_card_1, skip_card_1_after_batch_create
    assert_equal skip_card_2, skip_card_2_after_batch_create

    p 'elibao/prepaid_cards_controller_test.rb 循环跳不出时，无限循环的测试不知道怎么写'
    skip
  end
end
