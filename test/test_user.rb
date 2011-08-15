require File.dirname(__FILE__) + '/common'
include Rdio

class TestUser < RdioTestCase

  def test_find_by_email
    email = 'jeff@jeffpalm.com'
    user = User.find_by_email email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find_by_vanity_name
    name = 'spudtrooper'
    user = User.find_by_vanity_name name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find
    name = 'spudtrooper'
    user = User.find name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find2
    name = 'jeff@jeffpalm.com'
    user = User.find name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_current
    user = User.current
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_get
    user = User.get 's208750'
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_all
    users = User.all 's208750'
    assert_not_nil users
    assert_equal 1,users.length
    user = users[0]
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_all2
    users = User.all ['s208750']
    assert_not_nil users
    assert_equal 1,users.length
    user = users[0]
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_add_friend
    user = User.current
    assert_equal true,User.add_friend(user)
  end

  def test_add_friend2
    that = User.find_by_email 'tim.julien@gmail.com'
    assert_equal true,User.add_friend(that)
  end
  
end
