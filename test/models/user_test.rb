require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end
  
  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end
  
  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a unique profile name" do
    user = User.new
    user.first_name = "Jason"
    user.last_name = "Seifer"
    user.email = "jason@teamtreehouse.com"
    user.profile_name = "jasonseifer"
    user.password = "password"
    user.password_confirmation = "password"

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
      user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'jason2@teamtreehouse.com')
      user.password = user.password_confirmation = 'abcdefgh'
      
      user.profile_name = "My Profile With Spaces"

      assert !user.save
      assert !user.errors[:profile_name].empty?
      assert user.errors[:profile_name].include?("Must be formatted correctly.") 
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'jason2@teamtreehouse.com')
    user.password = user.password_confirmation = 'abcdefgh'
    user.profile_name = 'jasonseifer_1'
    assert user.valid?
  end

  test "that no error when accessing a friend list" do
    assert_nothing_raised do
      users(:jason).friends
    end
  end

  test "that creating friendships work" do
    users(:jason).friends << users(:mike)
    users(:jason).friends.reload
    assert users(:jason).friends.include?(users(:mike))
  end

  test "that creating friendships work based on ids" do
    UserFriendship.create user_id: users(:jason).id, friend_id: users(:mike).id
    assert users(:jason).friends.include?(users(:mike))


  end

end
