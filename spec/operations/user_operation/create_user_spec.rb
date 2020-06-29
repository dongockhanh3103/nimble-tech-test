require 'rails_helper'

describe UserOperation::CreateUser do

  context 'when create a user' do
    it 'successfully with valid email' do
      result = described_class.execute('person@example.com')
      first_user = User.first

      expect(result).to be_present
      expect(result[:id]).to eq(first_user.id)
      expect(result[:email]).to eq(first_user.email)
    end

    it 'failure with invalid email' do
      described_class.execute('person')
      user = User.find_by_email('person')

      expect(user).to be_nil
    end
  end

end