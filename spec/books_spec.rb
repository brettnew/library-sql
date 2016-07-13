require('spec_helper')

describe(Book) do
  describe('.all') do
    it('starts off with no books in the book list') do
      expect(Book.all()).to(eq([]))
    end
  end
  describe('#title') do
    it('tells you the title of the book') do
      test_book = Book.new({:title => "Cookbook for Babies", :author => "Michael Jordan", :id => nil})
      expect(test_book.title()).to(eq("Cookbook for Babies"))
    end
  end
  describe('#author') do
    it('tells you the author of the book') do
      test_book = Book.new({:title => "Cookbook for Babies", :author => "Michael Jordan", :id => nil})
      expect(test_book.author()).to(eq("Michael Jordan"))
    end
  end
  describe('#save') do
    it('saves the books') do
      test_book = Book.new({:title => "Cookbook for Babies", :author => "Michael Jordan", :id => nil})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#==') do
    it('is the same book if it has the same name and author') do
      test_book1 = Book.new({:title => "Cookbook for Babies", :author => "Michael Jordan", :id => nil})
      test_book2 = Book.new({:title => "Cookbook for Babies", :author => "Michael Jordan", :id => nil})
      expect(test_book1).to(eq(test_book2))
    end
  end
end
