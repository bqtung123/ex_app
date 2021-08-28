require "test_helper"

class UserTest < ActiveSupport::TestCase
    def setup
       @user= User.new(name: "Example User", email: "example@tutorial.org",password: 'foobar', password_confirmation: 'foobar')
    end

    test "user should be valid" do
       assert @user.valid?
    end

    test "name should not blank" do 
      @user.name= "    "
      assert_not @user.valid?
    end

    test "email should not blank" do 
      @user.email= "    "
      assert_not @user.valid?
    end

    test "email should maximum 255 characters" do
       @user.email = "a" * 244 + "@example.com"
       assert_not @user.valid?
    end

    test "name should be maximum 50 characters" do 
      @user.name= "A" * 51
      assert_not @user.valid?
    end

    test "email invalid" do 
       email_invalid =%w[user@example,com user_at_foo.org user.name@example.
                                  foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      email_invalid.each do |invalid|
        @user.email= invalid
        assert_not @user.valid?, "#{@user.email.inspect} is invalid"
      end
    end

    test "email should be unique" do
       duplicate_user = @user.dup
       duplicate_user.email = @user.email.upcase
       @user.save
       assert_not duplicate_user.valid?
    end

    test "before_save downcase" do
      duplicate_user = @user.dup
      @user.email = @user.email.upcase
      @user.save
      assert_equal duplicate_user.email , @user.reload.email
    end
    test "password minimum 6" do
       @user.password= @user.password_confirmation = 'a'*5
       assert_not @user.valid?
    end

    test "password no blank" do
      @user.password= @user.password_confirmation = "    "
      assert_not @user.valid?
   end
end
