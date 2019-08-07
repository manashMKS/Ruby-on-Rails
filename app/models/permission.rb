class Permission < ApplicationRecord
  belongs_to :user_role, optional: true
  belongs_to :menu, optional: true



 
end
