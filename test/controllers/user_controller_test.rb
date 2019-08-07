require './test/test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_path, params: { user: { email: @user.email, name: @user.name, password: @user.password } }
    end

    assert_redirected_to user_path(User.last)
  end

  test "should show user" do
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_path(@user), params: { user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name } }
    assert_redirected_to user_path(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_path(@user)
    end

    assert_redirected_to users_path
  end
end

