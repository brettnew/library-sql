require('rspec')
require('pg')
require('books')
require('patron')
require('pry')

DB = PG.connect({:dbname => "library"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books")
    DB.exec("DELETE FROM checkouts")
    DB.exec("DELETE FROM patron")
  end
end
