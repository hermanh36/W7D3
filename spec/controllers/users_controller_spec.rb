require 'rails_helper'

RSpec.describe UsersController, type: :controller do 

  describe "GET #index" do
    it "renders the user's index" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before(:each) do
      FactoryBot.create(:user)
      # allow(subject).to receive(:current_user).and_return(User.last)
   end
    it "brings up individual user" do
      get :show, params: { id: User.last.id}
      expect(response).to redirect_to(user_url(User.last))
    end
  end
  
  describe "GET #new" do
    it "renders new user form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do


    context 'with valid params' do
      before(:each) do
        post :create, params: { user: { username: 'plato', password: 'starwars'}}
      end
      it 'should create new user' do
        expect(User.last.username).to eq('plato')
      end

      it 'redirects to the users show page' do
        expect(response).to redirect_to(user_url(User.last))
      end

    end

    context 'with invalid params' do
      before(:each) do
        post :create, params: { user: { brain: 'none'}}
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
        expect(response).to have_http_status(422)
      end

      it 'adds error to flash' do
        expect(flash[:errors]).to be_present
      end

    end

  end

end