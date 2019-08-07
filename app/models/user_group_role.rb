class UserGroupRole < ApplicationRecord
  belongs_to :user , optional: true
  belongs_to :user_role
end
