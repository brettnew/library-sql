require('spec_helper')

describe(Patron) do
  describe('.all') do
    it('starts off with no patrons in the patron list') do
      expect(Patron.all()).to(eq([]))
    end
  end
  describe('#patron_name') do
    it('tells you the name of the patron') do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      expect(test_patron.patron_name()).to(eq("Tyra Banks"))
    end
  end
  describe('#save') do
    it('saves the patrons') do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end
  describe('#==') do
    it('is the same patron if it has the same id and patron') do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron2 = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      expect(test_patron).to(eq(test_patron2))
    end
  end
  describe("#id") do
    it("sets its ID when you save") do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron.save()
      expect(test_patron.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe(".find") do
    it("returns an patron by their ID") do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron.save()
      test_patron2 = Patron.new({:patron_name => "Mr. Rogers", :id => nil})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end
  end
  describe("#update") do
    it("lets you update patrons in the database") do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron.save()
      test_patron.update({:patron_name => "Barack Obama"})
      expect(test_patron.patron_name()).to(eq("Barack Obama"))
    end
    it("lets you add patrons to a book") do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron.save()
      test_book1 = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      test_book1.save()
      test_book2 = Book.new({:title => "Cookbook for Sloths", :author_id => 1, :id => nil})
      test_book2.save()
      test_patron.update({:book_ids => [test_book1.id(), test_book2.id()]})
      expect(test_patron.books()).to(eq([test_book1, test_book2]))
    end
  end
  describe("#books") do
    it("returns all of the books that have been checked out by a patron") do
      test_patron = Patron.new({:patron_name => "Tyra Banks", :id => nil})
      test_patron.save()
      test_book1 = Book.new({:title => "Cookbook for Babies", :author_id => 1, :id => nil})
      test_book1.save()
      test_book2 = Book.new({:title => "Cookbook for Sloths", :author_id => 1, :id => nil})
      test_book2.save()
      test_patron.update({:book_ids => [test_book1.id(), test_book2.id()]})
      expect(test_patron.books()).to(eq([test_book1, test_book2]))
    end
  end
  describe("#delete") do
    it("lets you delete a patron from the database") do
      test_patron = Patron.new({:patron_name => "Michelle Obama", :id => nil})
      test_patron.save()
      test_patron2 = Patron.new({:patron_name => "Malia Obama", :id => nil})
      test_patron2.save()
      test_patron.delete()
      expect(Patron.all()).to(eq([test_patron2]))
    end
  end
end
