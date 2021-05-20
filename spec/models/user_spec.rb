require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user){
    described_class.new(
      email: 'test@test.com',
      password: 'password',
      username: 'testuser'
    )
  }

  it 'is valid with validattributes' do
    expect(user).to be_valid
  end

  describe 'validations' do
    it 'should be invalid without username' do
      user.username = nil
      expect(user).to_not be_valid
    end
    it 'should be invalid without email' do
      user.email = nil
      expect(user).to_not be_valid
    end
    it 'should be invalid without password' do
      user.password = nil
      expect(user).to_not be_valid
    end
    it 'should be invalid with a password less than 8 characters' do
      user.password = 'hellome'
      expect(user).to_not be_valid
    end
    
  end
end
