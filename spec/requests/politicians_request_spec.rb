require 'rails_helper'

RSpec.describe '/posts', type: :request do
  current_user = User.first
  
  # current_user = User.first_or_create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')
  let(:valid_attributes) do
    {
      # skip("Add a hash of attributes valid for your model")
      'id' => '1',
      'title' => 'Test',
      'body' => '12345',
      'user' => current_user,
      'views' => '0'
    }
  end

  let(:invalid_attributes) do
    {
      # skip("Add a hash of attributes invalid for your model")
      'id' => 'a',
      'title' => '1',
      'body' => '123'
      # 'views' => 'a'
      # TODO: do custom inavlid attr  #
    }
  end

  puts "let "
  # =========== P-UPD ======================

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested politician' do
        politician = Politician.new(valid_attributes)
        politician.user = current_user
        politician.save

        patch politician_url(politician), params: { politician: new_attributes }
        politician.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the politician' do
        politician = Politician.new(valid_attributes)
        politician.user = current_user
        politician.save
        patch politician_url(politician), params: { politician: new_attributes }
        politician.reload
        expect(response).to redirect_to(politician_url(politician))
      end
    end

    # context 'with invalid parameters' do
    #   it "renders a successful response (i.e. to display the 'edit' template)" do
    #     # politician = Politician.update(valid_attributes)
    #     # politician.user = current_user
    #     # politician.save

    #     patch politician_url(politician), params: { politician: invalid_attributes }
    #     expect(response).to be_successful
    #   end
    # end
  end
end