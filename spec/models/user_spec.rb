require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should succeed when given required parameters' do
      user = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user.save!  # cause failure if any errors
      user.destroy
    end

    it 'should fail when missing the name' do
      user = User.new({
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user.save
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should fail when missing the email' do
      user = User.new({
        :name => 'test_name',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user.save
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should fail when missing the password' do
      user = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password_confirmation => 'testtest'
      })
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should fail when missing the password confirmation' do
      user = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest'
      })
      user.save
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should fail when the password and password_confirmation do not match' do
      user = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'fail me'
      })
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should fail when with duplicate emails' do
      user1 = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user1.save
      user2 = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user2.save
      expect(user2.errors.full_messages).to include("Email has already been taken")

      user1.destroy
    end

    it 'should fail when with duplicate emails (case insensitive)' do
      user1 = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user1.save
      user2 = User.new({
        :name => 'test_name',
        :email => 'TEST@TEST.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      user2.save
      expect(user2.errors.full_messages).to include("Email has already been taken")

      user1.destroy
    end
  end
end
