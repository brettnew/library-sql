class Checkout
  attr_reader(:checkout_date, :book_id, :patron_id, :id)

  define_method(:initialize) do |attributes|
    @checkout_date = attributes.fetch(:checkout_date)
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    checkouts = []
    returned_checkouts.each() do |checkout|
      checkout_date = checkout.fetch('checkout_date')
      book_id = checkout.fetch('book_id').to_i
      patron_id = checkout.fetch('patron_id').to_i
      id = checkout.fetch('id').to_i
      checkouts.push(Checkout.new({:checkout_date => checkout_date, :book_id => book_id, :patron_id => patron_id, :id => id}))
    end
    checkouts
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO checkouts (checkout_date, book_id, patron_id) VALUES ('#{@checkout_date}', '#{@book_id}', '#{@patron_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_checkout|
    self.checkout_date().==(another_checkout.checkout_date()).&(self.id().==(another_checkout.id())).&(self.book_id().==(another_checkout.book_id())).&(self.patron_id().==(another_checkout.patron_id()))
  end

  define_method(:due) do
    due_date = Date.today.next_day(7).to_s
  end

  define_singleton_method(:find) do |id|
    found_checkout = nil
    Checkout.all().each() do |checkout|
      if checkout.id().==(id)
        found_checkout = checkout
      end
    end
    found_checkout
  end

  define_method(:update) do |attributes|
    @checkout_date = attributes.fetch(:checkout_date, @checkout_date)
    DB.exec("UPDATE checkouts SET checkout_date = '#{@checkout_date}' WHERE id = #{@id};")
    @id = self.id()
    end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE id = #{self.id()};")
  end
end
