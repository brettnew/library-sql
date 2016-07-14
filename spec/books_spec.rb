require('spec_helper')

describe(Book) do
  describe('.all') do
    it('starts off with no books in the book list') do
      expect(Book.all()).to(eq([]))
    end
  end
  describe('#title') do
    it('tells you the title of the book') do
      test_book = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      expect(test_book.title()).to(eq("Cookbook for Babies"))
    end
  end
  describe('#author_id') do
    it('tells you the author id of the book') do
      test_book = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      expect(test_book.author_id()).to(eq(1))
    end
  end
  describe('.save') do
    it('saves the books') do
      test_book = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end
  describe('#==') do
    it('is the same book if it has the same name and author') do
      test_book1 = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      test_book2 = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      expect(test_book1).to(eq(test_book2))
    end
  end
  describe("#id") do
    it("sets its ID when you save") do
      test_book = Book.new({:title => "Cookbook for Babies from Louisiana", :author_id => 1, :id => nil})
      test_book.save()
      expect(test_book.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe(".find") do
    it("returns a book by their ID") do
      test_book = Book.new({:title => "Cookbook for Babies from Louisiana", :author_id => 1, :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      test_book2.save()
      expect(Book.find(test_book2.id())).to(eq(test_book2))
    end
  end
  describe("#update") do
    it("lets you update books in the database") do
      book = Book.new({:title => "Cookbook for Sloths", :author_id => 1, :id => nil})
      book.save()
      book.update({:title => "Cookbook for Butterflies"})
      expect(book.title()).to(eq("Cookbook for Butterflies"))
    end
    it("lets you add book to a patron") do
      book = Book.new({:title => "Poop Book", :author_id => 1, :id => nil})
      book.save()
      test_patron1 = Patron.new({:patron_name => "Cookbook for Robin Williams", :id => nil})
      test_patron1.save()
      test_patron2 = Patron.new({:patron_name => "Cookbook for Robin Williams", :id => nil})
      test_patron2.save()
      book.update({:patron_ids => [test_patron1.id(), test_patron2.id()]})
      expect(book.patrons()).to(eq([test_patron1, test_patron2]))
    end
  end

  describe("#patrons") do
    it("returns all of the patrons that have checked out a book") do
      book = Book.new({:title => "Poop Book", :author_id => 1, :id => nil})
      book.save()
      test_patron1 = Patron.new({:patron_name => "Cookbook for Robin Williams", :id => nil})
      test_patron1.save()
      test_patron2 = Patron.new({:patron_name => "Cookbook for Robin Williams", :id => nil})
      test_patron2.save()
      book.update({:patron_ids => [test_patron1.id(), test_patron2.id()]})
      expect(book.patrons()).to(eq([test_patron1, test_patron2]))
    end
  end

  describe("#delete") do
    it("lets you delete a book from the database") do
      test_book = Book.new({:title => "Cookbook for Babies from Louisiana", :author_id => 1, :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      test_book2.save()
      test_book.delete()
      expect(Book.all()).to(eq([test_book2]))
    end
  end

  describe("#author") do
    it("returns author object for a book") do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      test_author.save()
      test_book = Book.new({:title => "Cookbook for Babies from Louisiana", :author_id => test_author.id(), :id => nil})
      test_book.save()
      expect(test_book.author()).to(eq(test_author))
    end
  end
  describe(".find_book") do
    it("returns books to match search") do
      test_book = Book.new({:title => "Cookbook for Babies from Louisiana", :author_id => 1, :id => nil})
      test_book.save()
      test_book2 = Book.new({:title => "Cooking with Babies from Louisiana", :author_id => 1, :id => nil})
      test_book2.save()
      expect(Book.find_book(test_book.title)).to(eq(test_book))
    end
  end

end
