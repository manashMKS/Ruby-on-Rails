class Menu < ApplicationRecord
		belongs_to :action , optional: true
		has_many :actions ,dependent: :destroy
end
