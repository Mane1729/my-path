require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #result' do
    let(:user) { create(:user_with_profile) }
    context 'when the user is found' do
      before do
        session[:user_id] = user.id
      end

      subject(:result) do
        get :result
        response
      end

      it "returns a 200" do
        expect(result).to have_http_status(:ok)
      end

      it 'assigns the user' do
        result
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the result template' do
        expect(result).to render_template(:result)
      end
    end

    context 'when the user is not found' do
      it 'raises a record not found error' do
        expect { get :result }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST /predict_career' do
    context 'with valid user attributes' do
      let(:valid_params) do
        {
          working_hours: 8,
          public_speaking_points: 5,
          self_learning: 'yes',
          extra_courses: 'no',
          plays_games: 'yes',
          team_player: 'yes',
          introvert: 'no',
          reading_writing_skills: 'medium',
          memory_capability: 'excellent',
          interested_subject: 'networks',
          fav_book_genre: 'Mystery',
          behaviour: 'gentle',
          salary_work: 'salary',
          management_technical: 'Technical',
          worker_type: 'smart worker'
        }
      end

      before do
        allow(CareerPredictor).to receive(:call).and_return('Database Developer')
      end

      subject(:result) do
        post :predict_career, params: { user: valid_params }
        response
      end

      it "returns a 301" do
        expect(result).to have_http_status(:moved_permanently)
      end

      it 'creates a new user' do
        expect { result }.to change(User, :count).by(1)
      end

      it 'predicts and updates career attribute' do
        result
        expect(User.last.career).to eq('Database Developer')
      end
    end

    context '"with invalid user attributes"' do
      let(:invalid_params) do
        {
          public_speaking_points: 5,
          self_learning: 'yes',
          extra_courses: 'no',
          plays_games: 'yes',
          team_player: 'yes',
          introvert: 'no',
          reading_writing_skills: 'medium',
          memory_capability: 'excellent',
          interested_subject: 'networks',
          fav_book_genre: 'Mystery',
          behaviour: 'gentle',
          salary_work: 'salary',
          management_technical: 'Technical',
          worker_type: 'smart worker'
        }
      end

      subject(:result) do
        post :predict_career, params: { user: invalid_params }
        response
      end

      it "returns a 422" do
        expect(result).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({"profile.working_hours"=>["can't be blank"]})
      end

      it 'does not create a new user' do
        expect { result }.not_to change(User, :count)
      end
    end
  end
end
