require 'rails_helper'

describe AttachmentOperation::FetchData do
  let(:user) { create(:user) }
  let(:csv) do
    {
      file: ['Flower']
    }
  end

  let(:empty_csv) { {} }
  context 'when Fetch data from Google Search' do
    it 'successfully with valid file and exist user' do
      result = described_class.execute(csv, user)

      expect(result[:success]).to eq(true)
      expect(FetchSearchResult).to have_enqueued_sidekiq_job('Flower', user.id)
    end

    it 'failure with invalid file and exist user' do
      result = described_class.execute(empty_csv, user)

      expect(result[:success]).to eq(false)
    end
  end
end