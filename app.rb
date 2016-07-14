require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/books')
require('./lib/author')
require('./lib/patron')
require('./lib/checkout')
require('date')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @books = Book.all()
  @authors = Author.all()
  # @patrons = Patron.all()
  erb(:index)
end

get('/books') do
  @books = Book.all()
  @authors = Author.all()
  # @patrons = Patron.all()
  erb(:index)
end

get('/authors') do
  @books = Book.all()
  @authors = Author.all()
  erb(:index)
end

post('/books') do
  title = params.fetch('title')
  author_name = params.fetch('author_id')
  author = Author.new({:author_name => author_name, :id => nil})
  author.save()
  book = Book.new({:title => title, :author_id => author.id(), :id => nil})
  book.save()
  @book = book
  @books = Book.all()
  @author = author
  @authors = Author.all()

  erb(:index)
end

get('/books/:id') do
  @book = Book.find(params.fetch('id').to_i())
  @patrons = Patron.all()
  erb(:book)
end

post('/authors') do
  title = params.fetch('title')
  author_name = params.fetch('author_id')
  author = Author.new({:author_name => author_name, :id => nil})
  author.save()
  book = Book.new({:title => title, :author_id => author.id(), :id => nil})
  book.save()
  @book = book
  @books = Book.all()
  @author = author
  @authors = Author.all()
  erb(:index)
end

delete('/books/delete/') do
  @book = Book.find(params.fetch('book_id').to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end

patch('/books/update/:id') do
  title = params.fetch("title")
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title =>title})
  erb(:book)
end

get('/patrons') do
  @patrons = Patron.all
  erb(:patrons)
end

post('/patrons') do
  patron_name = params.fetch("patron_name")
  patron = Patron.new({:patron_name => patron_name, :id => nil})
  patron.save()
  @patrons = Patron.all
  erb(:patrons)
end

get('/patrons/:id') do
  @patron = Patron.find(params.fetch("id").to_i())
  @patrons = Patron.all
  @books = Book.all
  erb(:patrons_checkout)
end


post('/patrons/:id') do
  @patron = Patron.find(params.fetch("id").to_i())
  @books = Book.all()
  erb(:patrons_checkout_success)
end

get('/books/checkout/:id') do
  @checkouts = Checkout.all()
  erb(:patrons_checkout_success)
end

post('/books/checkout/:id') do
  checkout_date = Date.today()
  book_id = params.fetch("book_id").to_i()
  patron_id = params.fetch("id").to_i()
  checkout = Checkout.new({:checkout_date => checkout_date, :book_id => book_id, :patron_id => patron_id, :id => nil})
  checkout.save()
  @checkout = checkout
  @patron = Patron.find(params.fetch("id").to_i())
  @patrons = Patron.all
  @book = Book.find(params.fetch("book_id").to_i())
  @books = Book.all()
  erb(:patrons_checkout_success)
end
