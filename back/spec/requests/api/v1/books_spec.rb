require 'rails_helper'

RSpec.describe "Books", type: :request do
  it 'searchアクションが有効な事' do
    get search_api_v1_books_path params: { keyword: 'ハリー・ポッターと賢者の石' }
    JSON.parse(response.body)
    expect(response.status).to eq(200)
    puts response.body
  end
  #it 'createアクションが有効な事' do
  #  post api_v1_books_path params: { google_books_api_id: 'jfApAQAAMAAJ' }
  #  JSON.parse(response.body)
  #  expect(response.status).to eq(200)
  #  puts response.body
  #end
end
