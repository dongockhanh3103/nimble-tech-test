require 'rails_helper'

describe Google::StatisticSearchService do

  context 'when google search' do
    it 'successfully with keyword' do
      keyword = 'Flowers'
      result = described_class.new(keyword).execute

      expect(result).to be_present
      expect(result['totalResults']).to be_present
      expect(result['searchTime']).to be_present
    end
  end

  context 'when error occured' do
    it 'raise ArgumentError' do
      allow(described_class).to receive(:new).and_raise(ArgumentError)
    end
  end

end