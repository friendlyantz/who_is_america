require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has an email' do
    user = User.new(password: "password", password_confirmation: "password")
    expect(user).to_not be_valid

    user.email = "rspec@test.com"  
    expect(user).to be_valid  
  end
  
end
 