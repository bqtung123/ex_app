require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  test "unsuccessful sign up" do
     get signup_path
     assert_no_difference "User.count" do
       post users_path, params: {  user: {name: "",
                                          email: "example@invalid.org",
                                          password: "foobar",
                                          password_confirmation: ""   }}                                                  
     end
     assert_template "users/new"
   end

   test "successful sign up" do
    get signup_path
    assert_difference "User.count",1 do
      post users_path, params: {  user: {name: "Example Turorial",
                                         email: "example@valid.org",
                                         password: "foobar",
                                         password_confirmation: "foobar"   }}  
      follow_redirect!                                                
    end
    assert_template 'users/show'
  end

  
end
