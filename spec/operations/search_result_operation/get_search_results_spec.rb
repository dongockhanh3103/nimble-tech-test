require 'rails_helper'

describe SearchResultOperation::GetSearchResults do
  let!(:first_user) { create(:user) }
  let!(:second_user) { create(:user) }
  let!(:search_result) { create_list(:search_result, 5, user: first_user) }

  context 'when get search result successfully' do
    it 'with valid user' do
      result = described_class.execute(first_user.id)

      expect(result).to be_present
      expect(result.size).to eq(5)
    end

    it 'returns empty list with user does not belongs to any search results' do
      result = described_class.execute(second_user.id)

      expect(result).to be_blank
    end

    it 'returns the list that has keywords was sorted ' do
      result = described_class.execute(first_user.id).pluck(:keyword)
      search_result_sorted = SearchResult.all.pluck(:keyword).sort

      expect(result).to eq(search_result_sorted)
    end
  end

  context 'when get search result failure' do
    it 'without user' do
      result = described_class.execute(nil)

      expect(result).to be_blank
    end
  end
end