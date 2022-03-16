require 'rails_helper'

RSpec.describe User, type: :model do

  it {should validate_presence_of(:username)}
  it {should validate_length_of(:password).is_at_least(6)}
  it {should validate_presence_of(:password_digest)}
  
  describe 'uniqueness' do 
    before(:each) do
      FactoryBot.create(:user)
    end
    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end


  describe "find_by_credentials" do
    before(:each) do
      FactoryBot.create(:socrates)
    end

    context 'finds a valid user' do
      it 'should return correct user' do
        user = User.find_by_credentials('Socrates','password')
        expect(user.username).to eq('Socrates')
        expect(user.is_password?('password')).to be true
      end
    end

    context "doesn't find a valid user" do
      it 'should return nil' do
        user = User.find_by_credentials('Socrates', 'not_password')
        expect(user).to eq(nil)
      end
    end
  end

  describe "is_password?" do
    before(:each) do
      FactoryBot.create(:socrates)
    end
    context "with a valid password" do
      it 'should return true' do
        expect(User.last.is_password?('password')).to be true
      end
    end
    context "with an invalid password" do
      it 'should return false' do
        expect(User.last.is_password?('not_password')).to be false
      end
    end
  end



end