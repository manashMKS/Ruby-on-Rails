class UserRole < ApplicationRecord
	belongs_to :user , optional: true
	has_many :users 
	has_many :permissions , dependent: :destroy
	has_many :menus, through: :permissions ,dependent: :destroy
end
