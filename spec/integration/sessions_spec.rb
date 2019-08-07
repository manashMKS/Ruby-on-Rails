require 'swagger_helper'
describe 'Admins API' do
  path '/api/v1/sessions' do

      post 'Login for Admin' do
      tags 'Admin'
      consumes 'application/json', 'application/xml'
      parameter  name: :session, in: :body, schema: {
      type: :object,
      properties: {
      email: { type: :string },
      password: { type: :string }
      },
      required: [ 'email', 'password' ]
      }
      response '201', 'Admin login successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'invalid request' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end 


  path '/api/v1/sessions/otp_admin' do
      
      post 'for match OTP' do
      tags 'Admin'
      parameter name: :session, in: :body, schema: {
      type: :object,
      properties: {
      email: {type: :string},
      onetimepassword: {type: :integer}
      },
      required: ['otp' ,'email']
      }
      response '201', 'OTP matched' do
      let(:session) { {onetimepassword: "hiii",email: "available"} }
      run_test!
      end
      response '422', 'OTP not matched' do
      let(:session) { {onetimepassword: 'kkkk',email: "hiiii"} }
      run_test!                                 
      end
      end
  end

  path '/api/v1/sessions/show_all_user' do

      post 'for show users' do
      tags 'Admin'
      consumes 'application/json', 'application/xml'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      response '201', 'Fetch all Users' do 
      let(:session) { {name: 'Dodo', email: 'available'} }
      run_test!
      end
      end
  end

  path '/api/v1/sessions/destroy' do

      delete 'for admin logout' do
      tags 'Admin'
      consumes 'application/json' ,'application/xml'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      response '201','admin logout successfully' do
      let(:session) {{token_id: "yfdgugu"}}
      run_test!
      end
      end
  end

  path '/api/v1/sessions/create_users' do

      post 'for create user' do
      tags 'Admin'
      consumes 'application/json', 'application/xml'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :user, in: :body, schema: {
      type: :object,
      properties: {
      name: {type: :string},
      email: { type: :string },
      phone: {type: :string},
      password: { type: :string },
      password_confirmation: {type: :string}
      },
      required: [ 'name','email','phone','password' ]
      }
      response '201', 'User created successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end 


   path '/api/v1/sessions/user_view' do

      post 'to view user profile' do
      tags 'Admin'
      consumes 'application/json', 'application/xml'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :'user profile', in: :body, schema: {
      type: :object,
      properties: {
      email: { type: :string },
      },
      required: [ 'email' ]
      }
      response '201', 'User created successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end 




  path '/api/v1/sessions/user_destroy' do

      delete 'for delete user' do
      tags 'Admin'
      consumes 'application/json' ,'application/xml'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :'user', in: :body, schema: {
      type: :object,
      properties: {
      email: { type: :string },
      },
      required: [ 'email' ]
      }
      response '201', 'User created successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end


  path '/api/v1/sessions/block' do

      post 'for block and unblock user' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :'user', in: :body, schema: {
      type: :object,
      properties: {
      email: { type: :string },
      },
      required: [ 'email' ]
      }
      response '201', 'User blocked successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'not blocked' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end

 path '/api/v1/sessions/user_role_create' do

      post 'for create a role' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :string,
      properties: {
      token_id: {type: :string}
      },
      required: true
      }
      parameter  name: :'user_role', in: :body, schema: {
      type: :object,
      properties: {
      name: { type: :string },
      },
      required: [ 'name' ]
      }
      response '201', 'role created successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'role not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end

  path '/api/v1/sessions/user_role_update' do

      post 'for update a user role' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :'user_role', in: :body, schema: {
      type: :object,
      properties: {
      email: {type: :string},
      name: { type: :string }
      },
      required: [ 'name' ]
      }
      response '201', 'role updated successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'role not updated' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
  end


path '/api/v1/sessions/show_role' do

      post 'for display all roles' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      response '201', 'role updated successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'role not updated' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/role_destroy' do

      delete 'for destroy role' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :'user_role', in: :body, schema: {
      type: :object,
      properties: {
      name: { type: :string }
      },
      required: [ 'name' ]
      }
      response '201', 'role deleted successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'role not deleted' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/content_create' do

      post 'for create a content' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :string,
      properties: {
      token_id: {type: :string}
      },
      required: true
      }
      parameter  name: :'user_role', in: :body, schema: {
      type: :object,
      properties: {
      title: { type: :string },
      latest_content: {type: :string},
      start_date: {type: :datetime},
      end_date: {type: :datetime}
      },
      required: [ 'name' ]
      }
      response '201', 'role created successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'role not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end


path '/api/v1/sessions/content_destroy' do

      delete 'for destroy content' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter  name: :'content', in: :body, schema: {
      type: :object,
      properties: {
      title: { type: :string }
      },
      required: [ 'title' ]
      }
      response '201', 'content deleted successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'content not deleted' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/show_content' do

      post 'for display all content' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      response '201', 'role updated successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'role not updated' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/create_action' do

      post 'for create actions according to menu' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter name: :action,in: :body, schema:{
      type: :string,
      properties: {
      menu: {type: :string},
      action: {type: :string}
      }      
      }
      response '201', 'action created successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/show_menu' do

      post 'for display menu' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      response '201', 'displayed successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'no menu found' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end


path '/api/v1/sessions/permission_management' do

      post 'for Permission management' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      parameter name: :action,in: :body, schema:{
      type: :string,
      properties: {
      role: {type: :string},      
      menu: {type: :string},
      action: {type: :string}
      }      
      }
      response '201', 'permission granted successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'not created' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/show_all_permission' do

      post 'for display all permission' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
      response '201', 'displayed successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'no permission found' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

path '/api/v1/sessions/permission_destroy' do

      delete 'for delete permission' do
      consumes 'application/json' ,'application/xml'
      tags 'Admin'
      parameter name: :auth ,in: :header ,schema:{
      type: :integer,
      properties: {
      token_id: {type: :integer}
      },
      required: true
      }
       parameter  name: :'permission', in: :body, schema: {
      type: :object,
      properties: {
      permission_id: { type: :string }
      },
      required: [ 'id' ]
      }
      response '201', 'deleted successfully' do
      let(:session) { { email: 'Dodo', password: 'available' } }
      run_test!
      end
      response '422', 'no permission found' do
      let(:session) { {email: 'foo' } }
      run_test!
      end
      end
end

end
