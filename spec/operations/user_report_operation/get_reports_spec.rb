require 'rails_helper'

describe UserReportOperation::GetReports do
  let(:first_user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:third_user) { create(:user) }

  context 'when get reports' do
    it 'returns a list of reports of the current user' do
      create_list(:user_report, 4, user: first_user, state: UserReport.states[:success])
      create_list(:user_report, 1, user: second_user, state: UserReport.states[:success])
      create_list(:user_report, 3, user: second_user, state: UserReport.states[:failed])

      result = described_class.execute(first_user.id)

      expect(result).to be_present
      expect(result.size).to eq(4)
    end

    it 'returns empty list of reports due to the states is failed' do
      create_list(:user_report, 3, user: second_user, state: UserReport.states[:failed])
      result = described_class.execute(second_user.id)

      expect(result.size).to eq(0)
    end

    it 'returns empty list of reports if dont have any reports belongs to user' do
      result = described_class.execute(third_user.id)
      
      expect(result.size).to eq(0)
    end
  end

end