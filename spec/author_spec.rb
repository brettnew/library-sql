require('spec_helper')

describe(Author) do
  describe('.all') do
    it('starts off with no books in the book list') do
      expect(Author.all()).to(eq([]))
    end
  end
  describe('#author_name') do
    it('tells you the name of the author') do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      expect(test_author.author_name()).to(eq("Michael Jordan"))
    end
  end
  describe('#save') do
    it('saves the authors') do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      test_author.save()
      expect(Author.all()).to(eq([test_author]))
    end
  end
  describe('#==') do
    it('is the same author if it has the same id and author') do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      test_author2 = Author.new({:author_name => "Michael Jordan", :id => nil})
      expect(test_author).to(eq(test_author2))
    end
  end
  describe("#id") do
    it("sets its ID when you save") do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      test_author.save()
      expect(test_author.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe(".find") do
    it("returns an author by their ID") do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      test_author.save()
      test_author2 = Author.new({:author_name => "Steph Curry", :id => nil})
      test_author2.save()
      expect(Author.find(test_author2.id())).to(eq(test_author2))
    end
  end
  describe("#update") do
    it("lets you update authors in the database") do
      test_author = Author.new({:author_name => "Michael Jordan", :id => nil})
      test_author.save()
      test_author.update({:author_name => "Chris Bosh"})
      expect(test_author.author_name()).to(eq("Chris Bosh"))
    end
  end
  describe("#delete") do
    it("lets you delete a author from the database") do
      test_author = Author.new({:author_name => "John Stockton", :id => nil})
      test_author.save()
      test_author2 = Author.new({:author_name => "Karl Malone", :id => nil})
      test_author2.save()
      test_author.delete()
      expect(Author.all()).to(eq([test_author2]))
    end
  end
end
