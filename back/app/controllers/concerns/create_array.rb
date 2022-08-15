module CreateArray
  extend ActiveSupport::Concern
  def create_user_page_array(resource)
    resource.map do |booksShelf|
      {
        id: booksShelf.id,
        user_id: booksShelf.user_id,
        book_id: booksShelf.book_id,
        google_books_api_id: booksShelf.book.google_books_api_id,
        book_image: booksShelf.book.image,
        title: booksShelf.book.title,
        publisher: booksShelf.book.publisher,
        published_at: booksShelf.book.published_at,
        authors: booksShelf.book.authors[0],
        rating: booksShelf.rating,
        comment: booksShelf.comment,
        created_at: booksShelf.created_at,
        tags: booksShelf.tags.select(:id, :name, :taggings_count).map,
        good: booksShelf.goods.select(:id, :user_id, :books_shelf_id).map 
      }
    end
  end

  def create_search_result_array(resource)
    resource.map do |booksShelf|
      {
        id: booksShelf.id,
        user_id: booksShelf.user_id,
        user_image: booksShelf.user.image.thumb.url,
        user_name: booksShelf.user.name,
        google_books_api_id: booksShelf.book.google_books_api_id,
        book_image: booksShelf.book.image,
        title: booksShelf.book.title,
        rating: booksShelf.rating,
        comment: booksShelf.comment,
        created_at: booksShelf.created_at,
        tags: booksShelf.tags.select(:id, :name, :taggings_count).map,
        good: booksShelf.goods.select(:id, :user_id, :books_shelf_id).map
      }
    end
  end
  
end