require 'rails_helper'

describe SearchResultOperation::CreateSearchResult do

  let(:user) { create(:user) }
  let(:first_result) do
    {
      'searchTime' => 123400,
      'totalAdwords' => 10000,
      'totalResults'=> 200000,
      'htmlContent' => 'content',
      'totalLinks' => 2
    }
  end

  let(:second_result) do
    {
      'searchTime' => 123400
    }
  end

  context 'when create search result successfully' do
    it 'with full parameters' do
      keyword = 'Flowers'
      search_result = described_class.execute(keyword: keyword, result: first_result,user_id: user.id)

      expect(search_result).to be_present
      expect(search_result.search_time).to eq(first_result['searchTime'])
      expect(search_result.total_ad_word).to eq(first_result['totalAdwords'])
      expect(search_result.html_content).to eq(first_result['htmlContent'])
      expect(search_result.total_link).to eq(first_result['totalLinks'])
    end

    it 'with lack of some parameters' do
      keyword = 'Toy'
      search_result = described_class.execute(keyword: keyword, result: second_result,user_id: user.id)

      expect(search_result).to be_present
      expect(search_result.search_time).to eq(first_result['searchTime'])
      expect(search_result.total_ad_word).to eq(0)
      expect(search_result.html_content).to be_nil
      expect(search_result.total_link).to eq(0)
    end
  end

  context 'when create search result failure' do 
    it 'with lack of keyword' do
      search_result = described_class.execute(keyword: nil, result: first_result, user_id: user.id)

      expect(search_result).to be_nil
    end
  end

end