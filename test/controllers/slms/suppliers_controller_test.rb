class Slms::SuppliersControllerTest < ActionController::TestCase
  setup do
    sign_in admins(:admin)
  end

  test 'GET #index' do
    get :index

    refute_nil assigns(:slms_suppliers)
    assert_response :success
  end

  test 'GET #show' do
    get :show, id: 1

    assert_equal 1, assigns(:slms_supplier).id
    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert assigns(:slms_supplier).new_record?
    assert_response :success
  end

  test 'GET #edit' do
    get :edit, id: 1

    assert_equal 1, assigns(:slms_supplier).id
    assert_response :success
  end

  test 'POST #create' do
    post :create, slms_supplier: {name: "运动供应商"}

    assert assigns(:slms_supplier).persisted?
    assert_redirected_to assigns(:slms_supplier)
    assert_equal '新增成功。', flash[:notice]
  end

  test 'PATCH #update' do
    patch :update, id: 1, slms_supplier: {name: "运动供应商"}

    refute assigns(:slms_supplier).changed?
    assert_equal 1, assigns(:slms_supplier).id
    assert_equal '运动供应商', assigns(:slms_supplier).name
    assert_redirected_to assigns(:slms_supplier)
    assert_equal '修改成功。', flash[:notice]
  end

  test 'DELETE #destroy' do
    delete :destroy, id: 1

    assert assigns(:slms_supplier).destroyed?
    assert_redirected_to slms_suppliers_url
  end

end
