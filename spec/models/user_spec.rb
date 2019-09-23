require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation tests/examples here
    it 'User needs to have name, password, password confirmation, and email' do
      @user = User.new(name: 'someone', password: 'password', password_confirmation: 'password', email: 'hello@hello.com')
      expect(@user).to be_valid
    end

    it 'Password == password confirmation' do
      @user = User.new(name: 'someone', password: 'password', password_confirmation: 'password1', email: 'hello@hello.com')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it 'email must be unique' do
      @user_test1 = User.create(name: 'someone', password: 'password', password_confirmation: 'password', email: 'hello@hello.com')
      @user_test2 = User.new(name: 'somebody', password: 'password', password_confirmation: 'password', email: 'HELLO@HELLO.com')
      expect(@user_test2).to_not be_valid
      expect(@user_test2.errors.full_messages.first).to eq 'Email has already been taken'
    end

    it 'Email, name must be filled in' do
      @user = User.new(password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Name can't be blank"
      expect(@user.errors.full_messages.second).to eq "Email can't be blank"
    end

    it 'Password must be at least 5 characters' do
      @user = User.new(name: 'someone', password: 'sup', password_confirmation: 'sup', email: 'hello@hello.com')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq 'Password is too short (minimum is 5 characters)'
    end
    end


    describe '.authenticate_with_credentials' do
      before do
        @user = User.create(name: 'someone', password: 'password', password_confirmation: 'password', email: 'hello@hello.com')
        expect(@user).to be_valid
      end
  
      it 'Login with right inputs' do
        @login = User.authenticate_with_credentials('hello@hello.com', 'password')
        expect(@login.name).to eq 'someone'
      end
  
      it 'Login with right info, with space before email' do
        @login = User.authenticate_with_credentials('   hello@hello.com ', 'password')
        expect(@login.name).to eq 'someone'
      end
  
      it 'Login with right info, with wrong letter case in email' do
        @login = User.authenticate_with_credentials('hello@Hello.coM', 'password')
        expect(@login.name).to eq 'someone'
      end
  
      it 'Fail login with incorrect password' do
        @login = User.authenticate_with_credentials('hello@hello.com', 'test')
        expect(@login).to be_nil
      end
  
      it 'Fails to login with nil password' do
        @login = User.authenticate_with_credentials('hello@hello.com', nil)
        expect(@login).to be_nil
      end
  
      it 'Fail to login with incorrect email' do
        @login_attempt = User.authenticate_with_credentials('hello@test.com', 'password')
        expect(@login).to be_nil
      end
  
      it 'Fail to login with nil email' do
        @login = User.authenticate_with_credentials(nil, 'password')
        expect(@login).to be_nil
      end
  
    end

  end