FactoryBot.define do
  factory :google_book do
    google_books_api_id { 'jfApAQAAMAAJ' }
    authors do
      [
        'J.K. ローリング',
        'Jack Thorne',
        'John Tiffany'
      ]
    end
    image { 'http://books.google.com/books/content?id=jfApAQAAMAAJ&printsec=frontcover&img=1&zoom=5&imgtk=AFLRE72IlxDX7JlCF27ukfeQFQA9tOZoVuGgKpaLra0njJmR3Gu3vPnudN7dyrN4EfQkxKK9hjYNjm4n4JvKk-z8j0ObEBSnQ6Ym6gMiQAymfjJpwaZBb2CJe8J8LOCOqhaL1DurO6yE&source=gbs_api' }
    published_at { '2018-01-24' }
    title { 'ハリー・ポッターと賢者の石' }
  end
end