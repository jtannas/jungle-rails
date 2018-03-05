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

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new({
        :name => 'test_name',
        :email => 'test@test.com',
        :password => 'testtest',
        :password_confirmation => 'testtest'
      })
      @user.save!  # cause failure if any errors
    end

    after(:each) do
      @user.destroy
      remove_instance_variable(:@user)
    end

    it 'should return a user when given the correct credentials' do
      user = User.authenticate_with_credentials(@user.email, 'testtest')
      expect(user).to eq(@user)
    end

    it 'should return nil when given the incorrect credentials' do
      user = User.authenticate_with_credentials(@user.email, 'no match')
      expect(user).to be_nil
    end

    it 'should return nil when missing credentials' do
      user = User.authenticate_with_credentials(nil, nil)
      expect(user).to be_nil
    end

    it 'should succeed with a padded emails' do
      user = User.authenticate_with_credentials('    ' + @user.email, 'testtest')
      expect(user).to eq(@user)
    end

    it 'should succeed with incorrect case email' do
      user = User.authenticate_with_credentials(@user.email.upcase, 'testtest')
      expect(user).to eq(@user)
    end
  end
end
