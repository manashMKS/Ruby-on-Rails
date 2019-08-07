require_relative 'spec_helper'

require './../spec_helper'
require './../rails_helper'
RSpec.describe User do
	it "is not valid without a title" do
		user = User.new
		expect(user).not_to be_valid

end
end