require('spec_helper')

describe(Checkout) do
  describe('.all') do
    it('starts off with no checkouts') do
      expect(Checkout.all()).to(eq([]))
    end
  end
  describe('#checkout_date') do
    it('tells you the date of the checkout') do
      test_checkout = Checkout.new({:checkout_date => Date.new, :book_id => 1, :patron_id => 1, :id => nil})
      expect(test_checkout.checkout_date()).to(eq(Date.new))
    end
  end
  describe('#book_id') do
    it('tells you the book id of the checkout') do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      expect(test_checkout.book_id()).to(eq(1))
    end
  end
  describe('#patron_id') do
    it('tells you the patron id of the checkout') do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      expect(test_checkout.patron_id()).to(eq(1))
    end
  end
  describe('#save') do
    it('saves the checkouts') do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout.save()
      expect(Checkout.all()).to(eq([test_checkout]))
    end
  end
  describe('#==') do
    it('saves the checkouts') do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout2 = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      expect(test_checkout).to(eq(test_checkout2))
    end
  end
  describe("#id") do
    it("sets its ID when you save") do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout.save()
      expect(test_checkout.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe(".find") do
    it("returns a checkout by their ID") do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout.save()
      test_checkout2 = Checkout.new({:checkout_date => "2013-03-03", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout2.save()
      expect(Checkout.find(test_checkout2.id())).to(eq(test_checkout2))
    end
  end
  describe("#due") do
    it("returns the due date which is seven days after the checkout date") do
      test_checkout = Checkout.new({:checkout_date => Date.today, :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout.save()
      expect(test_checkout.due()).to(eq(Date.today.next_day(7).to_s))
    end
  end
  describe("#update") do
    it("lets you update checkout in the database") do
      checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      checkout.save()
      checkout.update({:checkout_date => "2013-03-03"})
      expect(checkout.checkout_date()).to(eq("2013-03-03"))
    end
  end
  describe("#delete") do
    it("lets you delete a checkout from the database") do
      test_checkout = Checkout.new({:checkout_date => "2016-01-01", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout.save()
      test_checkout2 = Checkout.new({:checkout_date => "2013-03-03", :book_id => 1, :patron_id => 1, :id => nil})
      test_checkout2.save()
      test_checkout.delete()
      expect(Checkout.all()).to(eq([test_checkout2]))
    end
  end
end
