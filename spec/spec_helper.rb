require('rspec')
require('pg')
require('books')
require('patron')
require('author')
require('checkout')
require('pry')

DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM books;")
    DB.exec("DELETE FROM checkouts;")
    DB.exec("DELETE FROM patron;")
    DB.exec("DELETE FROM author;")
  end
end
