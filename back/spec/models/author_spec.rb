require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'アソシエーションテスト' do
    subject(:author) { create(:author) }

    it { is_expected.to belong_to(:book) }
  end
end
