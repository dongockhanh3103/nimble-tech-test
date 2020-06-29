require 'rails_helper'

describe FetchSearchResult do

  context 'when the job execute' do
    let(:user) { create(:user) }

    it 'FetchSearchResult is called' do
      FetchSearchResult.perform_async('Flower', user.id)

      expect(FetchSearchResult).to have_enqueued_sidekiq_job('Flower', user.id)
    end
  end
end