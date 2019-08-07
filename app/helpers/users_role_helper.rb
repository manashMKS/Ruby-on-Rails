module UsersRoleHelper

def return_menu_id(menu_name)
        # binding.pry
        menu_id_hash = current_user&.user_role&.permissions&.pluck(&:menu_id)
        menu_names = menu_id_hash&.map{ |x| Menu.find_by(id: x)&.menu }

        if menu_names&.include?(menu_name)
            return Menu.find_by(menu: menu_name)&.id
        else
            return nil
        end
    end

def return_action_id(action_name)
    action = current_user.user_role.permissions.pluck(:permission)#.map{ |x| Action.find_by(menu_id: x)&.action }
    if action&.include?(action_name)
        return Action.find_by(action: action_name)

    else
        return nil
    end
end
    def permission_status(permission_name)
        current_user&.user_role&.permissions&.pluck(:permission_name)&.include?(permission_name) || check_supreme
    end
end
