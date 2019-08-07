# require './test/test_helper'

# class UserTest < ActiveSupport::TestCase
#   test "email validation should trigger" do
#     assert_not User.new(name: 'name', email: 'email',password: 'password').save
#   end

#   test "user should save" do
#     assert User.new(name: 'name', email: 'name@example.org',password: 'password').save
#   end
# end


require 'rails_helper'
RSpec.describe User do
	it "is not valid without a title" do
		user = User.new
		expect(user).not_to be_valid

end

