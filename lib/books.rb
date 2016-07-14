class Book
  attr_reader(:title, :author_id, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author_id = attributes.fetch(:author_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      author_id = book.fetch('author_id').to_i
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :author_id => author_id, :id => id}))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@title}', '#{@author_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.id().==(another_book.id())).&(self.author_id().==(another_book.author_id()))
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    attributes.fetch(:patron_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO checkouts (book_id, patron_id) VALUES (#{self.id()}, #{patron_id});")
    @id = self.id()
    end
  end

  define_method(:patrons) do
    checkouts = []
    results = (DB.exec("SELECT patron_id FROM checkouts WHERE book_id = #{self.id()};"))
    results.each() do |result|
      patron_id = result.fetch("patron_id").to_i
      patron = DB.exec("SELECT * FROM patron WHERE id = #{patron_id};")
      patron_name = patron.first().fetch("patron_name")
      checkouts.push(Patron.new({:patron_name => patron_name, :id => patron_id}))
    end
    checkouts
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

  define_method(:author) do
    author = Author.find(@author_id)
    author
  end
  define_singleton_method(:find_book) do |search_term|
    result = DB.exec("SELECT * FROM books WHERE title = '#{search_term}'").first
    title = result.fetch('title')
    author_id = result.fetch('author_id').to_i
    id = result.fetch('id').to_i
    returned_book = Book.new({:title => title, :author_id => author_id, :id => id})
  end
end
