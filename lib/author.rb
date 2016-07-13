class Author
  attr_reader(:author_name, :id)

  define_method(:initialize) do |attributes|
    @author_name = attributes.fetch(:author_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM author;")
    authors = []
    returned_authors.each() do |author|
      author_name = author.fetch('author_name')
      id = author.fetch('id').to_i
      authors.push(Author.new({:author_name => author_name, :id => id}))
    end
    authors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO author (author_name) VALUES ('#{@author_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_author|
    self.author_name().==(another_author.author_name()).&(self.id().==(another_author.id()))
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all().each() do |author|
      if author.id().==(id)
        found_author = author
      end
    end
    found_author
  end

  define_method(:update) do |attributes|
    @author_name = attributes.fetch(:author_name)
    @id = self.id()
    DB.exec("UPDATE author SET author_name = '#{@author_name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM author WHERE id = #{self.id()}")
  end
end
