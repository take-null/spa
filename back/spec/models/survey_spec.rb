require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'バリデーションテスト' do
    context '新規投稿' do
      subject(:survey) { create(:survey) }
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title) }
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_length_of(:content) }
    end

    it 'title及びcontetnの文字数が140文字以下なら成功' do
      survey = create(:survey)
      survey.title = "a" * 140
      survey.content = "a" * 140
      expect(survey).to be_valid
    end
    
    it 'titleの文字数が140文字を超えたら失敗' do
      survey = create(:survey)
      survey.title = "a" * 141
      survey.content = "a" * 140
      expect(survey).to_not be_valid
    end
    
    it 'contentの文字数が140文字を超えたら失敗' do
      survey = create(:survey)
      survey.title = "a" * 140
      survey.content = "a" * 141
      expect(survey).to_not be_valid
    end
  end

  describe 'アソシエーションテスト' do
    subject(:survey) { create(:survey) }
    
    it { is_expected.to belong_to(:user) }
  end
end
