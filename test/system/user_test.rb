# require "application_system_test_case"
require './test/test_helper'

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit users_path
    assert_selector "h1", text: "User"
  end

  test "should create user" do
    visit new_user_url
    fill_in 'name', with: 'name'
    fill_in 'email', with: 'email'
    fill_in 'password', with: 'password'
    click_button 'Create User'

    visit users_path
    within 'table' do
      assert_selector 'tr td', text: 'name'
      assert_selector 'tr td', text: 'email'
      assert_selector 'tr td', text: 'password'
    end
  end
end