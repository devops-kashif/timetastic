require "./test/test_helper.rb"

class TimetasticUserTest < Minitest::Test
  def test_exists
    assert Timetastic::User
  end

  def test_it_gives_back_a_single_user
    VCR.use_cassette('one_user') do
      user = Timetastic::User.find('271886')
      assert_equal Timetastic::User, user.class
      assert_equal 271886, user.id
      assert_equal "Kashif", user.firstname
      assert_equal "Ishaque", user.surname
      assert_equal "devops.kashif@gmail.com", user.email
    end
  end

  def test_it_gives_back_all_users
    VCR.use_cassette('all_users') do
      result = Timetastic::User.all
      assert result.kind_of?(Array)
    end
  end

  def test_it_gives_back_all_users_with_filters
    VCR.use_cassette('all_users_filtered') do
      result = Timetastic::User.all({:departmentId => 83865},{'email' => 'devops.kashif@gmail.com'})
      assert result.kind_of?(Array)
    end
  end
end
