class Patron
  attr_reader(:patron_name, :id)

  define_method(:initialize) do |attributes|
    @patron_name = attributes.fetch(:patron_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patron;")
    patrons = []
    returned_patrons.each() do |patron|
      patron_name = patron.fetch('patron_name')
      id = patron.fetch('id').to_i
      patrons.push(Patron.new({:patron_name => patron_name, :id => id}))
    end
    patrons
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patron (patron_name) VALUES ('#{@patron_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patron|
    self.patron_name().==(another_patron.patron_name()).&(self.id().==(another_patron.id()))
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all().each() do |patron|
      if patron.id().==(id)
        found_patron = patron
      end
    end
    found_patron
  end

  define_method(:update) do |attributes|
    @patron_name = attributes.fetch(:patron_name, @patron_name)
    DB.exec("UPDATE patron SET patron_name = '#{@patron_name}' WHERE id = #{@id};")
    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO checkouts (book_id, patron_id) VALUES (#{book_id}, #{self.id()});")
    @id = self.id()
    end
  end



  define_method(:books) do
    checkouts = []
    results = (DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{self.id()};"))
    results.each() do |result|
      book_id = result.fetch("book_id").to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author_id = book.first.fetch("author_id").to_i
      checkouts.push(Book.new({:title => title, :author_id => author_id, :id => book_id}))
    end
    checkouts
  end


  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE patron_id =#{self.id()};")
    DB.exec("DELETE FROM patron WHERE id = #{self.id()};")
  end

end
