require "test_helper"

class LayoutTest < ActionDispatch::IntegrationTest
   test "test link" do
     get root_path
     assert_template 'static_pages/home'
     assert_select 'a[href=?]', root_path, count: 2
     assert_select 'a[href=?]', help_path
     assert_select 'a[href=?]', about_path
   end
end
