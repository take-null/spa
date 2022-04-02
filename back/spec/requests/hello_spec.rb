require 'rails_helper'
#'افتح يا سمسم' <= CIが構築出来たら'hello'と差し替える
RSpec.describe "Hellos", type: :request do
  let(:base_title) { 'hello' }
  describe "GET /api/v1/hello" do
    #pending "add some examples (or delete) #{__FILE__}"
    it "shourd get hello" do
      get '/api/v1/hello'
      expect(response).to have_http_status(200)
      expect(response.body).to include "#{base_title}"
    end
  end
end
